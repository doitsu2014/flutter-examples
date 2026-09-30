# Intent Statement — Flutter "Hello World" Example

- **Intent ID**: `260930-create-new-flutter`
- **Space**: default
- **Scope**: classic
- **Captured**: 2026-09-30

## 1. Problem

This repository is currently empty of code. There is no working Flutter
baseline, so the examples effort has nothing to build on and every contributor
starts from scratch. We need a first, minimal, working Flutter application that
establishes the project structure and conventions the remaining examples will
follow.

## 2. Users

- **Primary**: maintainers of this Flutter examples repository, who will run,
  read, extend, and replicate this example.
- **Secondary**: developers new to Flutter who read the example to learn the
  basic shape of a Flutter app.

## 3. Success Criteria (observable)

| # | Criterion | How we verify |
| --- | --- | --- |
| SC-1 | Running the app displays "Hello World" | `flutter run`, observe the text on screen |
| SC-2 | The test suite passes | `flutter test` exits 0 |
| SC-3 | The project lives inside this repository with a tidy, conventional structure | Directory review of the committed tree |

## 4. In Scope

- A single, newly created Flutter application that renders "Hello World".
- Standard Flutter project structure produced by the Flutter tooling.
- One automated widget test asserting the app renders the greeting.

## 5. Out of Scope

- State management, routing, networking, persistence, and third-party packages
  — this is a bare-minimum example.
- CI/CD, deployment, and release tooling.
- Native platform work (iOS/Android native code) and web hosting.
- Design system, theming, or polished UI beyond Flutter defaults.

## 6. Constraints

- **Deadline / budget**: none — no date pressure.
- **Regulatory**: none.
- **Technical**: must build and run with the repo's local Flutter toolchain.

## 7. Assumptions

- A working Flutter SDK is installed and available on `PATH`.
- A desktop target is available locally, since success is verified with
  `flutter run` and `flutter test`.

## 8. Cost of Doing Nothing

Nothing urgent breaks, but the repository stays empty, the examples effort
cannot begin, and this first step blocks every later example.

## 9. Source Traceability

| Statement | Source |
| --- | --- |
| Problem, users, success criteria, constraints | User request + Intent Capture answers (Q1–Q5 all "A") |
