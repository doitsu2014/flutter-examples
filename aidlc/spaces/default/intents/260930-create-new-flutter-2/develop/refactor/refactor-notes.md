# Refactor Notes — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Develop / Refactoring
- **Inputs**: `review-record.md` (F-1, F-2), `source-changes.md`
- **Outcome**: one small, behaviour-preserving change applied; F-2 consciously
  left as-is

## 1. Justification

The Code Review found no blocking or major issues and no structural debt. It
raised one finding worth acting on:

- **F-1** — the widget tests asserted the displayed counter with
  `find.text('0')` / `find.text('1')`, while `api-contract.md` I-3 declares
  `ValueKey('counter-value')` as the value's stable selector. The declared
  contract key was never exercised, and `find.text` on a bare digit becomes
  ambiguous if another widget ever renders the same digits.

**Named benefit**: tests assert through the declared contract, so a future layout
or copy change that still renders the same number cannot break them for the
wrong reason. **Cost**: three lines in the test file. **Why now**: the diff is
fresh and the change is mechanical.

## 2. Safety Net

Established before touching code: five passing widget tests
(`flutter test` → `+5: All tests passed!`) cover every behaviour the change
touches. F-1 changes only how assertions read the value, not what they assert.

## 3. Change Applied

**File**: `2-statefull/flutter_application_2/test/widget_test.dart`

- Added a small reader used by every assertion:

  ```dart
  String counterText(WidgetTester tester) =>
      tester.widget<Text>(find.byKey(const ValueKey('counter-value'))).data!;
  ```

- Replaced value assertions `expect(find.text('0'|'1'), findsOneWidget)` with
  `expect(counterText(tester), '0'|'1')`.
- Kept `expect(find.text('-1'), findsNothing)` in the floor test as a guard
  against stray negative text anywhere in the tree.

One mechanical change; tests run after it.

## 4. What Stayed the Same

- `lib/main.dart` is untouched. The counter, the `setState` calls, the guard,
  the key, and the tooltips are all identical.
- Behaviour is unchanged: same five scenarios, same expected values.
- No new dependency; `pubspec.yaml` is unchanged.
- F-2 (redundant intermediate `pump()` calls) deliberately **not** changed — the
  reviewer's note said to keep them if they read better, and they show the
  tap→pump rhythm explicitly in a teaching test.

## 5. Verification After the Change

| Command | Result |
| --- | --- |
| `flutter analyze` | `No issues found! (ran in 2.9s)` |
| `flutter test` | `00:00 +5: All tests passed!` |

## 6. Findings Disposition

| Finding | Severity | Disposition |
| --- | --- | --- |
| F-1 unused contract key | minor | **Fixed** in this stage |
| F-2 redundant pumps | nit | Accepted as-is (readability over micro-tidiness) |
| F-3 README device note | nit | Accepted as-is |

No further refactoring is warranted: the code is 87 lines, single-purpose, and
has no duplication, dead code, or coupling to remove. A larger restructure would
work against NFR-4 (readability as a first example).
