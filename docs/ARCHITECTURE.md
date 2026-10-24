# System architecture and workflow

The laptop hosts the Bluetooth receiver, Mosquitto MQTT broker, Python ingest service, MariaDB, Apache and PHP portal. The **local** classroom workflow does not require an Internet connection.

```mermaid
sequenceDiagram
    participant Remote as nRF52840 Remote
    participant BLE as Laptop BLE Bridge
    participant MQTT as Mosquitto
    participant Ingest as Python Validator
    participant DB as MariaDB
    participant Web as Teacher Web
    Web->>DB: Start session / open question
    Remote->>BLE: Login or answer request
    BLE->>MQTT: Publish request
    MQTT->>Ingest: Deliver
    Ingest->>DB: Validate and store / deduplicate
    DB-->>Ingest: Persisted outcome
    Ingest->>MQTT: Publish result
    MQTT->>BLE: Return result
    BLE-->>Remote: Matching BLE acknowledgement
    Web->>DB: Display state and answers
```

The application uses transaction identity for retries: if an ACK is lost after the server commits an answer, retransmitting the same transaction should return the previously recorded outcome instead of creating an independent answer. This relies on the correct matching protocol implementation. **BLE advertising has no built-in two-way ACK;** application-level messages are required.

The source has several BLE variants: local advertising scanning, GATT/NUS, and a USB gateway. Their packet formats and version requirements differ. The uploaded ADV17 firmware explicitly requests ADV-specific bridge and ingest modules missing from the supplied original server ZIP. See [compatibility](FIRMWARE_COMPATIBILITY.md).
