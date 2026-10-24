# Validation and evidence

The group's report dated **14 October 2026** records a one-remote end-to-end BLE 1M experiment:

| Measure | Reported result |
|---|---:|
| Transactions with a result | 34/34 |
| Accepted / expected rejection | 33 / 1 |
| Median latency | 597 ms |
| 95th percentile latency | 1,172 ms |
| Maximum latency | 3,260 ms |

These are reported results, not measurements repeated as part of this repository update. The experiment does not demonstrate 50 simultaneous physical remotes or battery lifetime.

Before deployment, repeat the test with the exact firmware and laptop Bluetooth adapter. Record the firmware revision, scan/advertising intervals, retries, link environment, and server logs.

Available static checks and tests in the source tree are documented in `tests/`. These are not substitutes for RF end-to-end tests.
