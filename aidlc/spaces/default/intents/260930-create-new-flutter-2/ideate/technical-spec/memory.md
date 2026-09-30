# Technical Specification — Memory Diary

## Interpretation

- 2026-09-30 — Specified "the contract, not the code", but included a short
  reference snippet for `CounterPage` and the exact member semantics, because
  the Develop stage must produce byte-compatible behaviour with the widget tests
  and the `api-contract.md` selectors.
- 2026-09-30 — Resolved the open button-widget question by fixing all three
  action controls to `IconButton` with tooltips. This keeps the selector
  contract (ADR-005) uniform and makes the Reset control a tooltip target like
  the other two.

## Tradeoff

- 2026-09-30 — Tests pump `MainApp` rather than `CounterPage` directly. Cost: the
  tests cover the `MaterialApp` shell too, which is marginally broader than the
  behavioural contract. Benefit: entry-point wiring is exercised, matching how a
  reader actually runs the app.

## Open question

- 2026-09-30 — None blocking. The only residual item is `2-statefull` spelling
  (ADR-008), now decided to remain verbatim for this intent.
