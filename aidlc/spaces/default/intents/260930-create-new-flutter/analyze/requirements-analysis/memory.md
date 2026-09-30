# Requirements Analysis — Memory Diary

## Interpretation

- 2026-09-30 — Treated Q4 answer A (keep default `flutter_lints`) as a
  *should* rather than a *must* for zero analyzer issues, so the requirement
  stays honest about generated-code noise.
- 2026-09-30 — Chose "errors only" for NFR-3 rather than a fully clean analyze
  run, since the human declined the stricter zero-issues option.

## Tradeoff

- 2026-09-30 — Kept a single `lib/main.dart` entrypoint (NFR-4) instead of
  splitting a greeting widget into its own file; optimises for first-example
  readability over structure that later examples may want.

## Open question

- 2026-09-30 — Should later examples keep `flutter_lints` defaults, or does the
  repo want a shared `analysis_options.yaml`? Revisit once a second example
  exists.
