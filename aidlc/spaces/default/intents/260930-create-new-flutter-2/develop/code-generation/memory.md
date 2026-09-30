# Code Generation — Memory Diary

## Interpretation

- 2026-09-30 — Read `for_each: unit-breakdown` as "implement all ready units in
  dependency order, then report once", since the stage produces a single
  `source-changes` record. U1–U4 were implemented, U5/U6 verified.
- 2026-09-30 — Treated "verify locally" as: `flutter analyze`, `flutter test`,
  and a macOS build; the interactive `flutter run` was launched and observed
  rather than hand-driven, because this is an unattended run (REG-R2).

## Deviation

- 2026-09-30 — Removed the generated `cupertino_icons` direct dependency so the
  example matches `1-hello-world` (SDK + `material_ui` only). Recorded as D1 in
  `code-generation-notes.md`; reversible in one line if review disagrees.
- 2026-09-30 — Did not hand-tap the running app; relied on widget tests for
  behaviour and on the run for launch evidence. Recorded as D2.

## Tradeoff

- 2026-09-30 — Kept the generated platform folders committed and untouched
  (matching example 1) instead of trimming them. Cost: a large generated tree in
  the diff. Benefit: the example is exactly reproducible from `flutter create`.

## Open question

- 2026-09-30 — The Xcode warning about the Flutter-generated "Run Script" phase
  lacking declared outputs is inherited from the template and unrelated to the
  authored code. Note it for the Refactoring stage in case the repo wants a
  documented workaround; do not hand-edit generated Xcode projects.
