# Intent Statement — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Space**: default
- **Scope**: classic
- **Captured**: 2026-09-30

## 1. Problem

The repository has exactly one example, a stateless "Hello World", which never
holds mutable state. Contributors and learners therefore have no in-repo
reference for the most fundamental Flutter state mechanism: a `StatefulWidget`
whose `State` object owns mutable fields and rebuilds the UI through
`setState`. Every later example that needs interactivity (forms, lists,
animation, async) builds on that pattern, so the gap blocks the rest of the
examples library.

## 2. Users

- **Primary**: maintainers of this Flutter examples repository, who run, read,
  extend, and replicate each example.
- **Secondary**: developers new to Flutter who want to see the smallest correct
  use of `StatefulWidget` / `State` / `setState`.

## 3. Success Criteria (observable)

| # | Criterion | How we verify |
| --- | --- | --- |
| SC-1 | Running the app shows a counter starting at 0; activating the increment control updates the displayed value | `flutter run`, observe the number change on screen |
| SC-2 | The test suite passes, including a widget test that taps the control and asserts the state changed | `flutter test` exits 0 |
| SC-3 | The example lives in this repository at `2-statefull/` with the conventional Flutter structure and a short README explaining the pattern | Directory review of the committed tree |

## 4. In Scope

- One new Flutter application demonstrating the built-in `StatefulWidget` /
  `State` / `setState` pattern.
- A single piece of mutable state with one or more user actions that change it
  (counter increment, with decrement/reset as a small extension).
- One automated widget test asserting the state change is reflected in the UI.
- A brief README that names the pattern and points at the relevant code.

## 5. Out of Scope

- Third-party state management (Provider, Riverpod, Bloc, Redux, GetX) — this
  example deliberately shows the built-in mechanism only.
- Persistence, networking, routing, and dependency injection.
- CI/CD, deployment, release tooling, and web hosting.
- Native platform work, design system, theming, or polished UI beyond Flutter
  defaults.

## 6. Constraints

- **Deadline / budget**: none — no date pressure.
- **Regulatory**: none.
- **Technical**: must build, run, and test with the repository's local Flutter
  toolchain.
- **Naming**: the example directory is `2-statefull`, following the existing
  `1-hello-world` numbered-example convention. (The user's spelling is
  preserved verbatim; see the open question in the stage memory.)

## 7. Assumptions

- A working Flutter SDK is installed and available on `PATH` (verified:
  Flutter 3.49.0 / Dart 3.14.0).
- A desktop target is available locally, since success is verified with
  `flutter run` and `flutter test`.

## 8. Cost of Doing Nothing

Nothing breaks, but the examples library cannot teach the state pattern, later
interactive examples have no baseline to copy, and newcomers keep importing
third-party state libraries before understanding what the framework provides.

## 9. Source Traceability

| Statement | Source |
| --- | --- |
| Problem, users, success criteria, scope, naming | User request: "create new flutter example using Stateful pattern as 2-statefull" |
| Out-of-scope and constraints | Project convention from `1-hello-world` + organisation memory (minimal examples) |
| Flutter SDK assumption | Verified locally: `flutter --version` → 3.49.0 |
| Recommended answers (Q1–Q5) | YOLO mode recommendation policy, recorded in `intent-capture-questions.md` |
