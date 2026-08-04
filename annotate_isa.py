#!/usr/bin/env python3
"""Annotate a disassembly with PC-sampling stall counts, per instruction.

The aggregate reports say "buffer_load_dwordx4 stalls 78% of the time". They
cannot say WHICH of the 40 buffer_loads, because rocprofv3's csv export drops
the program counter -- it keeps only the disassembled instruction TEXT, and in
an unrolled GEMM the same text appears many times.

The json export keeps the PC:

    record.pc.code_object_id
    record.pc.code_object_offset     <- byte offset into the code object

which joins exactly onto ``llvm-objdump`` output, since objdump prints that
same byte offset for every instruction. So every sample lands on one specific
line of the ISA and the result is the disassembly with a stall histogram in
the margin.

Getting the code object
-----------------------
FlyDSL's ``FLYDSL_DUMP_IR=1`` dump does not include byte offsets, so do not
disassemble ``21_final_isa.s``. Extract the real ELF instead -- this script
does it for you when given the dump directory:

    ./annotate_isa.py r_results.json --dump-dir /tmp/isa/kernel_gemm_0

or point it at an already-extracted object:

    ./annotate_isa.py r_results.json --code-object kernel.hsaco

Usage
    ./annotate_isa.py r_results.json --dump-dir DIR -o annotated.s
    ./annotate_isa.py r_results.json --dump-dir DIR --only v_mfma_scale --top 20
    ./annotate_isa.py r_results.json --dump-dir DIR --reason ALU_DEPENDENCY --top 20
"""
import argparse
import collections
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

REASON_PREFIX = "ROCPROFILER_PC_SAMPLING_INSTRUCTION_NOT_ISSUED_REASON_"

SHORT = {
    "ARBITER_WIN_EX_STALL": "ARB_WIN_EX",
    "ALU_DEPENDENCY": "ALU_DEP",
    "NO_INSTRUCTION_AVAILABLE": "NO_INST_AVAIL",
    "ARBITER_NOT_WIN": "ARB_NOT_WIN",
    "INTERNAL_INSTRUCTION": "INTERNAL",
    "OTHER_WAIT": "OTHER_WAIT",
    "WAITCNT": "WAITCNT",
    "BARRIER_WAIT": "BARRIER",
    "SLEEP_WAIT": "SLEEP",
    "EXP_CNT": "EXP_CNT",
}


def short_reason(raw):
    r = raw[len(REASON_PREFIX):] if raw.startswith(REASON_PREFIX) else raw
    return SHORT.get(r, r)


def extract_code_object(dump_dir):
    """Pull the embedded ELF out of the gpu-module-to-binary MLIR dump."""
    cands = [f for f in os.listdir(dump_dir) if "gpu_module_to_binary" in f]
    if not cands:
        sys.exit(f"no *gpu_module_to_binary* file in {dump_dir}")
    text = open(os.path.join(dump_dir, cands[0])).read()
    m = re.search(r'bin\s*=\s*"((?:[^"\\]|\\.)*)"', text, re.S)
    if not m:
        sys.exit(f"no bin = \"...\" blob in {cands[0]}")

    raw, out, i = m.group(1), bytearray(), 0
    hexd = "0123456789ABCDEFabcdef"
    esc = {"n": 10, "t": 9, "r": 13, "\\": 92, '"': 34}
    while i < len(raw):
        if raw[i] == "\\":
            nxt = raw[i + 1]
            if nxt in hexd and raw[i + 2] in hexd:
                out.append(int(raw[i + 1:i + 3], 16))
                i += 3
                continue
            out.append(esc.get(nxt, ord(nxt)))
            i += 2
            continue
        out.append(ord(raw[i]))
        i += 1

    if bytes(out[:4]) != b"\x7fELF":
        sys.exit("extracted blob is not an ELF")
    path = os.path.join(tempfile.mkdtemp(), "kernel.hsaco")
    open(path, "wb").write(bytes(out))
    return path


def find_objdump():
    for c in ("llvm-objdump", "/opt/rocm/llvm/bin/llvm-objdump"):
        if shutil.which(c) or os.path.exists(c):
            return c
    sys.exit("llvm-objdump not found")


def disassemble(code_object, mcpu):
    """-> list of (offset|None, text). Non-instruction lines get offset None."""
    out = subprocess.run(
        [find_objdump(), "-d", f"--mcpu={mcpu}", code_object],
        capture_output=True, text=True,
    ).stdout
    rows = []
    for line in out.splitlines():
        # "\tinst operands   // 000000001A00: C0060500 0000004C"
        m = re.search(r"//\s*([0-9A-Fa-f]{6,}):\s*[0-9A-Fa-f]", line)
        if m:
            rows.append((int(m.group(1), 16), line.split("//")[0].rstrip()))
        else:
            rows.append((None, line.rstrip()))
    if not any(o is not None for o, _ in rows):
        sys.exit("objdump produced no address-annotated instructions")
    return rows


