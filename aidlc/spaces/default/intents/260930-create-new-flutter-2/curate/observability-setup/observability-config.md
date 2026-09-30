# Observability Configuration — Flutter Stateful Widget Example ("2-statefull")

- **Intent ID**: `260930-create-new-flutter-2`
- **Stage**: Curate / Observability Setup
- **Inputs**: `technical-spec.md`, `release-validation-report.md`
- **Outcome**: no runtime observability by design; developer-time signals defined

## 1. Where the Signals Live

This application is a repository example that runs on a developer's machine. It
has no server, no background process, no network, and no persistence, and CR-1
excludes telemetry, logging, and metrics. There is therefore **no production
runtime to observe**. What can be observed — and what actually protects the
example from regressing — is the set of developer-time signals below.

## 2. Non-Functional Requirement → Signal Map

| NFR | Target | Signal | How observed | Alert threshold |
| --- | --- | --- | --- | --- |
| NFR-1 local toolchain | Builds and runs on the installed SDK | `flutter build macos` / `flutter run -d macos` output | console | Build failure |
| NFR-2 minimal footprint | Only official Flutter dependencies | `pubspec.yaml` / `pubspec.lock` diff | code review | Any new non-Flutter runtime dependency |
| NFR-3 static analysis | No analyzer errors | `flutter analyze` → `No issues found!` | console | Any issue reported |
| NFR-4 readability | Single short `lib/main.dart` | file count and size | review | A second source file, or a large file |
| FR-6 regression floor | Behaviour verified | `flutter test` → 5 passed | console | Any failure or skip |

These are the meaningful observability targets for this deliverable: they are
few, high-signal, and each maps to a stated requirement (targets drive signals).

## 3. Logs, Metrics, Traces

| Signal type | Configuration |
| --- | --- |
| Structured logs | **None.** No logging framework, no `print`, no `debugPrint` in authored code. Debug builds may show Flutter's default framework messages; that is tooling output, not application telemetry. |
| Metrics | **None.** No counters, timers, or exporters. |
| Traces | **None.** No distributed calls exist to trace. |
| Crash reporting | **None.** Adding one (e.g. Sentry/Firebase Crashlytics) would add a runtime dependency and violate CR-1/NFR-2. |

The deliberate absence is the configuration. If a future intent adds telemetry,
it must first change CR-1 and add the dependency through the normal review path.

## 4. Dashboards and Alerts

- **Dashboards**: none. There is no time-series data to plot.
- **Alert routing**: none. No pager, no on-call rotation, no notification channel.
- **Anti-noise rule**: rather than inventing alerts for a local app, the project
  keeps zero alerts. An alert nobody can act on is worse than none (SRE
  principle); the repo's team memory says to delete alerts nobody acts on.

## 5. SLOs and Error Budget

Not applicable: there is no service, no request path, and no availability or
latency target to measure (the technical spec states no performance budget).
The nearest proxy is the **pre-merge gate**:

| Gate | Objective | Budget |
| --- | --- | --- |
| `flutter analyze` | 100% clean (0 issues) | 0 issues |
| `flutter test` | 100% pass (5/5) | 0 failures, 0 skips |
| Desktop build | Compiles on the pinned SDK | 0 failures |

Exceeding any of these is equivalent to exhausting the budget: fix before merge.

## 6. What the Maintainer Watches

- At PR time: run the three commands from §5 and read the output.
- On a dependency bump: re-check NFR-2's signal (no new non-Flutter package) and
  re-run the suite (`material_ui` minor drift is REG-R3).
- Nothing at runtime.

## 7. Requirement Coverage

| Requirement | How this document addresses it |
| --- | --- |
| NFR-3 | Names `flutter analyze` as the signal and the zero-issue threshold |
| NFR-1 | Names the build/run output as the signal |
| NFR-2 | Names the dependency diff as the signal |
| NFR-4 | Names file count/size as the signal |
| FR-6 | Names the test pass count as the signal |
| CR-1 | Records that logs, metrics, traces, and crash reporting are intentionally absent |

## 8. Status

No observability code or configuration files are added to the repository — doing
so would contradict CR-1. This record exists so the omission is a documented
decision, not an oversight.
