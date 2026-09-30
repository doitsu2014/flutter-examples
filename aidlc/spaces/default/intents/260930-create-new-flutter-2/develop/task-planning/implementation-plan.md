# Implementation Plan — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `technical-spec.md`, `requirements.md`, `1-hello-world/` conventions
- **Status**: proposed — awaiting approval before any code is generated

## 1. Approach

Build the example in five review-sized units (see `unit-breakdown.md`). The
thinnest end-to-end slice — a scaffolded Flutter project that builds, runs, and
shows a working stateful counter with one passing test — is done first to
retire the biggest risk (the pre-release toolchain, REG-R1). README and full
verification follow.

Generation uses the Flutter tool rather than hand-writing the project skeleton,
so the platform folders, `pubspec.yaml`, and `analysis_options.yaml` are exactly
what a reader would get. Only `lib/main.dart`, `test/widget_test.dart`, and
`2-statefull/README.md` are authored by hand.

## 2. Conventions (from the existing codebase)

- Numbered wrapper directory per example (`1-hello-world` → `2-statefull`),
  matching CR-2 / ADR-008.
- The Flutter project is nested and named `flutter_application_<N>`, mirroring
  `1-hello-world/flutter_application_1`.
- Material widgets come from the current template's official `material_ui`
  package (ADR-006), not `package:flutter/material.dart`.
- The entire app lives in one `lib/main.dart` (NFR-4 / CON-5).
- Widget tests replace the generated test file rather than adding a second one.

## 3. Build, Lint, and Test Commands

Run from `2-statefull/flutter_application_2/`:

| Purpose | Command | Expected result |
| --- | --- | --- |
| Resolve deps | `flutter pub get` | resolves; writes `pubspec.lock` |
| Analyze (lint) | `flutter analyze` | `No issues found!` |
| Test | `flutter test` | all tests passed |
| Build/run (manual) | `flutter run -d macos` | app launches on the macOS desktop device |
| Scaffold | `flutter create --project-name flutter_application_2 2-statefull/flutter_application_2` | project generated |

These are the project's own commands (team memory) and are authoritative; no
wrapper scripts are introduced.

## 4. Sequencing and Risk

Order: **U1 → U2 → U3 → (U4 ∥ U5) → U6**.

- **Risk first**: U1 exercises the pre-release Flutter channel end to end
  (create → pub get → analyze → test) on the untouched template. If the
  toolchain is broken, it fails here, before any authored code exists.
- **Critical path**: U1 → U2 → U3 → U6.
- **Parallelisable**: U4 (README) can be drafted once U2 fixes the widget names.

| Risk | Retired by |
| --- | --- |
| REG-R1 pre-release channel churn | U1 (template builds clean) |
| REG-R5 first macOS build / CocoaPods | U6 (manual run) |
| REG-R2 headless run unavailable | U3/U6 (tests are authoritative; run recorded) |
| REG-R3 `material_ui` drift | U1 (`pub get` resolves and locks) |
| REG-R4 naming | Decided (ADR-008); baked into U1 |

## 5. Files Likely Touched

```
2-statefull/
├── README.md                                  (authored — U4)
└── flutter_application_2/
    ├── pubspec.yaml                           (generated — U1)
    ├── analysis_options.yaml                  (generated — U1)
    ├── lib/main.dart                          (authored — U2)
    ├── test/widget_test.dart                  (authored — U3)
    ├── macos/ ios/ android/ web/ …            (generated — U1, not edited)
    └── pubspec.lock                           (generated — U1)
```

## 6. Review Strategy

- **One unit, one diff.** U1 is generated output plus no edits; U2 and U3 are
  small authored diffs. U4 is docs.
- **Traceability at review**: each unit lists the requirement ids it satisfies
  (see `unit-breakdown.md`), so a reviewer can check coverage without re-reading
  the spec.
- **Human owns the merge** (org memory). The Develop phase produces the code;
  this plan does not authorise bypassing review.
- **Deviations** are recorded in the relevant stage's `memory.md` and surfaced
  at the Develop phase review.
- **Gate**: the generated code is reviewed against `technical-spec.md` §3 and
  the acceptance criteria here before the workflow leaves Develop.

## 7. Definition of Done

1. `flutter analyze` reports no issues.
2. `flutter test` passes all five widget tests.
3. `flutter run -d macos` shows `0`, and the three controls change it as
   specified; the counter never goes below `0`.
4. `pubspec.yaml` adds no non-Flutter dependency.
5. The tree matches §5 and requirement FR-5.
6. `2-statefull/README.md` documents the pattern and the commands.

## 8. Explicit Non-Goals

No CI workflow, no deployment, no routing, no persistence, no theming, no extra
examples, no refactoring of `1-hello-world`.
