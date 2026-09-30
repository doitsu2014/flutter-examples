# Requirements Analysis Questions

Intent: `260930-create-new-flutter-2`
Scope: `classic` · Phase: Analyze · Stage: Requirements Analysis
Mode: `yolo` — recommended answers are selected and recorded, not put to the
human.

---

## Q1: What is the project's location and package name?

A. Wrapper directory `2-statefull/` containing the Flutter app at
   `2-statefull/flutter_application_2/`, package `flutter_application_2` —
   mirrors `1-hello-world/flutter_application_1`. **← recommended**
B. Flutter app directly at `2-statefull/`, package `statefull` (rename the
   wrapper away).
C. `2-statefull/` with a descriptive package such as `stateful_counter`.
D. Other (describe)

[Answer]: A — `2-statefull/flutter_application_2/`, package
`flutter_application_2`.
Recommendation: A. `2-statefull` is not a legal Dart package name (leading
digit, hyphen), and the nested `flutter_application_N` shape is already the
established convention from example 1.

## Q2: Which target must the example be verified on?

A. Desktop only (the locally available target). **← recommended**
B. Web only (`flutter run -d chrome`).
C. Desktop plus one mobile target.
D. Any single supported target.
X. Other (describe)

[Answer]: A — desktop only.
Recommendation: A. Matches example 1 and needs no extra toolchain.

## Q3: What Material/widget baseline should the example use?

A. Flutter defaults from `flutter create` (Material 3). **← recommended**
B. Explicitly pin `useMaterial3: true`.
C. Explicitly pin Material 2 for maximum compatibility.
D. No `MaterialApp` — a bare `WidgetsApp`.
X. Other (describe)

[Answer]: A — Flutter defaults (Material 3).
Recommendation: A. Same baseline as example 1; keeps the diff about state, not
theming.

## Q4: What actions should the counter expose?

A. Increment, decrement, and reset, with the value floored at `0`.
   **← recommended**
B. Increment only (smallest possible).
C. Increment and decrement, no reset.
D. Other (describe)

[Answer]: A — increment, decrement, reset.
Recommendation: A. Carried from Intent Capture Q4; three actions on one field
still fit one file and make "state vs. derived" unambiguous.

## Q5: How strict should static analysis be?

A. Keep the default generated `analysis_options.yaml` (`flutter_lints`); no
   analyzer errors. **← recommended**
B. Require zero issues of any severity.
C. Add stricter lints beyond `flutter_lints`.
D. No analysis requirement.
X. Other (describe)

[Answer]: A — default `flutter_lints`, no errors.
Recommendation: A. Consistent with example 1 and honest about generated-code
noise.

## Q6: What automated test coverage is required?

A. Widget tests that prove the initial value renders and that a tap changes it.
   **← recommended**
B. Initial-render test only.
C. Widget tests plus golden-file assertions.
D. No test requirement.
X. Other (describe)

[Answer]: A — initial-render plus state-change widget tests.
Recommendation: A. The state change is the whole point of the example; it must
be asserted, not just inspected.

---

## Resolution

No contradictions. Recommended answers A/A/A/A/A/A are carried into
`requirements.md`. Q1's package-name constraint is a genuine technical
requirement (Dart identifiers cannot start with a digit or contain hyphens), so
it is recorded as FR-5/CR-2 rather than left open.