def load_samples(path, want_dispatch=None):
    d = json.load(open(path))["rocprofiler-sdk-tool"][0]
    recs = d["buffer_records"].get("pc_sample_stochastic") or []
    if not recs:
        recs = d["buffer_records"].get("pc_sample_host_trap") or []
    if not recs:
        sys.exit("no pc_sample_* records in json")

    # per (code_object_id, offset): total, stalled, Counter(reason)
    per = collections.defaultdict(lambda: {"n": 0, "stalled": 0, "why": collections.Counter()})
    co_hits = collections.Counter()
    for r in recs:
        rec = r["record"]
        if want_dispatch is not None and rec.get("dispatch_id") != want_dispatch:
            continue
        pc = rec["pc"]
        cid, off = pc["code_object_id"], pc["code_object_offset"]
        co_hits[cid] += 1
        e = per[(cid, off)]
        e["n"] += 1
        if not rec.get("wave_issued", 0):
            e["stalled"] += 1
            e["why"][short_reason(rec.get("snapshot", {}).get("stall_reason", "?"))] += 1
    return per, co_hits


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("json", help="rocprofv3 --output-format json result file")
    ap.add_argument("--dump-dir", help="FLYDSL_DUMP_IR dir (extracts the ELF itself)")
    ap.add_argument("--code-object", help="pre-extracted .hsaco / ELF")
    ap.add_argument("--mcpu", default="gfx950")
    ap.add_argument("--dispatch", type=int, help="restrict to one dispatch id")
    ap.add_argument("--only", help="substring: annotate only matching opcodes")
    ap.add_argument("--reason", help="rank by this stall reason, e.g. ALU_DEPENDENCY")
    ap.add_argument("--top", type=int, help="print only the N hottest lines")
    ap.add_argument("--min-stalled", type=int, default=1)
    ap.add_argument("-o", "--out")
    a = ap.parse_args()

    if not (a.dump_dir or a.code_object):
        ap.error("need --dump-dir or --code-object")
    obj = a.code_object or extract_code_object(a.dump_dir)

    per, co_hits = load_samples(a.json, a.dispatch)
    rows = disassemble(obj, a.mcpu)
    isa_offsets = {o for o, _ in rows if o is not None}

    # Pick the code object whose offsets actually land on this disassembly.
    best, best_hit = None, -1
    for cid in co_hits:
        hit = sum(v["n"] for (c, o), v in per.items() if c == cid and o in isa_offsets)
        if hit > best_hit:
            best, best_hit = cid, hit
    total = sum(co_hits.values())
    matched = best_hit
    per = {o: v for (c, o), v in per.items() if c == best}

    lines = []
    p = lines.append
    p(f"; PC-sampling annotated disassembly   ({os.path.basename(a.json)})")
    p(f"; code_object_id={best}  samples={total}  landed on an instruction={matched}"
      f" ({100.0*matched/total:.1f}%)" if total else "; no samples")
    if a.dispatch is not None:
        p(f"; restricted to dispatch_id={a.dispatch}")
    p("; columns:  STALLED/SAMPLED  REASON=COUNT ...  (every reason, not just the top one)")
    p("")

    short_want = SHORT.get(a.reason, a.reason) if a.reason else None

    def reasons(e):
        """All stall reasons for one PC, hottest first. A single instruction
        routinely stalls for more than one reason across its samples -- an MFMA
        can be both waiting on an operand and losing the execution unit -- so
        printing only the dominant one hides up to half the story."""
        return " ".join(f"{r}={c}" for r, c in e["why"].most_common())

    # Align the margin to the widest real instruction rather than a guessed
    # constant: op_sel/cbsz/blgp-decorated MFMAs run far past 100 columns.
    width = max((len(t) for o, t in rows if o is not None), default=80) + 2

    def key(off):
        e = per.get(off)
        if not e:
            return 0
        return e["why"].get(short_want, 0) if short_want else e["stalled"]

    if a.top:
        hot = sorted((o for o in per if o in isa_offsets), key=key, reverse=True)
        if a.only:
            text = {o: t for o, t in rows if o is not None}
            hot = [o for o in hot if a.only in text.get(o, "")]
        hot = [o for o in hot if key(o) >= a.min_stalled][: a.top]
        want = set(hot)
        p(f"; TOP {len(hot)} lines by {short_want or 'stalled'}" + (f" among '{a.only}'" if a.only else ""))
        p("")
        text = {o: t for o, t in rows if o is not None}
        for o in hot:
            e = per[o]
            p(f"  0x{o:06x}  {e['stalled']:5d}/{e['n']:<5d} {reasons(e):<40}  {text[o].strip()}")
        out = "\n".join(lines) + "\n"
    else:
        for o, t in rows:
            e = per.get(o) if o is not None else None
            if e and e["stalled"] >= a.min_stalled and (not a.only or a.only in t):
                p(f"{t:<{width}} ; {e['stalled']:5d}/{e['n']:<5d} {reasons(e)}")
            else:
                p(t)
        out = "\n".join(lines) + "\n"

    if a.out:
        open(a.out, "w").write(out)
        print(f"wrote {a.out} ({len(lines)} lines); "
              f"{matched}/{total} samples landed on an instruction")
    else:
        sys.stdout.write(out)


if __name__ == "__main__":
    main()
