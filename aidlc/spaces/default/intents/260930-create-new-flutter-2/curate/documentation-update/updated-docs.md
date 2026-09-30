# Documentation Update — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Curate / Documentation Update
- **Inputs**: `source-changes.md`, `technical-spec.md`, `release-validation-report.md`
- **Outcome**: one stale doc corrected; example docs verified accurate

## 1. Docs Inventory

| Doc | Role | State |
| --- | --- | --- |
| `2-statefull/README.md` | The example's real documentation | Accurate; unchanged |
| `2-statefull/flutter_application_2/README.md` | Generated inside the Flutter project | **Stale boilerplate** — corrected |
| Repository root `README.md` | Would index the examples | Does not exist (not created; see §4) |

## 2. Change Made

**File**: `2-statefull/flutter_application_2/README.md`

**Before** (generated template):

```markdown
# flutter_application_2

A new Flutter project.

## Getting Started
This project is a starting point for a Flutter application.
...links to Flutter docs...
```

**After**:

```markdown
# flutter_application_2

The Flutter application for the **2 — Stateful Widget** example.

See [`../README.md`](../README.md) for what the example demonstrates, which code
to read, and the commands to run, test, and analyze it.
```

**Reason**: the generated text ("A new Flutter project") is inaccurate for a
deliberately-scoped teaching example and creates a second, competing README at
the project root. Replacing it with a two-line pointer keeps one authoritative
document (the parent README) and avoids doc drift between the two. This follows
the rule *correct and remove, don't append*.

## 3. Accuracy Verification of `2-statefull/README.md`

Every documented instruction was executed during this intent and works:

| Documented command | Verified |
| --- | --- |
| `cd flutter_application_2` | Yes |
| `flutter pub get` | Yes — resolves to `material_ui 1.5.0` |
| `flutter run -d macos` | Yes — app launched, Dart VM Service available |
| `flutter test` | Yes — `+5: All tests passed!` |
| `flutter analyze` | Yes — `No issues found!` |

Content checks against the shipped code:

- "No third-party state-management package is used." — true
  (`pubspec.yaml` deps: `flutter`, `material_ui`).
- Pointer to `_CounterPageState` in `flutter_application_2/lib/main.dart` —
  correct.
- "What to notice" items 1–4 — all match the code (immutable widget, `setState`
  rebuild, derived value, floor guard).
- The "or: `flutter run -d <your-device>`" note keeps the instructions correct
  on machines without a macOS target.

No stale instructions were found in the parent README. Nothing was appended:
the file already says what a newcomer needs.

## 4. Deliberately Not Done

- **No repository-root `README.md`.** A root index listing `1-hello-world` and
  `2-statefull` would help navigation, but it is a repository-wide documentation
  decision that touches a shared file and is outside this intent's scope
  (intent §5; CR-1). Recorded as a follow-up below rather than added silently.
- **No changes to `1-hello-world/`.** Its generated README is similarly generic;
  fixing it belongs to a separate "documentation hygiene" intent, not this one.

## 5. Follow-ups (not blockers)

| # | Follow-up | Owner |
| --- | --- | --- |
| D-1 | Consider a repository-root README indexing the numbered examples. | maintainer |
| D-2 | Apply the same README-pointer treatment to `1-hello-world` for consistency. | maintainer |
| D-3 | If a shared README template is adopted, align both examples in one change. | maintainer |

## 6. Verification

The change is documentation-only: no Dart source, tests, or dependencies were
touched, so `flutter analyze` and `flutter test` are unaffected. The parent
README's commands were re-run and pass (§3).
