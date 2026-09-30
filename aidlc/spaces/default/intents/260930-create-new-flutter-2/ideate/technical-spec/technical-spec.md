# Technical Specification — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `architecture-doc.md`, `design-decisions.md`, `api-contract.md`,
  `requirements.md`
- **Status**: approved for build (Ideate)

## 1. Deliverable

One Flutter application that demonstrates the framework's
`StatefulWidget` / `State` / `setState` pattern as a counter.

```
2-statefull/
├── README.md
└── flutter_application_2/
    ├── pubspec.yaml                     # generated; package flutter_application_2
    ├── analysis_options.yaml            # generated; flutter_lints
    ├── lib/
    │   └── main.dart                    # the entire example
    └── test/
        └── widget_test.dart             # state-change widget tests
```

Platform folders (`macos/`, `ios/`, …) are whatever `flutter create` generates;
they are committed but not edited.

## 2. Requirement → Component → Test Traceability

| Requirement | Component(s) | Interface / element | Test approach |
| --- | --- | --- | --- |
| FR-1 initial `0` | `_CounterPageState.build` | `Text` keyed `counter-value` | `pumpWidget` + `expect(find.text('0'), findsOneWidget)` |
| FR-2 increment | `_CounterPageState._increment` | tooltip `Increment` | `tester.tap(find.byTooltip('Increment'))`, `pump`, expect `'1'` |
| FR-3 decrement / reset / floor | `_decrement`, `_reset` | tooltips `Decrement`, `Reset` | tap sequence; expect step-down, `'0'` floor, and reset to `'0'` |
| FR-4 `State` + `setState` | `CounterPage` / `_CounterPageState` | class structure | code review; FR-2/FR-3 tests fail without a rebuild |
| FR-5 conventional structure | `2-statefull/flutter_application_2/` | project tree | path inspection |
| FR-6 widget test | `test/widget_test.dart` | `main()` test entry | `flutter test` exits 0 |
| FR-7 README | `2-statefull/README.md` | docs | review: run + test commands, pointer to state class |
| NFR-1 local toolchain | project root | `flutter run -d macos` | manual desktop run after `flutter devices` |
| NFR-2 minimal footprint | `pubspec.yaml` | dependency list | no non-Flutter runtime dependency |
| NFR-3 analysis | `analysis_options.yaml` | `flutter analyze` | no analyzer errors |
| NFR-4 readability | `lib/main.dart` | one file, three small classes | code review |
| CR-1 built-in only | `lib/main.dart`, `pubspec.yaml` | no state packages | diff + dependency review |
| CR-2 `2-statefull` | repository root | directory name | directory inspection |
| AR-1 Flutter SDK | environment | `flutter --version` | validated (3.49.0 / 3.14.0) |
| AR-2 desktop device | environment | `flutter devices` | validated (macOS) |

Every must-have requirement is mapped.

## 3. Component Specifications

### C1 — `MainApp` (`StatelessWidget`)

| Aspect | Spec |
| --- | --- |
| Responsibility | App shell: build the `MaterialApp` and set `home` |
| Inputs | none |
| Outputs | a `MaterialApp` widget |
| State | none (immutable, `const` constructor) |
| Dependencies | `material_ui` (`MaterialApp`), `CounterPage` |
| Errors | none |
| Configuration | `title: 'Stateful Counter'`; theme left as framework default (Material 3) |

### C2 — `CounterPage` (`StatefulWidget`)

