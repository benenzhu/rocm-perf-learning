#!/usr/bin/env python3
"""Aggregate a rocprofv3 stochastic PC-sampling CSV into a readable stall report.

rocprofv3 emits one row per sample; this turns that into the tables you
actually want: stall reasons, which instructions stall, and a reason x
instruction matrix.

Two filters matter and both are easy to miss:
  1. rows whose Instruction is empty  -- PC not resolvable to a code object
  2. samples from OTHER kernels       -- --kernel-include-regex does NOT filter
                                         the PC sampling stream

Usage
    # auto-detect the kernel by an opcode only it contains
    ./pc_sampling_report.py pc_pc_sampling_stochastic.csv --match v_mfma_scale

    # or name the dispatch ids directly
    ./pc_sampling_report.py pc_pc_sampling_stochastic.csv --dispatch 143,144,145,146

    # list dispatches and their opcode mix, then decide
    ./pc_sampling_report.py pc_pc_sampling_stochastic.csv --list
"""

import argparse
import collections
import csv
import sys

REASON = "ROCPROFILER_PC_SAMPLING_INSTRUCTION_NOT_ISSUED_REASON_"
ITYPE = "ROCPROFILER_PC_SAMPLING_INSTRUCTION_TYPE_"
VMEM_PREFIX = ("buffer_", "global_", "flat_", "scratch_")

# widest-first so the matrix columns line up
ORDER = [
    "ARBITER_WIN_EX_STALL",
    "BARRIER_WAIT",
    "ALU_DEPENDENCY",
    "WAITCNT",
    "NO_INSTRUCTION_AVAILABLE",
    "ARBITER_NOT_WIN",
    "INTERNAL_INSTRUCTION",
    "OTHER_WAIT",
]
ABBR = {
    "ARBITER_WIN_EX_STALL": "ARB_WIN_EX",
    "BARRIER_WAIT": "BARRIER",
    "ALU_DEPENDENCY": "ALU_DEP",
    "WAITCNT": "WAITCNT",
    "NO_INSTRUCTION_AVAILABLE": "NO_INST_AVAIL",
    "ARBITER_NOT_WIN": "ARB_NOT_WIN",
    "INTERNAL_INSTRUCTION": "INTERNAL",
    "OTHER_WAIT": "OTHER",
}


def reason(r):
    return r["Stall_Reason"].replace(REASON, "")


def itype(r):
    return r["Instruction_Type"].replace(ITYPE, "")


def opcode(r):
    return r["Instruction"].strip().split()[0]


def load(path):
    rows = list(csv.DictReader(open(path)))
    if rows and "Stall_Reason" not in rows[0]:
        sys.exit(
            "error: no Stall_Reason column -- this looks like host_trap output.\n"
            "       Re-run with --pc-sampling-method stochastic to get stall reasons."
        )
    return rows


def load_kernel_trace(path):
    """Dispatch_Id -> Kernel_Name from a rocprofv3 --kernel-trace csv."""
    m = {}
    for r in csv.DictReader(open(path)):
        if r.get("Kind") == "KERNEL_DISPATCH":
            m[r["Dispatch_Id"]] = r["Kernel_Name"]
    if not m:
        sys.exit(f"error: no KERNEL_DISPATCH rows in {path}")
    return m


def list_kernels(decoded, ktrace):
    if ktrace:
        by = collections.Counter(ktrace.get(r["Dispatch_Id"], "<unknown dispatch>") for r in decoded)
        print(f"{'SAMPLES':>8}   KERNEL")
        print("-" * 96)
        for name, n in by.most_common():
            print(f"{n:8d}   {name[:84]}")
        return
    print("no --kernel-trace given; showing dispatch ids and their opcode mix instead")
    print("(re-profile with --kernel-trace to get real kernel names)\n")
    by = collections.defaultdict(collections.Counter)
    for r in decoded:
        by[r["Dispatch_Id"]][opcode(r)] += 1
    print(f"{'DISPATCH':>10} {'SAMPLES':>8}   TOP OPCODES")
    print("-" * 88)
    for d, c in sorted(by.items(), key=lambda kv: -sum(kv[1].values())):
        top = ", ".join(f"{k}({v})" for k, v in c.most_common(4))
        print(f"{d:>10} {sum(c.values()):8d}   {top[:66]}")


