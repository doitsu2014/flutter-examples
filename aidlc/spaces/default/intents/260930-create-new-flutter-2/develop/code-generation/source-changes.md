# Source Changes — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Develop / Code Generation
- **Scope of change**: new example directory; no existing files modified

## 1. Summary

Implemented units U1–U4 and ran U5/U6 verification of
`develop/task-planning/unit-breakdown.md`. The result is one Flutter application
that demonstrates the `StatefulWidget` / `State` / `setState` pattern as a
counter, with five widget tests.

## 2. Files Created

| Path | Unit | Origin | Purpose |
| --- | --- | --- | --- |
| `2-statefull/flutter_application_2/` | U1 | generated | Flutter project root (131 files incl. platform folders) |
| `2-statefull/flutter_application_2/pubspec.yaml` | U1, U2 | generated + edited | package `flutter_application_2`; **removed** unused `cupertino_icons` |
| `2-statefull/flutter_application_2/pubspec.lock` | U1 | generated | locks `material_ui` and transitive Flutter packages |
| `2-statefull/flutter_application_2/lib/main.dart` | U2 | **authored** | the entire example (87 lines) |
| `2-statefull/flutter_application_2/test/widget_test.dart` | U3 | **authored** | five state-change tests (57 lines) |
| `2-statefull/README.md` | U4 | **authored** | pattern explanation, run/test commands |

Nothing under `1-hello-world/` or elsewhere was touched.

## 3. Authored Code

### `lib/main.dart`

Contains four top-level declarations, in file order:

1. `main()` → `runApp(const MainApp())`.
2. `MainApp extends StatelessWidget` — returns a `const MaterialApp` titled
   `Stateful Counter` with `home: CounterPage()`.
3. `CounterPage extends StatefulWidget` — `const CounterPage({super.key})`,
   `createState() => _CounterPageState()`.
4. `_CounterPageState extends State<CounterPage>`:
   - `int _count = 0;`
   - `_increment() => setState(() => _count += 1);`
   - `_decrement() => setState(() { if (_count > 0) _count -= 1; });`
   - `_reset() => setState(() => _count = 0);`
   - `build` → `Scaffold(AppBar('Stateful Counter'), Center(Column[Text('$_count', key: ValueKey('counter-value')), Row[IconButton(remove,'Decrement'), IconButton(add,'Increment'), IconButton(refresh,'Reset')]]))`.

Matches `technical-spec.md` §3 C1–C4.

### `test/widget_test.dart`

Five `testWidgets` cases, each pumping `const MainApp()`:

| Test | Assertion |
| --- | --- |
| `starts at zero` | `find.text('0')` findsOneWidget |
| `increment updates the displayed value` | after one tap, `find.text('1')` |
| `decrement steps the displayed value down` | 0→2→1, `find.text('1')` |
| `never goes below zero` | tap Decrement at 0 → `find.text('0')`, no `'-1'` |
| `reset returns the counter to zero` | 0→2→reset, `find.text('0')` |

Matches `technical-spec.md` §3 C5.

### `2-statefull/README.md`

Names the pattern, points to `_CounterPageState`, lists the four commands, and
gives a four-item "what to notice" list. Matches FR-7.

## 4. Change to Generated Files

Only `pubspec.yaml` was edited: the unused `cupertino_icons: ^1.0.8` dependency
(and its two comment lines) was removed. Rationale in `code-generation-notes.md`
§4. `flutter pub get` reported: *"These packages are no longer being depended
on: cupertino_icons 1.0.9 — Changed 1 dependency!"*

All other generated files are byte-identical to `flutter create` output.

## 5. Requirement Coverage Delivered

| Requirement | Where |
| --- | --- |
| FR-1 initial `0` | `_count = 0`; test `starts at zero` |
| FR-2 increment | `_increment`; test `increment updates…` |
| FR-3 decrement/reset/floor | `_decrement`, `_reset`; two tests |
| FR-4 `State` + `setState` | `_CounterPageState`; every mutation wrapped |
| FR-5 project structure | `2-statefull/flutter_application_2/` |
| FR-6 widget test | `test/widget_test.dart` |
| FR-7 README | `2-statefull/README.md` |
| NFR-1 toolchain | `flutter build macos` + `flutter run -d macos` observed |
| NFR-2 minimal footprint | deps = `flutter` (sdk) + `material_ui` only |
| NFR-3 analysis | `flutter analyze` → `No issues found!` |
| NFR-4 readability | 87-line single file, three small classes |
| CR-1 built-in only | no state-management package |
| CR-2 directory | `2-statefull/` |

## 6. Suggested Commit Message

```
Add 2-statefull Flutter example demonstrating StatefulWidget/setState

A counter that exercises the framework's built-in mutable state:
- lib/main.dart: MainApp, CounterPage, _CounterPageState (87 lines)
- test/widget_test.dart: initial value, increment, decrement, floor, reset
- README explaining the pattern and how to run/verify

No third-party state management; depends only on the Flutter SDK and the
official material_ui package. Verified with flutter analyze (clean),
flutter test (5 passed), and a macOS debug run.
```
