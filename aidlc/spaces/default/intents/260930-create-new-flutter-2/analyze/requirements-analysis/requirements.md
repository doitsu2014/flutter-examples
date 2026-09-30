# Requirements — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Source**: `analyze/intent-capture/intent-statement.md`
- **Scope**: classic

Requirement types: **F** functional, **NF** non-functional, **C** constraint,
**A** assumption. Priority: MoSCoW (Must / Should / Could / Won't).

## Functional

### FR-1 — Initial counter value is displayed (Must)

- **Statement**: On launch the app displays the integer `0` as the current
  counter value.
- **Source**: Intent statement §3 SC-1.
- **Acceptance criteria**:
  - Given the app is launched, when the first frame renders, then the text `0`
    is visible exactly once.
- **Verification**: Widget test asserts `find.text('0')`; `flutter run` visual
  check.

### FR-2 — Increment updates the displayed value (Must)

- **Statement**: Activating the increment control increases the counter by one
  and the UI immediately shows the new value.
- **Source**: Intent statement §3 SC-1; Q1/Q4 recommendations.
- **Acceptance criteria**:
  - Given the counter shows `0`, when the increment control is activated, then
    the displayed value becomes `1`.
  - Given the counter shows `0`, when increment is activated three times, then
    the displayed value becomes `3`.
- **Verification**: Widget test taps the increment control and asserts the
  updated text; `flutter run` visual check.

### FR-3 — Decrement and reset update the displayed value (Should)

- **Statement**: Activating decrement decreases the counter by one; activating
  reset returns it to `0`. The counter never displays a negative value.
- **Source**: Intent statement §3 SC-1; Q4 recommendation (answer B).
- **Acceptance criteria**:
  - Given the counter shows `2`, when decrement is activated, then the value
    becomes `1`.
  - Given the counter shows `0`, when decrement is activated, then the value
    stays `0`.
  - Given the counter shows any value, when reset is activated, then the value
    becomes `0`.
- **Verification**: Widget tests for each case.

### FR-4 — Mutable state lives in a `State` object and is mutated via `setState` (Must)

- **Statement**: The counter is a field on a `State` subclass of a
  `StatefulWidget`, and changes are applied with `setState` so the framework
  rebuilds the dependent UI.
- **Source**: Intent statement §1, §2, §4; user request ("using Stateful
  pattern").
- **Acceptance criteria**:
  - Given `lib/main.dart`, when read, then it contains a `StatefulWidget` and a
    corresponding `State` class, and every counter mutation occurs inside a
    `setState` callback.
  - No third-party state container is used (see CR-1).
- **Verification**: Code review; the widget tests in FR-2/FR-3 fail if state is
  not rebuilt.

### FR-5 — Conventional single-app structure inside `2-statefull/` (Must)

- **Statement**: The example is one Flutter application whose project root is
  `2-statefull/flutter_application_2/`, laid out with the conventional structure
  (`lib/`, `test/`, `pubspec.yaml`, platform folders).
- **Source**: Intent statement §3 SC-3, §4, §6; `1-hello-world` convention.
- **Acceptance criteria**:
  - Given a checkout, when the tree is listed, then
    `2-statefull/flutter_application_2/pubspec.yaml` and
    `2-statefull/flutter_application_2/lib/main.dart` exist.
  - `pubspec.yaml` declares package name `flutter_application_2`.
- **Verification**: Path inspection of the committed tree.

### FR-6 — Automated widget test proves the state change (Must)

- **Statement**: A widget test in `test/` activates the increment control and
  asserts the displayed value changed.
- **Source**: Intent statement §3 SC-2, §4; Q5 recommendation.
- **Acceptance criteria**:
  - Given the test suite, when `flutter test` runs, then it exits 0 and the test
    observes the counter change after a tap.
- **Verification**: `flutter test`.

### FR-7 — README explains the pattern (Should)

- **Statement**: `2-statefull/README.md` names the `StatefulWidget` / `State` /
  `setState` pattern, states how to run and test the example, and points at the
  relevant lines of `lib/main.dart`.
- **Source**: Intent statement §2 (secondary users), §3 SC-3.
- **Acceptance criteria**:
  - Given the README, when read, then it contains run and test commands and a
    pointer to the `State` class.
- **Verification**: Documentation review.

## Non-Functional

### NFR-1 — Runs on the local Flutter toolchain (Must)

- **Statement**: The app builds, runs, and tests against the Flutter SDK
  installed on the development machine without extra setup.
- **Source**: Intent statement §6, §7.
- **Acceptance criteria**:
  - Given the local Flutter SDK, when `flutter run -d <desktop>` is executed in
    the project root, then the app launches successfully.
- **Verification**: `flutter --version` then manual run on the available desktop
  device.

### NFR-2 — Minimal footprint (Must)

- **Statement**: The example depends only on the Flutter SDK, the default test
  SDK, and `flutter_lints`; no third-party runtime package.
- **Source**: Intent statement §5; `1-hello-world` convention; org memory.
- **Acceptance criteria**:
  - Given `pubspec.yaml`, when its dependency sections are read, then no
    third-party runtime dependency is declared.
- **Verification**: `pubspec.yaml` inspection.

### NFR-3 — Static analysis baseline (Should)

- **Statement**: The project ships with the generated default
  `analysis_options.yaml` using `flutter_lints` and introduces no analyzer
  errors.
- **Source**: `1-hello-world` convention (Q4 there); Q4 recommendation here.
- **Acceptance criteria**:
  - Given the project, when `flutter analyze` runs, then there are no errors.
- **Verification**: `flutter analyze`.

### NFR-4 — Readable as a teaching example (Should)

- **Statement**: The entire app — widget, state class, and UI — is contained in
  one short `lib/main.dart` that a Flutter newcomer can read end to end in a few
  minutes.
- **Source**: Intent statement §2; org memory ("minimal examples").
- **Acceptance criteria**:
  - Given `lib/`, when read, then the app logic is in a single file with no
    superfluous scaffolding or extracted abstractions.
- **Verification**: Code review.

## Constraints

### CR-1 — Built-in state only; no extra capabilities (Must)

- **Statement**: No third-party state management (Provider, Riverpod, Bloc,
  Redux, GetX); no persistence, networking, routing, CI/CD, deployment, native
  platform code, web hosting, theming, or polished UI.
- **Source**: Intent statement §5; Q2 recommendation.
- **Acceptance criteria**:
  - Given the full diff, when reviewed, then none of the excluded areas appear
    and no runtime dependency is added.
- **Verification**: Diff review.

### CR-2 — Example directory is named `2-statefull` (Must)

- **Statement**: The example follows the existing numbered convention and lives
  under `2-statefull/`.
- **Source**: User request; Intent statement §6.
- **Acceptance criteria**:
  - Given the repository root, when listed, then a `2-statefull/` directory
    exists next to `1-hello-world/`.
- **Verification**: Directory inspection.

## Assumptions

### AR-1 — Flutter SDK available (Must be validated)

- **Statement**: A working Flutter SDK is installed and on `PATH`.
- **Source**: Intent statement §7.
- **Acceptance criteria**:
  - `flutter --version` succeeds before implementation.
- **Verification**: Run the command. Status: **validated** —
  Flutter 3.49.0 / Dart 3.14.0 on `PATH`.

### AR-2 — A desktop device is available (Must be validated)

- **Statement**: At least one desktop target is available for the manual run in
  NFR-1.
- **Source**: Intent statement §7; Q2 recommendation.
- **Acceptance criteria**:
  - `flutter devices` lists a desktop target.
- **Verification**: Run the command before the manual run; if absent, verification
  falls back to `flutter test` only and the deviation is recorded.

## Traceability

| Requirement | Intent source |
| --- | --- |
| FR-1 | §3 SC-1 |
| FR-2 | §3 SC-1, Q1, Q4 |
| FR-3 | §3 SC-1, Q4 |
| FR-4 | §1, §2, §4, request |
| FR-5 | §3 SC-3, §4, §6 |
| FR-6 | §3 SC-2, §4, Q5 |
| FR-7 | §2, §3 SC-3 |
| NFR-1 | §6, §7 |
| NFR-2 | §5 |
| NFR-3 | §5, Q4 |
| NFR-4 | §2, §5 |
| CR-1 | §5, Q2 |
| CR-2 | §6, request |
| AR-1 | §7 |
| AR-2 | §7 |

No orphan requirements. Every requirement has at least one testable acceptance
criterion. Requirement → design → code → test tracing is maintained forward.