def emit(out, rows, decoded, mine, dispatches, title, ktrace=None):
    L = []
    p = L.append

    def rule(c="="):
        p(c * 100)

    stalled = [r for r in mine if r["Wave_Issued_Instruction"] == "0"]
    issued = [r for r in mine if r["Wave_Issued_Instruction"] == "1"]
    if not stalled:
        sys.exit("error: no stalled samples after filtering -- check --dispatch/--match")

    rule()
    p(f"PC SAMPLING REPORT  --  {title}")
    rule()
    p(f"Samples  : {len(rows):6d}  raw")
    p(f"           {len(decoded):6d}  with decoded instruction text")
    p(f"           {len(decoded) - len(mine):6d}  from OTHER kernels -- EXCLUDED")
    sampled = sorted({r["Dispatch_Id"] for r in mine}, key=int)
    p(f"           {len(mine):6d}  from this kernel (dispatch {','.join(sampled)})")
    if ktrace:
        p(f"           kernel resolved via --kernel-trace (authoritative)")
    p(f"             -> {len(stalled)} stalled / {len(issued)} issued")
    p("")

    rule()
    p(f"1. STALL REASONS  (n={len(stalled)})")
    rule()
    p("")
    c = collections.Counter(reason(r) for r in stalled)
    tot = sum(c.values())
    p(f"  {'REASON':<26} {'COUNT':>8} {'PCT':>8}")
    p("  " + "-" * 80)
    for k, v in c.most_common():
        p(f"  {k:<26} {v:8d} {100*v/tot:6.1f}%   {'#' * round(46*v/tot)}")
    p("")
    p("  ARBITER_WIN_EX_STALL : won arbitration, execution unit refused it")
    p("                         -> downstream (TA / LDS / MFMA) is full. ISSUE STALL.")
    p("  ARBITER_NOT_WIN      : lost arbitration to another wave. Different problem.")
    p("  WAITCNT              : waiting on s_waitcnt for data. LATENCY, not issue.")
    p("")

    ex = collections.Counter(o for o in (opcode(r) for r in stalled if reason(r) == "ARBITER_WIN_EX_STALL"))
    if ex:
        te = sum(ex.values())
        rule()
        p("2. ARBITER_WIN_EX_STALL BY INSTRUCTION  (the issue-stall signal)")
        rule()
        p("")
        p(f"  Total: {te} samples ({100*te/tot:.1f}% of all stalls)")
        p("")
        p(f"  {'COUNT':>8} {'PCT':>8}   INSTRUCTION")
        p("  " + "-" * 80)
        for k, v in ex.most_common(15):
            p(f"  {v:8d} {100*v/te:7.1f}%   {k:<34} {'#' * round(38*v/te)}")
        vm = sum(v for k, v in ex.items() if k.startswith(VMEM_PREFIX))
        p("")
        p(f"  VMEM (buffer_*/global_*/flat_*): {vm} / {te} = {100*vm/te:.1f}%")
        p("")

    byop = collections.Counter(opcode(r) for r in stalled)
    rule()
    p("3. ALL STALLED INSTRUCTIONS")
    rule()
    p("")
    p(f"  {'STALLED':>8} {'PCT':>7}   INSTRUCTION")
    p("  " + "-" * 80)
    for k, v in byop.most_common(30):
        p(f"  {v:8d} {100*v/len(stalled):6.1f}%   {k}")
    p("")

    present = [r for r in ORDER if any(reason(x) == r for x in stalled)]
    rule()
    p("4. STALL REASON x INSTRUCTION")
    rule()
    p("")
    p(f"  {'INSTRUCTION':<26} " + " ".join(f"{ABBR[r]:>13}" for r in present) + f" {'TOTAL':>9}")
    p("  " + "-" * (28 + 14 * len(present) + 10))
    m = collections.defaultdict(collections.Counter)
    for r in stalled:
        m[opcode(r)][reason(r)] += 1
    for o, _ in byop.most_common(18):
        cells = " ".join(f"{m[o][r]:13d}" for r in present)
        p(f"  {o[:26]:<26} {cells} {sum(m[o].values()):9d}")
    p("")

    rule()
    p(f"5. INSTRUCTION TYPE MIX  (all samples, n={len(mine)})")
    rule()
    p("")
    ty = collections.Counter(itype(r) for r in mine)
    p(f"  {'TYPE':<24} {'COUNT':>8} {'PCT':>8}")
    p("  " + "-" * 46)
    for k, v in ty.most_common():
        p(f"  {k:<24} {v:8d} {100*v/len(mine):7.1f}%")
    p("")

    pc = collections.defaultdict(lambda: [0, collections.Counter()])
    for r in stalled:
        k = r["Instruction"].strip()
        pc[k][0] += 1
        pc[k][1][reason(r)] += 1
    rule()
    p("6. HOTTEST PCs  (top 30 by stalled samples)")
    rule()
    p("")
    p(f"  {'STALLED':>7}  {'DOMINANT':<14}  INSTRUCTION")
    p("  " + "-" * 96)
    for k, (n, rc) in sorted(pc.items(), key=lambda kv: -kv[1][0])[:30]:
        p(f"  {n:7d}  {ABBR.get(rc.most_common(1)[0][0], '?'):<14}  {k[:70]}")
    p("")
    rule()
    p("END OF REPORT")
    rule()

    text = "\n".join(L) + "\n"
    if out:
        open(out, "w").write(text)
        print(f"wrote {out} ({len(L)} lines)")
    else:
        print(text)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("csv", help="pc_pc_sampling_stochastic.csv from rocprofv3")
    ap.add_argument("--kernel-trace", help="kernel_trace csv from the same run (strongly recommended)")
    ap.add_argument("--kernel", help="keep dispatches whose Kernel_Name contains this (needs --kernel-trace)")
    ap.add_argument("--dispatch", help="comma-separated Dispatch_Id values to keep")
    ap.add_argument("--list", action="store_true", help="list what got sampled, then exit")
    ap.add_argument("-o", "--out", help="write report to this file (default: stdout)")
    ap.add_argument("--title", default="kernel", help="title for the report header")
    a = ap.parse_args()

    rows = load(a.csv)
    decoded = [r for r in rows if r["Instruction"].strip()]
    if not decoded:
        sys.exit("error: no samples with decoded instructions")

    ktrace = load_kernel_trace(a.kernel_trace) if a.kernel_trace else None

    if a.list:
        list_kernels(decoded, ktrace)
        return

    if a.kernel:
        if not ktrace:
            sys.exit("error: --kernel needs --kernel-trace (the PC csv has no kernel names)")
        keep = {d for d, n in ktrace.items() if a.kernel in n}
        if not keep:
            sys.exit(f"error: no kernel name contains {a.kernel!r} -- try --list")
        sampled = {r["Dispatch_Id"] for r in decoded}
        print(
            f"--kernel {a.kernel!r} -> {len(keep)} dispatches, "
            f"{len(keep & sampled)} of them sampled",
            file=sys.stderr,
        )
    elif a.dispatch:
        keep = set(a.dispatch.split(","))
        if not ktrace:
            print(
                "warning: no --kernel-trace, cannot verify these dispatches belong to one kernel",
                file=sys.stderr,
            )
    else:
        sys.exit("error: need --kernel (with --kernel-trace), --dispatch, or --list")

    mine = [r for r in decoded if r["Dispatch_Id"] in keep]
    if not mine:
        sys.exit("error: no samples matched those dispatch ids")
    emit(a.out, rows, decoded, mine, keep, a.title, ktrace)


if __name__ == "__main__":
    main()
