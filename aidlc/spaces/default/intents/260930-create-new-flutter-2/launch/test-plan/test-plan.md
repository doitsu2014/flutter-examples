# Test Plan — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `requirements.md`, `technical-spec.md`, `source-changes.md`
- **Status**: proposed

## 1. Risk Ranking

Risk = impact × likelihood. The riskiest paths get the deepest testing.

| Rank | Requirement | Impact if wrong | Likelihood | Risk | Test depth |
| --- | --- | --- | --- | --- | --- |
| 1 | **FR-3** decrement floor (boundary) | Counter shows a negative value; the advertised invariant is false | Medium — the boundary needs an explicit guard | **High** | Boundary test at `0`, plus a step-down test |
| 2 | **FR-4** `State` + `setState` | UI silently stops tracking state; the core lesson is wrong | Medium — easy to mutate outside `setState` | **High** | Any state test fails if rebuild is broken; all five cover it |
| 3 | **FR-2** increment | The primary interaction does not work | Low — trivial code | Medium | Happy-path test |
| 4 | **NFR-1** runs on local toolchain | Example cannot be verified or used | Low — environment verified | Medium | Analyze + test + one macOS run |
| 5 | **FR-1** initial `0` | Wrong starting state | Low | Low | Initial-render test |
| 6 | **FR-6** test suite | No regression safety | Low | Low | The suite is itself the control |
| 7 | **NFR-3** analysis clean | Lint debt | Low | Low | `flutter analyze` |
| 8 | **FR-5 / FR-7 / NFR-2 / NFR-4** | Structure/docs/deps drift | Low | Low | Inspection at review |

Everything is pure UI: there are no pure functions, no I/O, and no concurrency,
so the riskiest paths are the two boundary/rebuild behaviours above, not the
happy path.

## 2. Strategy

| Level | Used? | What it covers |
| --- | --- | --- |
| Unit (pure Dart) | No | There are no pure functions to test in isolation; adding one would mean inventing a model layer the example deliberately does not have (ADR-003). |
| **Widget test** | **Yes — primary** | The whole example is a widget tree, so widget tests exercise the real contract: state change → rebuild → rendered value. |
| Integration (`integration_test`) | No | Would add setup and a device dependency for no extra behavioural coverage. Deliberate omission. |
| End-to-end / smoke | Yes — manual | One `flutter run -d macos` launch to confirm the app starts and renders (NFR-1). Not automated; documented as a deviation (D2). |

**Happy-path floor per component**: `_CounterPageState` (the only component with
behaviour) gets its happy path (increment), its boundary (floor at `0`), and its
reset. `MainApp` is covered indirectly because tests pump it.

**Test design rules**

- Tests are named for the behaviour they verify, not the method.
- Assertions read the value through the declared contract key
  (`ValueKey('counter-value')`) — the test contract in `api-contract.md` I-3.
- Tests drive the UI as a user would (`tap` by tooltip); they never reach into
  `State` fields, so refactors inside `build` do not break them.
- No `pumpAndSettle` with timers; there are no animations to wait for, so
  `pump()` keeps tests deterministic and fast.

## 3. Requirement → Test Map

| Requirement | Test case | Level |
| --- | --- | --- |
| FR-1 initial `0` | `starts at zero` | widget |
| FR-2 increment | `increment updates the displayed value` | widget |
| FR-3 decrement | `decrement steps the displayed value down` | widget |
| FR-3 floor boundary | `never goes below zero` | widget |
| FR-3 reset | `reset returns the counter to zero` | widget |
| FR-4 `setState` rebuild | all five (each fails without a rebuild) | widget |
| FR-6 suite runs | `flutter test` exits 0 | command |
| NFR-1 local run | manual `flutter run -d macos` | e2e smoke |
| NFR-3 analysis | `flutter analyze` | command |

Every Must requirement has at least one test; the highest-risk path (FR-3
boundary) has a dedicated case.

## 4. Environments and Data

| Aspect | Plan |
| --- | --- |
| Environments | Developer macOS machine (darwin-arm64); Flutter 3.49.0-1.0.pre, Dart 3.14.0 |
| CI | Not in scope (CR-1 excludes CI/CD); tests are run locally |
| Devices | macOS desktop (`flutter devices`); no emulator/device farm |
| Fixtures | None — the app takes no input and reads no data |
| Test data | None — no production data, no personal data, nothing to anonymise |
| Isolation | Each `testWidgets` case pumps a fresh `MainApp`; no shared mutable state between tests |

## 5. Exit Criteria

The suite passes when **all** of the following hold:

1. `flutter analyze` reports **no issues** (NFR-3).
2. `flutter test` reports **all tests passed** with **zero failures and zero
   skipped** (FR-6).
3. **100% of Must requirements** have at least one passing automated test, and
   the FR-3 boundary has its dedicated case (coverage here is requirement
   coverage, not line coverage; a line-coverage floor is not meaningful for an
   87-line example).
4. No new dependency was added to obtain coverage (NFR-2).
5. One manual macOS launch is observed, or the deviation is recorded (NFR-1 /
   REG-R2).

**Known-acceptable gaps**

- No test for platforms other than macOS (CON-4).
- No automated smoke run; the manual run is evidence only.
- No accessibility semantics assertion beyond the tooltips existing.
- No performance test — no budget exists and none is meaningful at this size.

## 6. Determinism

The suite has no clock, randomness, network, or shared state; it should be
deterministic. Any future flake is a defect to fix or delete, never to retry
(team practice).

## 7. Plan Approval

The plan proposes no new tests beyond the five already written in U3; it
formalises their intent, levels, and exit criteria. If approved, Test Generation
regenerates/reviews them against this plan.
