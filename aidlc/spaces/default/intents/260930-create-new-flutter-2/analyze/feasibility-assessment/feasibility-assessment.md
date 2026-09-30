# Feasibility Assessment — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `analyze/intent-capture/intent-statement.md`,
  `analyze/requirements-analysis/requirements.md`
- **Assessed**: 2026-09-30
- **Recommendation**: **Proceed** (no spikes required)

## 1. Technical Feasibility by Requirement

| Requirement | Feasible? | Basis | Unknowns / spikes |
| --- | --- | --- | --- |
| FR-1 initial value renders | Yes | Trivial widget tree; `flutter create` output | None |
| FR-2 increment via `setState` | Yes | Framework primitive; canonical counter | None |
| FR-3 decrement / reset, floored at 0 | Yes | One integer + `setState` | None |
| FR-4 state owned by a `State` class | Yes | `StatefulWidget` / `State` are core | None |
| FR-5 conventional project in `2-statefull/` | Yes | `flutter create` verified to work locally | Package-name legality, see CON-3 |
| FR-6 widget test proves state change | Yes | `flutter_test` (`WidgetTester`, `tester.tap`) | None |
| FR-7 README | Yes | Documentation only | None |
| NFR-1 local toolchain | Yes | `flutter --version` → 3.49.0; `flutter devices` → macOS | macOS build needs Xcode, present |
| NFR-2 minimal footprint | Yes | Only official Flutter packages needed | `material_ui` is official, see CON-2 |
| NFR-3 static analysis | Yes | `flutter_lints` 6.0.0 available | None |
| NFR-4 single-file readability | Yes | ~60–90 lines expected | None |
| CR-1 built-in state only | Yes | No package required | None |
| CR-2 `2-statefull` directory | Yes | Filesystem convention | Spelling, see REG-R4 |

**Toolchain verified locally**
- Flutter `3.49.0-1.0.pre-218` (channel `main`), Dart `3.14.0-271.0.dev`.
- `flutter devices` → `macOS (desktop) • macos • darwin-arm64`; `macOS 26.6.2`.
- `flutter doctor` → Flutter, Xcode for macOS, connected device, network all
  healthy. Android SDK and Chrome are **absent**, which is acceptable: the
  requirement set targets desktop only (CON-4).
- `flutter create` executed successfully in a scratch directory, confirming the
  current template generates `package:material_ui/material_ui.dart` and a
  `material_ui: ^1.1.0` dependency.

## 2. Cost, Schedule, and Effort

| Item | Estimate | Basis |
| --- | --- | --- |
| Generation (`flutter create`) | minutes | Verified toolchain |
| Implementation (one widget, one `State`) | < 1 hour | ~60–90 lines, no packages |
| Widget tests | < 1 hour | Two or three `testWidgets` cases |
| README | < 30 minutes | Short |
| Review | < 1 hour | Small diff, human merge per org rule |
| **Total** | **half a day or less** | No external dependencies, no unknowns |

No budget, deadline, or licensing cost. No third-party runtime package means no
supply-chain or license surface beyond official Flutter packages.

## 3. Hard Constraints

Summarised here; the full register is in `constraint-register.md`.

- **CON-1** Built-in `StatefulWidget` / `State` / `setState` only — no
  third-party state management (CR-1).
- **CON-2** Runtime dependencies limited to **official Flutter packages**
  (`flutter`, the Material UI library, `flutter_localizations` transitively).
  The current `flutter create` template depends on the official `material_ui`
  package; this does **not** violate NFR-2's intent, which is to exclude
  third-party capability libraries, not Flutter's own decoupled Material
  package. See §4.
- **CON-3** The Flutter project root is
  `2-statefull/flutter_application_2/`; `2-statefull` is not a legal Dart
  package identifier (leading digit, hyphen).
- **CON-4** Verification target is a single desktop platform (macOS).
- **CON-5** All app logic stays in one short `lib/main.dart` (NFR-4).
- **CON-6** No compliance, residency, latency, or licensing non-negotiables
  apply.

## 4. Finding: Material is now a pub package on `main`

On this Flutter channel the template imports
`package:material_ui/material_ui.dart` and declares `material_ui: ^1.1.0`,
rather than importing `package:flutter/material.dart` from the SDK (the SDK
`material.dart` still exists but is not what the template generates). The
`material_ui` package describes itself as *"The official Flutter Material UI
Library"* and lives in the `flutter/packages` repository, so it is
**first-party**.

**Implication for NFR-2**: "no third-party runtime dependency" remains true under
this template, but the wording should be read as "no dependencies outside
official Flutter packages". The example will follow the template and example 1,
both of which use `material_ui`. No relaxation of CR-1 is implied — state
management is still the framework's own.

## 5. Risks

Full register in `constraint-register.md` (REG-R1 … REG-R5). Highest two:

- **REG-R2 — headless verification (Medium likelihood, Low impact)**: `flutter run`
  needs a display; the automated path (`flutter test`) does not. Mitigation: the
  test suite is the primary verification, with one manual desktop run.
- **REG-R1 — pre-release channel (High likelihood, Low impact)**: Flutter `main`
  is a dev channel; APIs may churn. Mitigation: the example uses only long-stable
  primitives (`StatefulWidget`, `setState`, `Scaffold`, `Text`, a button) and
  pins to the locally installed SDK.

## 6. Recommendation

**Proceed.** Every requirement is feasible with the verified local toolchain,
using only framework primitives and official Flutter packages. No spike,
prototype, or procurement is needed. The only decisions left are stylistic
(naming/spelling, exact button set) and belong to Ideate, not to feasibility.

## 7. Traceability

| Assessment statement | Source |
| --- | --- |
| Requirement feasibility rows | `requirements.md` FR-1…CR-2 |
| Toolchain evidence | `flutter --version`, `flutter devices`, `flutter doctor`, scratch `flutter create` |
| Material finding | `material_ui-1.5.0` pubspec ("official Flutter Material UI Library") |
| Recommendation | Derived from the above; no open blockers |
