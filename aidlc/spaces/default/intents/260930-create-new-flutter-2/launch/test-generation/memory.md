# Test Generation — Memory Diary

## Interpretation

- 2026-09-30 — The tests were authored alongside the code in U3, so this stage
  reviewed them against the approved test plan and recorded traceability rather
  than writing a second, redundant suite. It still counted Test Generation as
  executed, because the suite this stage is accountable for now exists and was
  re-run and stabilised.
- 2026-09-30 — Kept test names behaviour-first ("never goes below zero") rather
  than requirement-coded ("FR-3 …"), and recorded the requirement mapping
  explicitly in `test-suite.md`. Behaviour names read better in the runner;
  traceability lives in the table.

## Tradeoff

- 2026-09-30 — No `integration_test`-level test was added despite the stage
  being able to generate one. Cost: device-level behaviour is only smoke-tested
  manually. Benefit: no extra dependency or emulator requirement, and the widget
  tests already exercise the full contract.

## Open question

- 2026-09-30 — None new. The gaps (non-macOS platforms, a11y semantics,
  performance) are already recorded as accepted in `test-plan.md` §5.
