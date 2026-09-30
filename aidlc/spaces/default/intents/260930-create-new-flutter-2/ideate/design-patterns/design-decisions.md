# Design Decisions — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Inputs**: `architecture-doc.md`, `requirements.md`
- **Status**: proposed (Ideate)

Format: ADR-style. Every decision is either cheaply reversible or explicitly
justified as a one-way door.

## Decision Summary

| ID | Decision | Pattern / Technology | Status | Reversible? |
| --- | --- | --- | --- | --- |
| ADR-001 | Framework-native local UI state | StatefulWidget / State + `setState` | Accepted | Yes (swap the state holder) |
| ADR-002 | Declarative rebuild from state | Unidirectional data flow | Accepted | Yes |
| ADR-003 | Single-responsible-widget composition | One `StatefulWidget`, inline UI | Accepted | Yes |
| ADR-004 | Clamp decrement at zero with a guard | Guard clause / invariant enforcement | Accepted | Yes |
| ADR-005 | Stable test selectors | Tooltips + `ValueKey`, arrange-act-assert tests | Accepted | Yes |
| ADR-006 | Follow the current `flutter create` template | Official `material_ui` package | Accepted (deviation recorded) | Yes |
| ADR-007 | No persistence | In-memory only | Accepted | Yes |
| ADR-008 | Keep the slug `2-statefull` verbatim | Naming convention | Accepted | No (rename touches paths/imports) |

---

## ADR-001 — Use the framework's own state mechanism

- **Context**: The example exists to teach how Flutter holds mutable state. The
  intent says "using Stateful pattern"; CR-1 forbids third-party state
  management; NFR-2 forbids non-Flutter runtime dependencies.
- **Decision**: Model the counter as an `int` field on a
  `State<CounterPage>` object and mutate it only through `setState`.
- **Alternatives**: `ValueNotifier` + `ValueListenableBuilder`; `InheritedWidget`
  or an app-level store; Provider/Riverpod/Bloc (third-party).
- **Consequences**: The pattern is the framework's default, so the code matches
  Flutter documentation and example 1's extension path. It does not teach
  fine-grained rebuilds or dependency injection, which is acceptable at this
  level and can be a later example.
- **Status**: Accepted.

## ADR-002 — Rebuild declaratively from state

- **Context**: The UI must reflect the counter after every change.
- **Decision**: `build` derives the displayed string from `_count` on every
  frame; no widget mutates another widget's text imperatively.
- **Alternatives**: `TextEditingController`-style imperative mutation;
  `GlobalKey` access; manual `setState` on unrelated widgets.
- **Consequences**: One-way flow — event → `setState` → rebuild — is visible in a
  single method, which is the lesson. Cost: the whole page rebuilds on each tap,
  which is irrelevant at this size.
- **Status**: Accepted.

## ADR-003 — One widget, inline UI

- **Context**: NFR-4/CON-5 require a single short, readable file; the
  architecture chose Option A.
- **Decision**: Keep `MainApp`, `CounterPage`, and `_CounterPageState` in
  `lib/main.dart` and build the page inline.
- **Alternatives**: Extract a stateless `CountDisplay`; a `lib/src/` tree;
  separate files per widget.
- **Consequences**: A newcomer reads the entire example top to bottom. Cost: the
  file will need splitting if the example ever grows; documented as the natural
  next step rather than done now.
- **Status**: Accepted.

## ADR-004 — Enforce the non-negative invariant with a guard

- **Context**: FR-3 requires the counter never to display a negative value.
- **Decision**: `_decrement` runs `if (_count > 0) { _count -= 1; }` inside
  `setState`; the control is never disabled or hidden.
- **Alternatives**: Disable the decrement button at `0` (adds disabled-state UI);
  allow negatives (violates FR-3); throw/clamp in the model layer (over-scoped).
- **Consequences**: Behaviour is simple and testable, and the button remains a
  constant target for tests. Cost: a tap at `0` gives no feedback; acceptable for
  a counter example.
- **Status**: Accepted.

## ADR-005 — Stable selectors for tests

- **Context**: Tests must assert state changes without breaking on layout or
  widget-type changes; accessibility labels are also desirable.
