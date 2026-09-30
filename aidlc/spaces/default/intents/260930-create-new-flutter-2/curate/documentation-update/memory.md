# Documentation Update — Memory Diary

## Interpretation

- 2026-09-30 — Read "find stale docs" as covering the *generated* README inside
  the Flutter project, not just the authored one. Generated sample text that
  says "A new Flutter project" is technically harmless but inaccurate for a
  scoped teaching example, so it was corrected to a pointer.
- 2026-09-30 — Read "correct rather than append" strictly: the parent README was
  already accurate and complete, so nothing was added to it.

## Tradeoff

- 2026-09-30 — Did not create a repository-root README index. Cost: a newcomer at
  the repo root sees only `AGENTS.md` and the two example folders. Benefit: no
  change to shared, non-example files and no scope creep beyond the intent.
  Logged as follow-up D-1.

## Open question

- 2026-09-30 — Whether the repository wants a root index and a shared example
  README template. Both are repository-wide decisions; deferred (D-1…D-3).
