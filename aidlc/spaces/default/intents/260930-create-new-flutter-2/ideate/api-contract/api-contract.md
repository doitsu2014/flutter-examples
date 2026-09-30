# Interface Contract — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `architecture-doc.md`, `requirements.md`
- **Status**: proposed (Ideate)

## 1. Interfaces in Scope

This application exposes no network API, no CLI, no event stream, and no data
schema. The interfaces it does expose are the ones a reader, a test, and a
future example will program against:

| # | Interface | Kind | Consumer |
| --- | --- | --- | --- |
| I-1 | `CounterPage` widget constructor | Dart widget contract | `MainApp`, tests |
| I-2 | Increment / decrement / reset events and their observable effects | Behavioural contract | user, widget tests |
| I-3 | Rendered widget selectors (text, keys, tooltips) | Test/semantics contract | widget tests, screen readers |

There is no authentication, pagination, idempotency key, or versioned URL,
because there is no remote surface.

## 2. I-1 — `CounterPage` Constructor

| Aspect | Contract |
| --- | --- |
| Name | `CounterPage` |
| Supertype | `StatefulWidget` |
| Constructor | `const CounterPage({super.key})` — no other parameters |
| Creates | `_CounterPageState` via `createState()` |
| Mutability | The widget is immutable and holds no counter data |
| Errors | None; construction cannot fail |

**Compatibility rule.** `CounterPage` is a public widget. Adding an optional
named parameter is backward compatible; adding a **required** parameter,
renaming the class, or changing the `key` handling is a breaking change for
consumers and tests. The example is not versioned or published, so no
deprecation policy beyond this sentence applies.

## 3. I-2 — Behavioural Contract

State field: `int _count`, initial value `0`, owned by `_CounterPageState`.
All three operations are synchronous, take no arguments, and return nothing.

| Event | Precondition | Postcondition (state) | Observable effect |
| --- | --- | --- | --- |
| `increment` | none | `_count' = _count + 1` | displayed value increases by 1 |
| `decrement` | none | `_count' = _count > 0 ? _count - 1 : 0` | displayed value decreases by 1, or stays `0` |
| `reset` | none | `_count' = 0` | displayed value becomes `0` |

**Invariants**

- `_count >= 0` always holds, after any sequence of events.
- Every state change occurs inside a `setState` callback; there is no other
  mutation path (FR-4).
- The displayed value is derived from `_count` on every `build`; it is never
  cached separately.
- No event performs I/O, schedules a future, or touches `BuildContext` after
  `build` returns.

**Error model.** There are no error returns and no error UI. The only rejected
operation is a decrement at `0`, which is a silent no-op by design (FR-3). This
is the analogue of a `409`/no-op response in an HTTP contract.

**Idempotency.** `reset` is idempotent (`reset∘reset = reset`). `increment` and
`decrement` are not idempotent and are not intended to be; each tap is a
distinct event.

## 4. I-3 — Rendered Selectors

| Element | Selector | Purpose |
| --- | --- | --- |
| Counter value | `ValueKey('counter-value')` on the value `Text`, content `'$_count'` | Stable find for tests without depending on layout |
| Increment control | Material button with tooltip/`Tooltip` message `Increment` | User affordance, semantics, and test selector |
| Decrement control | Material button with tooltip/`Tooltip` message `Decrement` | As above |
| Reset control | Material button with tooltip/`Tooltip` message `Reset` | As above |
| Screen title | `AppBar` title string `Stateful Counter` | Human-readable context |

Tooltips double as accessibility labels, so the test and assistive-technology
contracts stay aligned. Exact widget types (`IconButton` vs `FilledButton.icon`)
are left to the Technical Specification; the selectors above are the stable
part.

## 5. Worked Examples

### Example 1 — increment (success path)

```
Event:    tap the control whose selector is tooltip "Increment"
Before:   _count = 0, value Text = "0"
After:    _count = 1, value Text = "1"
```

### Example 2 — decrement at the floor (no-op path)

```
Event:    tap the control whose selector is tooltip "Decrement"
Before:   _count = 0, value Text = "0"
After:    _count = 0, value Text = "0"     # silent no-op, invariant preserved
```

### Example 3 — reset (idempotent path)

```
Event:    tap the control whose selector is tooltip "Reset"
Before:   _count = 3, value Text = "3"
After:    _count = 0, value Text = "0"
```

### Example 4 — rejection equivalent

There is no error surface. The closest case is Example 2: an operation that is
valid to request but has no effect. A test asserts the UI does **not** change
rather than expecting an error.

## 6. Contract → Test Map

| Contract | Widget test |
| --- | --- |
| initial `0` | pump `CounterPage`, expect `find.text('0')` |
| increment | tap `Increment`, `pump()`, expect `find.text('1')` |
| decrement | tap twice after incrementing, expect the value to step down |
| floor invariant | tap `Decrement` at `0`, expect `find.text('0')` and no `-1` |
| reset | increment twice, tap `Reset`, expect `find.text('0')` |
| FR-4 rebuild | any state change is observable only if `setState` was used |

## 7. Compatibility and Change Policy

- The stable contract is the three selectors plus the three event
  postconditions. UI restyling that preserves those is non-breaking.
- Renaming a tooltip, changing the `counter-value` key, or changing the floor
  semantics is a breaking change and must update the widget tests in the same
  diff.
- No version number is attached; this is an example, not a published package.
