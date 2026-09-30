# Intent Capture Questions

Intent: `260930-create-new-flutter-2`
Scope: `classic` · Phase: Analyze · Stage: Intent Capture
Mode: `yolo` — questions are not put to the human; the recommended answer is
selected and recorded, per the stage protocol.

---

## Q1: What should the example demonstrate?

A. A counter whose value changes when the user activates a control — the
   canonical smallest `StatefulWidget` example. **← recommended**
B. A boolean toggle (e.g. on/off) rendered by a switch.
C. A text field whose value is held in widget state.
D. Other (describe)

[Answer]: A — counter with an increment control.
Recommendation: A. It is the smallest demonstration of mutable state, matches
Flutter's own counter template, and keeps the diff readable.

## Q2: Which state mechanism should it use?

A. Flutter's built-in `StatefulWidget` + `State` + `setState`. **← recommended**
B. `ValueNotifier` / `ValueListenableBuilder`.
C. A third-party state-management package.
D. Other (describe)

[Answer]: A — built-in `StatefulWidget` / `setState`.
Recommendation: A. The intent is explicitly "using Stateful pattern"; adding a
package would obscure the framework primitive being taught.

## Q3: Confirm the example directory name.

A. `2-statefull/`, exactly as requested. **← recommended**
B. `2-stateful/` (corrected spelling).
C. Other (describe)

[Answer]: A — `2-statefull/`.
Recommendation: A. Preserves the user's literal request and the `N-slug`
convention already established by `1-hello-world`. Spelling flagged as an open
question in the stage memory so it can be corrected cheaply if desired.

## Q4: How much state should the example hold?

A. A single integer with one increment action. **← recommended**
B. An integer with increment + decrement + reset actions.
C. Multiple independent state fields.
D. Other (describe)

[Answer]: B — increment, decrement, and reset.
Recommendation: B. Three actions on one field stay within one file while making
it unambiguous which values are state vs. derived. B is the stage's choice; A is
the absolute minimum if review asks to trim.

## Q5: What automated verification ships with it?

A. One widget test that taps the action and asserts the displayed value changed.
   **← recommended**
B. A test that only asserts the initial value renders.
C. No test.
D. Other (describe)

[Answer]: A — widget test asserting a state change.
Recommendation: A. Matches the organisation rule that every requirement has a
testable criterion, and mirrors the first example's widget test.

---

## Resolution

No contradictions or unresolved ambiguity. Recommended answers A/A/A/B/A were
selected and are carried into `intent-statement.md`. The directory spelling in
Q3 is preserved as requested and recorded as a deferred open question rather
than silently corrected.
