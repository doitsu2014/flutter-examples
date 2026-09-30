# Code Generation Notes — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Develop / Code Generation
- **Units executed**: U1, U2, U3, U4, U5 (review), U6 (verification)

## 1. Commands Run and Results

All commands run from
`2-statefull/flutter_application_2/` unless noted.

| # | Command | Result |
| --- | --- | --- |
| 1 | `flutter create --project-name flutter_application_2 2-statefull/flutter_application_2` | `Wrote 131 files.` / `Got dependencies` |
| 2 | `flutter pub get` (after removing `cupertino_icons`) | `Changed 1 dependency!` — `cupertino_icons 1.0.9` no longer depended on |
| 3 | `flutter analyze` | `No issues found! (ran in 3.4s)` |
| 4 | `flutter test` | `00:00 +5: All tests passed!` |
| 5 | `flutter build macos --debug` | `✓ Built build/macos/Build/Products/Debug/flutter_application_2.app` (one Xcode warning about a Flutter-generated script phase lacking outputs; not from our code) |
| 6 | `flutter run -d macos --debug` | Launched; `Using the Impeller rendering backend (MetalSDF)`; `Syncing files to device macOS... 51ms`; `A Dart VM Service on macOS is available at: http://127.0.0.1:60799/…` |

Test output, verbatim (names):

```
+0: starts at zero
+1: increment updates the displayed value
+2: decrement steps the displayed value down
+3: never goes below zero
+4: reset returns the counter to zero
+5: All tests passed!
```

## 2. Unit-by-Unit Result

| Unit | Status | Evidence |
| --- | --- | --- |
| U1 scaffold | Done | command 1; `pubspec.yaml` declares `flutter_application_2` |
| U2 counter | Done | `lib/main.dart` (87 lines); command 3 clean |
| U3 tests | Done | `test/widget_test.dart` (57 lines); command 4 |
| U4 README | Done | `2-statefull/README.md` |
| U5 traceability/scope | Done | dependency list = `flutter` + `material_ui`; no excluded capability in diff |
| U6 verification | Done | commands 3, 4, 5, 6 |

## 3. Walking Skeleton

The skeleton (scaffold → working counter → one test) was exercised before the
remaining tests were added: after U2, `flutter analyze` was clean and the
increment behaviour was testable. This retired REG-R1 (pre-release toolchain)
first, as planned.

## 4. Deviations from the Technical Specification

### D1 — Removed the generated `cupertino_icons` dependency (recorded)

- **Spec**: `technical-spec.md` §1 says to keep the generated dependency set
  (ADR-006), and NFR-2 limits dependencies to official Flutter packages.
- **Deviation**: The generated `pubspec.yaml` declared
  `cupertino_icons: ^1.0.8`, which the example does not use. It was removed so
  the dependency list is exactly `flutter` (SDK) + `material_ui`, matching
  example 1 (`1-hello-world/flutter_application_1/pubspec.yaml`).
- **Reasoning**: `cupertino_icons` is an official package, so keeping it would
  not have violated NFR-2, but an unused direct dependency contradicts the
  example's "minimal footprint" intent and the sibling example's shape.
  `material_ui` still brings `cupertino_ui` transitively, so nothing is lost.
- **Impact**: One dependency removed; `flutter pub get` re-resolved the lock;
  analyze and test remain clean. No behaviour change.
- **Authority**: This is a "modify" style deviation within the approved plan's
  intent (NFR-2 / ADR-006's minimal-footprint reading); flagged here so the
  Develop review can accept or reverse it in one line.

### D2 — Manual UI interaction not performed; launch observed instead (recorded)

- **Spec**: `technical-spec.md` §6 asks for a manual `flutter run -d macos` with
  the controls exercised by hand.
- **Deviation**: The app was launched and reached a running state (VM Service
  available, files synced), then stopped programmatically. No human tapped the
  controls in the running window; the three behaviours (increment, floor,
  reset) are asserted by the widget tests instead.
- **Reasoning**: This is an unattended run (REG-R2). The widget tests are the
  authoritative, repeatable check; the manual run adds launch-level evidence
  only.
- **Impact**: Startup and rendering on macOS are confirmed; interactive visual
  confirmation is deferred to the reviewer if desired.

### D3 — Added a `ValueKey` and tooltips (recorded)

- Not a deviation so much as the concrete implementation of
  `api-contract.md` I-3 (`ValueKey('counter-value')`, tooltips `Increment`,
  `Decrement`, `Reset`) and ADR-005. Listed for completeness.

## 5. Environment

- Flutter `3.49.0-1.0.pre-218` (channel `main`), Dart `3.14.0-271.0.dev`.
- macOS `26.6.2` (darwin-arm64), Xcode 26.6.
- `material_ui` resolved to `1.5.0`; `flutter_lints` `6.0.0`.
- Generated project has 131 files; only `lib/main.dart`, `test/widget_test.dart`,
  `2-statefull/README.md`, and a one-block `pubspec.yaml` edit are authored.

## 6. Open Items / Follow-ups

- None blocking. If the repo later standardises a shared `analysis_options.yaml`
  or a shared README template, both examples can be aligned in a follow-up.
- `2-statefull` spelling remains as requested (ADR-008).
