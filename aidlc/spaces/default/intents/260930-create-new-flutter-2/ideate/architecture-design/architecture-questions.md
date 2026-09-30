# Architecture Design Questions

Intent: `260930-create-new-flutter-2`
Scope: `classic` · Phase: Ideate · Stage: Architecture Design
Mode: `yolo` — recommended answers selected and recorded.

---

## Q1: Where should the mutable counter state live?

A. A single `int` field on a `State<CounterPage>` object, scoped to the page.
   **← recommended**
B. An app-level state object above `MaterialApp`, shared globally.
C. A `ValueNotifier<int>` outside the widget tree.
D. Other (describe)

[Answer]: A — local to the page's `State`.
Recommendation: A. The value is needed by one screen; lifting it would add
plumbing that teaches nothing at this level (CR-1).

## Q2: How should the UI be composed?

A. One `StatefulWidget` whose `State` builds the whole page inline.
   **← recommended**
B. A stateful parent with a separate stateless display widget receiving
   `count`.
C. A stateful parent with several extracted presentational widgets.
D. Other (describe)

[Answer]: A — single `StatefulWidget`, inline UI.
Recommendation: A. Keeps the whole example in one file (NFR-4/CON-5) and keeps
the rebuild story visible in one `build` method.

## Q3: Should the counter be floored at zero?

A. Yes — decrement is a no-op at `0`. **← recommended**
B. No — allow negative values.
C. Yes, and disable the decrement control at `0`.
D. Other (describe)

[Answer]: A — guard inside `setState`.
Recommendation: A. Makes the "state → UI" rule explicit and gives the widget
test a second meaningful case; C adds disabled-state UI that is out of scope.

## Q4: Material baseline and controls?

A. Flutter defaults (Material 3) from the current template; a `Scaffold` with
   `AppBar`, a large centered `Text`, and standard Material buttons.
   **← recommended**
B. Explicitly pinned Material 2 styling.
C. A custom-themed, polished layout.
D. Other (describe)

[Answer]: A — template defaults, standard Material controls.
Recommendation: A. Keeps the diff about state, not styling; matches example 1.

## Q5: How should the state-change callback be exercised in tests?

A. Widget tests using `WidgetTester` (`pumpWidget`, `tap`, `pump`, `expect`).
   **← recommended**
B. Widget tests plus golden-image assertions.
C. Integration test driving the real app.
D. Other (describe)

[Answer]: A — standard widget tests.
Recommendation: A. Fast, headless, and sufficient (REG-R2); goldens add
brittleness for no architectural benefit here.

## Q6: File layout inside `lib/`?

A. Everything in `lib/main.dart`, no extra source files. **← recommended**
B. `lib/main.dart` plus `lib/counter_page.dart`.
C. A `lib/src/` tree with widgets and models separated.
D. Other (describe)

[Answer]: A — single `lib/main.dart`.
Recommendation: A. NFR-4 and CON-5 require it; the entire example fits in one
readable file.

---

## Resolution

No contradictions. Recommended answers A/A/A/A/A/A are reflected in
`architecture-doc.md`. Q2's rejected alternatives (stateful/stateless split,
finer-grained rebuilds) are recorded as Option B/C with the reason for
deferral, so the decision is not silent.
