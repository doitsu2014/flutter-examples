# Constraint Register — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Source**: `feasibility-assessment.md`, `requirements.md`
- **Scope**: classic

Constraint types: **T** technical, **S** scope, **C** compliance/**L** licensing,
**P** schedule/budget. Status: active / resolved / deferred.

## Hard Constraints

| ID | Type | Constraint | Source | Status | How verified |
| --- | --- | --- | --- | --- | --- |
| CON-1 | T/S | State is managed only with the framework's `StatefulWidget` / `State` / `setState`; no third-party state management. | CR-1, Q2 | active | Diff review; `pubspec.yaml` inspection |
| CON-2 | T | Runtime dependencies are limited to official Flutter packages (`flutter`, `material_ui`, `cupertino_icons`, `flutter_localizations` transitively). No third-party capability libraries. | NFR-2, `flutter create` template | active | `pubspec.yaml` + `pubspec.lock` inspection |
| CON-3 | T | Flutter project root must be `2-statefull/flutter_application_2/`; `2-statefull` is not a legal Dart package identifier. | FR-5, CR-2 | active | Path/name inspection; `flutter analyze` |
| CON-4 | S | Verification targets one desktop platform only (macOS). Web and Android are out of scope. | Q2, Intent §5 | active | `flutter devices`; run log |
| CON-5 | S | All app logic in a single short `lib/main.dart`; no extracted widgets, no extra files. | NFR-4 | active | Code review |
| CON-6 | C/L | No regulatory, residency, latency, or licensing non-negotiables apply. | Intent §6 | resolved | Confirmed during assessment |
| CON-7 | P | No deadline or budget ceiling. | Intent §6 | resolved | Confirmed during assessment |

## Risk Register

| ID | Risk | Likelihood | Impact | Mitigation | Owner |
| --- | --- | --- | --- | --- | --- |
| REG-R1 | Flutter `main` is a pre-release channel (`3.49.0-1.0.pre`); APIs may churn. | High | Low | Use only long-stable primitives and official packages; rely on the installed SDK; no experimental APIs. | architect |
| REG-R2 | `flutter run` requires a graphical session; an unattended/headless environment cannot complete the manual check. | Medium | Low | Make `flutter test` the automated verification (FR-6); perform one manual macOS run; record a deviation if no display is available. | developer |
| REG-R3 | `material_ui` minors drift relative to the template pin; a future pub resolution could change widget APIs. | Low | Low | Accept the generated `^1.1.0` constraint; the example uses only stable Material widgets; `pubspec.lock` is committed. | developer |
| REG-R4 | Directory spelling `2-statefull` vs. `2-stateful`. | Medium | Low | Decide in Ideate before code lands; renaming later touches paths, README, and test imports. Logged as an open question in stage memory. | product |
| REG-R5 | First macOS desktop build may be slow or need CocoaPods/Xcode setup. | Low | Low | Xcode 26.6 is installed; keep the manual run optional by making tests authoritative; document the run command. | developer |

## Decisions Handed to Ideate

1. **D1 — Material dependency**: follow the template and example 1, using the
   official `material_ui` package (CON-2). Confirm in the technical spec.
2. **D2 — Naming**: keep `2-statefull` verbatim or correct to `2-stateful`
   (REG-R4). Resolve before Task Planning; it is a one-way-ish door for paths.
3. **D3 — Action set**: Must is increment only; Should adds decrement/reset.
   Trim at review if the example is judged too large (FR-3).
4. **D4 — UI form**: choose the concrete control(s) and layout in Architecture
   Design; constrain to standard Material widgets and one file.
