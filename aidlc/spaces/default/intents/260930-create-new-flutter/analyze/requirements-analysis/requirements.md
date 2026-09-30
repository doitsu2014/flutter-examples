# Requirements — Flutter "Hello World" Example

- **Intent ID**: `260930-create-new-flutter`
- **Source**: `analyze/intent-capture/intent-statement.md`
- **Scope**: classic

Requirement types: **F** functional, **NF** non-functional, **C** constraint,
**A** assumption. Priority: MoSCoW (Must / Should / Could / Won't).

## Functional

### FR-1 — App displays the greeting (Must)

- **Statement**: Launching the app renders the text "Hello World" on screen.
- **Source**: Intent statement §3 SC-1.
- **Acceptance criteria**:
  - Given the app is launched, when the first frame is rendered, then the text
    "Hello World" is visible.
- **Verification**: `flutter run` on the local desktop target, visual check; also
  asserted by `flutter test` (see FR-3).

### FR-2 — Standard, conventional project structure (Must)

- **Statement**: The project is a single Flutter application named `hello_world`
  created by the Flutter tooling, laid out at the repository root with the
  conventional structure (`lib/`, `test/`, `pubspec.yaml`, platform folders).
- **Source**: Intent statement §3 SC-3, §4; Q1 answer A.
- **Acceptance criteria**:
  - Given a checkout of the repository, when the root is listed, then a
    `hello_world/` directory exists containing `pubspec.yaml`, `lib/`, `test/`.
  - `pubspec.yaml` declares package name `hello_world`.
- **Verification**: Directory/path inspection of the committed tree.

### FR-3 — Automated widget test (Must)

- **Statement**: A widget test asserts that the app renders "Hello World".
- **Source**: Intent statement §3 SC-2, §4; Q5 answer A.
- **Acceptance criteria**:
  - Given the test suite, when `flutter test` runs, then it exits 0 and the test
    finds the text "Hello World" in the widget tree.
- **Verification**: `flutter test`.

## Non-Functional

### NFR-1 — Runs on the local Flutter toolchain (Must)

- **Statement**: The app builds and runs against the Flutter SDK installed on
  the development machine without extra setup.
- **Source**: Intent statement §6; Q2 answer A (desktop verified).
- **Acceptance criteria**:
  - Given the documented Flutter SDK is installed, when `flutter run -d <desktop>`
    is executed in `hello_world/`, then the app launches successfully.
- **Verification**: Manual run on the available desktop device.

### NFR-2 — Minimal footprint (Must)

- **Statement**: The example depends only on the Flutter SDK and the default
  `flutter_lints`; no third-party runtime packages.
- **Source**: Intent statement §5 (out of scope); Q4 answer A.
- **Acceptance criteria**:
  - Given `pubspec.yaml`, when its dependency sections are read, then no
    third-party runtime dependency is declared.
- **Verification**: `pubspec.yaml` inspection.

### NFR-3 — Static analysis baseline (Should)

- **Statement**: The app ships with the generated default
  `analysis_options.yaml` using `flutter_lints`, and introduces no analyzer
  errors.
- **Source**: Q4 answer A.
- **Acceptance criteria**:
  - Given the project, when `flutter analyze` runs, then there are no errors
    (warnings/infos from generated code are acceptable).
- **Verification**: `flutter analyze`.

### NFR-4 — Readable as a first example (Should)

- **Statement**: `lib/` contains a single short, well-structured entrypoint
  (`main.dart` with a small widget) that a Flutter newcomer can read end to end.
- **Source**: Intent statement §2 (secondary users), §1.
- **Acceptance criteria**:
  - Given `lib/`, when read, then the app logic is contained in one file with no
    superfluous scaffolding.
- **Verification**: Code review.

## Constraints

### CR-1 — Bare minimum, no extra features (Must)

- **Statement**: No state management, routing, networking, persistence, CI/CD,
  deployment, native platform code, web hosting, theming, or polished UI.
- **Source**: Intent statement §5; Q3 answer A (Flutter defaults).
- **Acceptance criteria**:
  - Given the full diff, when reviewed, then none of the excluded areas appear.
- **Verification**: Diff review.

## Assumptions

### AR-1 — Flutter SDK available (Must be validated)

- **Statement**: A working Flutter SDK is installed and on `PATH`, with a
  desktop device available.
- **Source**: Intent statement §7.
- **Acceptance criteria**:
  - `flutter --version` and `flutter devices` succeed before implementation.
- **Verification**: Run the commands; if the assumption fails, revisit scope.

## Traceability

| Requirement | Intent source |
| --- | --- |
| FR-1 | §3 SC-1 |
| FR-2 | §3 SC-3, §4 |
| FR-3 | §3 SC-2, §4 |
| NFR-1 | §6, Q2 |
| NFR-2 | §5, Q4 |
| NFR-3 | Q4 |
| NFR-4 | §2 |
| CR-1 | §5 |
| AR-1 | §7 |

No orphan requirements. Every requirement has at least one testable acceptance
criterion.
