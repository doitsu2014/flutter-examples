# Test Suite — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Launch / Test Generation
- **Source of truth**: `2-statefull/flutter_application_2/test/widget_test.dart`
- **Last run**: 2026-09-30, from `2-statefull/flutter_application_2/`

## 1. How to Run

```bash
cd 2-statefull/flutter_application_2
flutter test      # the suite
flutter analyze   # static analysis, part of the exit criteria
```

## 2. Suite Contents

One test file, five `testWidgets` cases. Each pumps `const MainApp()` and drives
the UI through the contract selectors from `api-contract.md` I-3
(`find.byTooltip(...)`, `find.byKey(const ValueKey('counter-value'))`).

```dart
String counterText(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const ValueKey('counter-value'))).data!;
```

| # | Test name | Level | Drives | Asserts |
| --- | --- | --- | --- | --- |
| 1 | `starts at zero` | widget | pump | value is `'0'` |
| 2 | `increment updates the displayed value` | widget | tap `Increment`, pump | value is `'1'` |
| 3 | `decrement steps the displayed value down` | widget | 2× `Increment`, then `Decrement` | value is `'1'` |
| 4 | `never goes below zero` | widget | `Decrement` at `0` | value stays `'0'`; no `'-1'` text |
| 5 | `reset returns the counter to zero` | widget | 2× `Increment`, then `Reset` | value is `'0'` |

No mocks, no stubs, no fakes: the tests exercise the real widget tree.

## 3. Traceability — Requirement → Test → Result

| Requirement | Test name(s) | Result |
| --- | --- | --- |
| FR-1 initial `0` | `starts at zero` | **Pass** |
| FR-2 increment | `increment updates the displayed value` | **Pass** |
| FR-3 decrement | `decrement steps the displayed value down` | **Pass** |
| FR-3 floor boundary | `never goes below zero` | **Pass** |
| FR-3 reset | `reset returns the counter to zero` | **Pass** |
| FR-4 `State` + `setState` | all five (each fails without a rebuild) | **Pass** |
| FR-6 suite | `flutter test` exit code 0 | **Pass** |
| NFR-3 analysis | `flutter analyze` | **Pass** — `No issues found!` |
| NFR-1 local run | manual `flutter run -d macos` | **Pass** — app launched, Dart VM Service available (recorded in `code-generation-notes.md` §1) |
| NFR-2 footprint | no test dependency added | **Pass** |
| CR-1 built-in state | tests tap real framework widgets | **Pass** |

## 4. Raw Results

```
00:00 +0: loading .../test/widget_test.dart
00:00 +0: starts at zero
00:00 +1: increment updates the displayed value
00:00 +2: decrement steps the displayed value down
00:00 +3: never goes below zero
00:00 +4: reset returns the counter to zero
00:00 +5: All tests passed!
```

```
Analyzing flutter_application_2...
No issues found! (ran in 2.9s)
```

- Tests: **5 passed, 0 failed, 0 skipped**.
- Analyzer: **0 issues** (`flutter_lints` 6.0.0).

## 5. Determinism

- No clock, randomness, network, file system, or ordering dependence.
- Each case starts from a fresh `pumpWidget(const MainApp())`; no shared state.
- `pump()` is used rather than `pumpAndSettle()`; there are no timers or
  animations to settle, so the suite cannot hang on them.
- Repeated runs are stable; no retries were needed.

## 6. Coverage Notes

Coverage is **requirement coverage**, not line coverage (the test plan explains
why a line floor is not meaningful for an 87-line example). Every Must
requirement has at least one passing test, and the highest-risk path (FR-3
boundary at zero) has a dedicated case.

**Deliberately not covered** (per `test-plan.md` §5): non-macOS platforms, an
automated device-level smoke test, accessibility semantics beyond tooltips, and
performance. These are known-acceptable gaps, not oversights.

## 7. Exit Criteria Status

| Criterion | Status |
| --- | --- |
| `flutter analyze` no issues | Met |
| `flutter test` all pass, no skips | Met |
| 100% of Must requirements tested; boundary dedicated | Met |
| No new dependency for testing | Met |
| Manual macOS launch observed | Met (launch only; interactions are test-covered) |

The suite is stable and ready for Release Validation to re-run on the candidate.
