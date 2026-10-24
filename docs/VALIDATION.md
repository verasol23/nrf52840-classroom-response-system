# Validation and measured scope

The group report dated **14 October 2026** documents one physical nRF52840 remote in BLE 1M mode:

| Reported measurement | Result |
|---|---:|
| Transactions receiving result | 34 / 34 |
| Accepted / expected rejection | 33 / 1 |
| Median remote-to-result latency | 597 ms |
| 95th percentile remote-to-result latency | 1,172 ms |
| Maximum remote-to-result latency | 3,260 ms |

These are **report-derived** observations, not retested in this release. They must not be applied to the new experimental ADV17 code without re-verifying the physical test setup. The report did not validate dozens of actual remotes simultaneously or battery runtime.

Firmware / receiver compatibility should be verified as described in [FIRMWARE_COMPATIBILITY.md](FIRMWARE_COMPATIBILITY.md). Source syntax checks, unit tests and a KiCad JSON report are evidence of specific limited checks, not a certification of integrated hardware.
