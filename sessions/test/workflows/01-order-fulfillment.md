# Workflow: Order Fulfillment
*Mapped: 2026-03-17*

## Mermaid Diagram

```mermaid
flowchart LR
  classDef wait fill:#FFF3CD,stroke:#F39C12,color:#000
  classDef system fill:#D5E8F0,stroke:#2E86AB,color:#000
  classDef decision fill:#F8D7DA,stroke:#C0392B,color:#000

  subgraph Customer["Customer"]
    C1[Send order via email]
  end

  subgraph SalesRep["Sales Rep"]
    S1[Enter order into SAP\n15 min]
    S2[Send shipping\nconfirmation email\n5 min]
  end

  subgraph SAP["SAP"]
    SA1[Generate pick list]:::system
    SA2[Order status updated\n3 min]:::system
  end

  subgraph WarehouseTeam["Warehouse Team"]
    W1[Print & walk pick\nlist to warehouse]:::wait
    W2[Pick items\n20 min]
  end

  subgraph WarehouseLead["Warehouse Lead"]
    WL1{Pick matches order?}:::decision
  end

  subgraph PackingTeam["Packing Team"]
    P1[Pack order\n10 min]
  end

  subgraph ShipStation["ShipStation"]
    SS1[Re-enter address\ncreate label\n5 min]:::system
  end

  C1 -->|"Email order"| S1
  S1 -->|"Order entered"| SA1
  SA1 -->|"Pick list printed"| W1
  W1 --> W2
  W2 -->|"Items picked"| WL1
  WL1 -->|"No — 15%"| W2
  WL1 -->|"Yes — 85%"| P1
  P1 -->|"Packed"| SS1
  SS1 -->|"Label created"| SA2
  SA2 -->|"Status updated"| S2
```

## Metadata

| Field | Value |
|---|---|
| Actors | Customer, Sales Rep, Warehouse Team, Warehouse Lead, Packing Team |
| Systems | Email, SAP, ShipStation |
| Cycle Time | ~68 min (happy path), ~98 min (with rework) |
| Volume | 80 orders/day, 400/week |
| Annual Hours | ~23,800h (happy path) + ~2,600h rework |
| Defect Rate | 15% pick discrepancies |

## Notes

- No system integration between email→SAP or SAP→ShipStation
- Sales reps doing clerical work (~20 min/order = 4.4 FTEs consumed)
- Paper-based pick list is only physical handoff
- No SLA tracking on email inbox queue
