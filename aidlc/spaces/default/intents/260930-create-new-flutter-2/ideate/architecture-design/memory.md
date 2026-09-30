# Architecture Design — Memory Diary

## Interpretation

- 2026-09-30 — Treated "architecture" for a single-file example as the small
  set of irreversible choices (where state lives, what compiles into the app
  shell), not as a component inventory. Documentation is proportional to the
  system, so the four options are deliberately small and the chosen one is the
  least clever.
- 2026-09-30 — Interpreted the `security-agent` review as explicitly *advisory*
  here (the stage declares `review_class: advisory`). Recorded "no trust
  boundary beyond local taps" and a supply-chain note rather than manufacturing
  findings.

## Tradeoff

- 2026-09-30 — Chose a single `StatefulWidget` (Option A) over a
  stateful/stateless composition (Option B). Cost: the example does not teach
  lifting state or keeping children stateless. Benefit: one readable `build`,
  one file, and no indirection masking the `setState` lesson.

## Deviation

- 2026-09-30 — YOLO mode: architecture questions answered with the recommended
  option and the gate auto-satisfied. Rejected alternatives are still recorded
  in `architecture-doc.md` §3 and §12 so the decision trail survives.

## Open question

- 2026-09-30 — `2-statefull` vs. `2-stateful` (REG-R4) is still open and now
  affects the Technical Specification's file paths. Recommend resolving at the
  Design Pattern Selection gate or before Code Generation.