- **Decision**: Give the value `Text` a `ValueKey('counter-value')` and each
  action control a tooltip (`Increment`, `Decrement`, `Reset`). Widget tests use
  `find.byKey`, `find.byTooltip`, and `find.text`.
- **Alternatives**: Positional `find.byType`/index finders (brittle); golden
  images (brittle and platform-dependent); `find.text('+')` (depends on label).
- **Consequences**: Refactoring button types or layout keeps the tests green; the
  selectors double as semantics labels. Cost: three tooltips of extra markup.
- **Status**: Accepted.

## ADR-006 — Adopt the current `flutter create` template (deviation)

- **Context**: On Flutter `main` (3.49.0-1.0.pre) the generated template imports
  `package:material_ui/material_ui.dart` and depends on `material_ui: ^1.1.0`
  instead of importing `package:flutter/material.dart`. Example 1 already does
  this.
- **Decision**: Keep the generated dependency set; take Material widgets from
  the official `material_ui` package. Treat "no third-party dependency" as "no
  non-Flutter dependency" (CON-2).
- **Alternatives**: Rewrite imports to `package:flutter/material.dart` and delete
  `material_ui` (diverges from the template and example 1); vendor Material
  (absurd).
- **Consequences**: The example matches what a reader gets from `flutter create`
  today, and `pubspec.lock` records the resolution. Cost: NFR-2's wording needed
  this clarification, now captured in the constraint register.
- **Status**: Accepted; deviation recorded here and in
  `analyze/feasibility-assessment/constraint-register.md` (CON-2).

## ADR-007 — No persistence

- **Context**: A counter is the classic candidate for "remember across
  restarts".
- **Decision**: Keep `_count` in memory; relaunch resets to `0`.
- **Alternatives**: `shared_preferences` or a file (both add a plugin/dependency
  and a capability that CR-1 excludes).
- **Consequences**: The example stays dependency-free and focused on the state
  primitive. Cost: none for the stated intent.
- **Status**: Accepted.

## ADR-008 — Keep the slug `2-statefull`

- **Context**: The requested directory name misspells "stateful"; REG-R4 flagged
  it as open.
- **Decision**: Keep `2-statefull` exactly as requested and consistent with the
  `1-hello-world` numbering. The Dart package inside is named
  `flutter_application_2`, so the misspelling never reaches an identifier.
- **Alternatives**: Rename to `2-stateful` (diverges from the request and forces
  later path churn); use a descriptive slug (breaks the sequence).
- **Consequences**: This is the closest thing to a one-way door: the slug appears
  in paths and README, so renaming later is a broader diff. Accepted because the
  user asked for it verbatim and the invalid-identifier risk is neutralised by
  the nested package name.
- **Status**: Accepted.

## Patterns by Concern

| Concern | Forces | Pattern chosen | Why not the alternative |
| --- | --- | --- | --- |
| UI state | One value, one screen, must teach the primitive | `StatefulWidget` / `State` | `ValueNotifier` teaches a different lesson; packages are banned |
| Rebuild | Keep UI consistent with state | Declarative `build` from `setState` | Imperative mutation hides the flow |
| Composition | One readable file | Single responsible widget | Extracted widgets defer the core lesson |
| Input validation | Non-negative invariant | Guard clause | Disabling UI adds states out of scope |
| Testing | Assert a UI change | Arrange-act-assert widget test with stable selectors | Goldens are brittle per platform |
| Naming | Follow repo convention | Numbered slug, valid nested package name | Legal `2-statefull` package is impossible |

## Technology Choices

| Area | Choice | Version | Rationale |
| --- | --- | --- | --- |
| SDK | Flutter / Dart | 3.49.0-1.0.pre / 3.14.0 | Installed and verified locally |
| Language | Dart | 3.14 | Only language available |
| UI toolkit | Official `material_ui` | `^1.1.0` (resolves 1.5.0) | Current template; official Flutter package |
| Testing | `flutter_test` | SDK | No extra dependency |
| Lints | `flutter_lints` | `^6.0.0` | Template default; NFR-3 |
| State management | None (framework) | — | CR-1 |
| Persistence / network / routing | None | — | Scope |

## Deviations from Convention

- **ADR-006** is the only deviation: a reader might expect `package:flutter/
  material.dart` from older Flutter versions. The code follows what the tool
  generates today, and the deviation is recorded rather than silent.