| Aspect | Spec |
| --- | --- |
| Responsibility | Declare the stateful screen and create its `State` |
| Inputs | `key` (optional, forwarded to `super`) |
| Outputs | a `_CounterPageState` via `createState()` |
| State | none — the widget is immutable and holds no counter data |
| Dependencies | `_CounterPageState` |
| Errors | none |

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}
```

### C3 — `_CounterPageState` (`State<CounterPage>`)

| Aspect | Spec |
| --- | --- |
| Responsibility | Own the counter, mutate it through `setState`, and render it |
| Inputs | `BuildContext` (in `build` only) |
| Outputs | the page widget tree |
| State | `int _count = 0` (private, the only mutable field) |
| Dependencies | `material_ui` widgets (`Scaffold`, `AppBar`, `Center`, `Column`, `Text`, `Row`, `IconButton`, `Icons`) |
| Errors | none thrown; decrement at `0` is a silent no-op |
| Configuration | none |

Methods and exact semantics:

| Member | Signature | Behaviour |
| --- | --- | --- |
| `_increment` | `void _increment()` | `setState(() => _count += 1);` |
| `_decrement` | `void _decrement()` | `setState(() { if (_count > 0) _count -= 1; });` |
| `_reset` | `void _reset()` | `setState(() => _count = 0);` |
| `build` | `Widget build(BuildContext context)` | `Scaffold` → `AppBar(title: Text('Stateful Counter'))`; body `Center(Column(mainAxisSize: MainAxisSize.min, children: [value Text, SizedBox, control Row]))` |
| value `Text` | — | `Text('$_count', key: const ValueKey('counter-value'), style: Theme.of(context).textTheme.displayMedium)` |
| controls | — | `Row(mainAxisAlignment: MainAxisAlignment.center, children: [IconButton(Icons.remove, tooltip: 'Decrement', onPressed: _decrement), const SizedBox(width: 16), IconButton(Icons.add, tooltip: 'Increment', onPressed: _increment), const SizedBox(width: 16), IconButton(Icons.refresh, tooltip: 'Reset', onPressed: _reset)])` |

Invariants: `_count >= 0`; every mutation is inside `setState`; the displayed
value is derived on each `build` (ADR-001, ADR-002, ADR-004).

### C4 — `lib/main.dart`

- Contains `import 'package:material_ui/material_ui.dart';`, `main()`,
  `MainApp`, `CounterPage`, `_CounterPageState`.
- `void main() => runApp(const MainApp());`
- No other source files.

### C5 — `test/widget_test.dart`

- Imports `package:flutter_test/flutter_test.dart`,
  `package:flutter_application_2/main.dart`.
- Provides `main()` with these `testWidgets` cases:

| Test | Arrange | Act | Assert |
| --- | --- | --- | --- |
| initial value | `pumpWidget(const MainApp())` | — | `find.text('0')` finds one widget |
| increment | pump `MainApp` | tap `byTooltip('Increment')`, `pump()` | `find.text('1')` finds one widget |
| decrement | pump, tap Increment twice, pump | tap `byTooltip('Decrement')`, `pump()` | `find.text('1')` |
| floor at zero | pump | tap `byTooltip('Decrement')`, `pump()` | `find.text('0')`; no `find.text('-1')` |
| reset | pump, tap Increment twice, pump | tap `byTooltip('Reset')`, `pump()` | `find.text('0')` |

- Tests pump `MainApp` (the real entry widget), not `CounterPage` alone, so the
  wiring is covered too. `CounterPage` remains directly testable if desired.

### C6 — `2-statefull/README.md`

- Title and one-line description of the pattern demonstrated.
- Pointer to `_CounterPageState` in
  `flutter_application_2/lib/main.dart` as the place to read.
- Commands: `cd flutter_application_2 && flutter pub get`, `flutter run -d macos`,
  `flutter test`, `flutter analyze`.
- A short "what to notice" list: state field, `setState`, rebuild, floor guard.

## 4. Cross-Cutting Concerns

### Security

No trust boundary beyond local taps; no network, storage, permissions, secrets,
or analytics. Runtime dependencies are the Flutter SDK and official Flutter
packages only; `pubspec.lock` is committed. Security review (advisory, in
`architecture-doc.md` §10) produced no blocking findings.

### Observability

None by design. No logging, telemetry, or metrics (CR-1 excludes them). Debug
builds use Flutter's default `debugPrint` behaviour only.

### Performance Budget

- First frame: dominated by app startup; no target.
- Rebuild cost per tap: one small subtree; no measurement needed.
- No images, fonts, animations, or network. Budget is satisfied by construction.

### Data Lifecycle

`int _count` lives for the lifetime of the `_CounterPageState`; it is created at
`0`, mutated in memory, and discarded on app exit. No persistence, migration, or
deletion path (ADR-007).

### Accessibility

The three `IconButton`s carry tooltips, which Flutter exposes as semantics
labels; the value is a plain `Text` read by screen readers.

## 5. Work Breakdown Seeds (for Develop)

| Unit | Deliverable | Depends on | Acceptance |
| --- | --- | --- | --- |
| U1 | Scaffold the project at `2-statefull/flutter_application_2/` with `flutter create`; package name `flutter_application_2` | — | `pubspec.yaml`, `lib/main.dart`, `test/` exist |
| U2 | Implement `lib/main.dart` (`MainApp`, `CounterPage`, `_CounterPageState`) | U1 | `flutter analyze` clean; app runs |
| U3 | Replace the template test with the five `testWidgets` cases | U2 | `flutter test` exits 0 |
| U4 | Write `2-statefull/README.md` | U2 | README contains run/test commands and the state-class pointer |
| U5 | Verify end to end | U2–U4 | `flutter analyze`, `flutter test`, one `flutter run -d macos` |

Dependency order: U1 → U2 → (U3 ∥ U4) → U5. Develop refines and executes these.

## 6. Verification Commands (authoritative)

```bash
cd 2-statefull/flutter_application_2
flutter pub get
flutter analyze          # expect: no issues
flutter test             # expect: all tests passed
flutter run -d macos     # manual: counter starts at 0; controls change it
```

## 7. Open Items

- None blocking. Concrete button widgets are fixed above (`IconButton` × 3) per
  ADR-005, resolving the last open question from `api-contract.md` §3.
