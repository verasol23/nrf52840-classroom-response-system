# Firmware / server compatibility

The files in `firmware.zip` are **source history**, not all interchangeable builds.

| Source | BLE path | Notes |
|---|---|---|
| `ARS_remote_v3_10` … `v3_15` | Pre-ADV16 revisions | Inspect each revision README and corresponding server mode. |
| `ARS_remote_v3_16` | Experimental application-level ACK over Advertising | Requires ADV16 transaction ledger and server components. |
| `ARS_remote_v3_17` | ADV scheduling hotfix | `ars_ble.cpp` sets `TX_BURST_MS=400`, `STATE_TIMEOUT_MS=15000`, `Advertising.setInterval(160,160)` (= 100 ms), with scanner interval 160. |
| `ARS_remote_gatt` | GATT/NUS | Separate transport and receiver implementation. |
| `ARS_gateway_v3_10` | Serial gateway | Requires matching gateway bridge. |

**Known integration gap:** `firmware/ARS_remote_v3_17/README.md` names server components `ble_adv.py` and `ingest_adv.py`. Neither is included in the supplied server archive; the older `ble_scan.py` and `ingest.py` must not be assumed to implement the same protocol. This repository therefore does not advertise that ADV17 can be deployed as-is.

The previously discussed **ADV18** firmware (80 ms interval, 400 ms burst) was not among the supplied files and has not been fabricated here.

Before claiming end-to-end success: obtain the matching ADV receiver + transaction ingest implementation, flash the intended firmware, measure latency/retransmissions, and document exact git revision and host adapter.
