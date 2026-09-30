# API Contract Design — Memory Diary

## Interpretation

- 2026-09-30 — Read "API contract" for a UI-only example as the **widget
  interface**: constructor, behavioural postconditions, and stable test
  selectors. There is no HTTP surface to design, so inventing endpoints would be
  noise. The stage is marked `execution: ALWAYS`, so it was run rather than
  skipped and produced a real contract.
- 2026-09-30 — Modelled the decrement-at-zero no-op as the analogue of an error
  response, because the example deliberately has no error surface.

## Tradeoff

- 2026-09-30 — Specified a `ValueKey('counter-value')` and tooltips on the
  action buttons. Cost: a little extra markup a beginner must read. Benefit: a
  stable selector contract and free accessibility labels, so tests do not depend
  on layout or on the exact button widget type.

## Open question

- 2026-09-30 — Concrete widget types for the three controls (e.g. `IconButton`
  vs `FilledButton.icon`) are still open and deferred to the Technical
  Specification. The contract fixes only the tooltips, so either choice is
  compatible.
