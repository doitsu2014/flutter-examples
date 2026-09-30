# Test Plan — Memory Diary

## Interpretation

- 2026-09-30 — Ranked FR-3's floor boundary above the increment happy path: the
  happy path is trivial to get right, while the guard is the one place the
  advertised invariant can silently break.
- 2026-09-30 — Chose widget tests as the *primary* level and explicitly declined
  a unit level, because the example has no pure functions and inventing a model
  layer to unit-test would contradict ADR-003 (single inline widget).

## Tradeoff

- 2026-09-30 — No `integration_test` package. Cost: no automated device-level
  test. Benefit: no extra setup or dependency, and the widget tests already
  exercise the real contract. The manual macOS run covers launch only.

## Open question

- 2026-09-30 — Whether the repo wants a documented line-coverage floor for
  examples. Judged not meaningful for an 87-line teaching file; requirement
  coverage is used instead.
