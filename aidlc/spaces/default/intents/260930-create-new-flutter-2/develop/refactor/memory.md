# Refactoring — Memory Diary

## Interpretation

- 2026-09-30 — Read the stage condition ("runs when review reveals structural
  debt worth addressing now") as met only for the one finding the reviewer
  explicitly handed here (F-1). Applied exactly that, nothing more.
- 2026-09-30 — Treated the change as a refactor, not a feature: assertions now
  read the value through the declared key, but the scenarios and expected values
  are identical, so behaviour is untouched.

## Tradeoff

- 2026-09-30 — Added a three-line helper to the test file for key-based reads.
  Cost: one indirection in the tests. Benefit: tests are pinned to the declared
  contract (`api-contract.md` I-3) and no longer depend on `find.text` matching a
  bare digit. `lib/main.dart` stays untouched, so NFR-4 is unaffected.

## Open question

- 2026-09-30 — Whether key-based assertions should become the repo's house style
  for widget tests (raised in `code-review/memory.md`) is still open. This
  example now uses them, which is a slight precedent should a second test file
  appear.
