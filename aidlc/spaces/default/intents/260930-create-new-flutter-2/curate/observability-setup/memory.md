# Observability Setup — Memory Diary

## Interpretation

- 2026-09-30 — Ran this ALWAYS stage rather than skipping it, but produced a
  record of **deliberate absence**: the app has no runtime, and CR-1 forbids
  telemetry. Inventing dashboards and alerts for a local example would have been
  exactly the noise the SRE principles warn against.
- 2026-09-30 — Recast the NFRs as developer-time signals (analyze, test, build,
  dependency diff), because those are the targets that can actually be observed
  and that protect the example from regression.

## Tradeoff

- 2026-09-30 — Kept the alert count at zero and documented why, instead of adding
  a low-value "build failed" notification. Cost: no automated notification of a
  broken build. Benefit: no dead alert channel and no CI dependency, consistent
  with the CI/DEPLOY skip decisions.

## Open question

- 2026-09-30 — If the repository later adopts CI (see `release-validation`
  memory), the pre-merge gate in §5 becomes enforceable automatically. Until
  then it is a manual, reviewer-owned gate.
