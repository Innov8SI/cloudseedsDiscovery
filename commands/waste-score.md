# /waste-score — Score All Wastes and Calculate ROI

Read the full `waste-log.md` and run the scoring model across all wastes. Produce a prioritized ranking with ROI estimates.

---

## Step 1: Load data

Read:
- `sessions/[slug]/waste-log.md` — full waste inventory
- `sessions/[slug]/session.json` — hourly rate, client info

---

## Step 2: Confirm or refine scores

For any waste where scores are provisional (marked with `?`), ask the user to confirm:

"Before I calculate ROI, I need to confirm a few scores. I'll go one at a time."

For each unconfirmed waste:
```
Waste W[NN]: [Short description]

Current scores:
  Frequency: [N]/5 — [reasoning]
  Time Cost: [N]/5 — [reasoning]
  Auto Potential: [N]/5 — [reasoning]
  Biz Impact: [N]/5 — [reasoning]

Do these look right, or would you adjust anything?
```

Wait for confirmation before moving to next waste. If all scores are already confirmed, skip this step.

---

## Step 3: Calculate scores and ROI

For each waste:

**Weighted Score:**
```
Score = (Frequency × 0.25) + (TimeCost × 0.30) + (AutoPotential × 0.25) + (BizImpact × 0.20)
```

**Tier:**
- 4.0–5.0 → 🔴 High Priority
- 2.5–3.9 → 🟡 Medium Priority
- 1.0–2.4 → ⚪ Low Priority

**Auto Potential → Automation %:**
| Score | Automation % |
|---|---|
| 5 | 90% |
| 4 | 70% |
| 3 | 50% |
| 2 | 30% |
| 1 | 20% |

**ROI Calculation per waste:**
```
Weekly instances    = [volume from workflow metadata]
Time per instance   = [minutes] ÷ 60 → hours
Annual waste hours  = Weekly instances × Time per instance × 52
Annual waste cost   = Annual waste hours × [hourly_rate from session.json]
Annual savings      = Annual waste cost × Automation %
```

**Implementation effort estimate (based on auto potential + complexity):**
| Auto Score | Estimated Impl Cost |
|---|---|
| 5 | $5,000–$15,000 |
| 4 | $15,000–$40,000 |
| 3 | $40,000–$80,000 |
| 2 | $80,000–$150,000 |
| 1 | Not recommended |

**Payback = Implementation Cost (midpoint) ÷ (Annual Savings ÷ 12)**

---

## Step 4: Output Scored Waste Table

```markdown
## Scored Waste Inventory — [Client Name]

| ID | Workflow | Type | Description | Score | Tier | Annual Hours | Annual Cost | Savings | Payback |
|---|---|---|---|---|---|---|---|---|---|
| W01 | ... | T | ... | 4.3 | 🔴 | 240h | $18,000 | $12,600 | 3.2mo |
...

**Totals:**
- Total waste identified: [N] wastes across [M] workflows
- Total annual waste hours: [X]h
- Total annual waste cost: $[X]
- Total savings opportunity: $[X]/yr
- Weighted avg payback: [X] months
```

---

## Step 5: Categorize into Quick Wins vs Big Bets

**Quick Wins** = Score ≥ 3.5 AND Auto Score ≥ 4 AND Impl Cost < $40k
**Big Bets** = Annual Savings > $50k (regardless of impl cost)
**Deprioritize** = Score < 2.5 OR Auto Score ≤ 1

Output:

```markdown
## 🏃 Quick Wins (Do These First)
[Top 3-5 by score, sorted by payback period]

## 🎯 Big Bets (Plan These Carefully)
[Top 3 by annual savings]

## ⚪ Deprioritized
[Anything scored < 2.5 — brief mention, not detailed]
```

---

## Step 6: Save and prompt

Save updated scores back to `waste-log.md`. Update `session.json` status to `"scoring_complete"`.

```
✅ Scoring complete.
[N] wastes scored. Total savings opportunity: $[X]/yr

Ready to build the scorecard? Run /waste-scorecard to generate 
the full deliverable (MD + DOCX + HTML).
```
