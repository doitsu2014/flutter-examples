# 2 — Stateful Widget

Shows Flutter's built-in way to hold mutable state: a `StatefulWidget` whose
`State` object owns the data and rebuilds the UI with `setState`. No third-party
state-management package is used.

The example is a counter: it starts at `0`, and the three buttons increment,
decrement (never below zero), and reset it.

## Where to look

Everything is in
[`flutter_application_2/lib/main.dart`](flutter_application_2/lib/main.dart).
Read `_CounterPageState`:

- `int _count = 0;` — the state. It lives on the `State` object, not on the
  widget, so it survives rebuilds.
- `_increment`, `_decrement`, `_reset` — the only places state changes, each
  inside `setState`.
- `build` — reads `_count` and derives the text, `'$_count'`, on every frame.

## What to notice

1. The `CounterPage` widget is immutable; `_CounterPageState` is mutable.
2. `setState` both changes the value and schedules a rebuild.
3. The displayed value is derived in `build`; it is never stored twice.
4. Decrement is a no-op at `0`, keeping the count non-negative.

## Run and verify

```bash
cd flutter_application_2
flutter pub get
flutter run -d macos   # or: flutter run -d <your-device>
flutter test
flutter analyze
```

`test/widget_test.dart` taps the buttons and asserts the displayed value
changes, so the state behaviour is verified without a device.
