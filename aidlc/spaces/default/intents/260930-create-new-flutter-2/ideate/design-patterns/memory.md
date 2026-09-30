# Design Pattern Selection — Memory Diary

## Interpretation

- 2026-09-30 — Ran the "design patterns" stage as ADR recording rather than a
  Gang-of-Four exercise: for a single widget the meaningful decisions are state
  ownership, rebuild strategy, and composition, not named structural patterns.
- 2026-09-30 — Recorded ADR-006 (adopting the template's official `material_ui`
  dependency) as an explicit **deviation**, because a reader on an older Flutter
  would expect `package:flutter/material.dart`. Deviations must be written down,
  not assumed.

## Tradeoff

- 2026-09-30 — Kept `2-statefull` (ADR-008) even though it is the one
  near-irreversible choice, because the request named it verbatim and the Dart
  package inside is legally named `flutter_application_2`. Cost: if the repo
  later prefers correct spelling, renaming touches paths and README.

## Open question

- 2026-09-30 — Concrete button widget types remain deferred to the Technical
  Specification; the selector contract (tooltips + key) already makes either
  `IconButton` or `FilledButton.icon` safe to choose.
