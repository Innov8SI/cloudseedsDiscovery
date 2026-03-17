# /waste-identify — Run TIMWOODS Waste Identification

Run a structured Lean waste identification pass over the most recently mapped workflow (or a named workflow if specified).

---

## Step 1: Confirm target

Read the most recent workflow from `sessions/[slug]/workflows/`. Confirm:

"Running TIMWOODS identification on: **[Workflow Name]**. Let me analyze it."

---

## Step 2: TIMWOODS Pass

Work through each waste type systematically. For each type, check if it exists in this workflow. If yes, describe the specific instance.

### Transportation (T) — Data movement & re-entry
- Is data copied from one system to another manually?
- Does the same information get re-entered in multiple places?
- Are files emailed/downloaded/uploaded between systems that could be integrated?

### Inventory (I) — Work piling up
- Where does work queue up waiting to be processed?
- Are there batch runs that delay processing (daily/weekly reports)?
- Is there a backlog that grows faster than it's cleared?

### Motion (M) — Unnecessary navigation
- How many system switches per instance of this workflow?
- Are there repetitive search → copy → paste patterns?
- Could any navigation be eliminated with a better interface or automation?

### Waiting (W) — Process stops
- Where does the workflow pause and why?
- Are there approval chains? How long do they typically take?
- Any SLA-driven waits (e.g., "we wait 48h before following up")?

### Overproduction (O1) — Creating more than needed
- Are reports generated that nobody reads?
- Is work done in anticipation of requests that never come?
- Are documents created in duplicate (Word + system notes + email summary)?

### Overprocessing (O2) — Redundant steps
- Are there verification steps that duplicate each other?
- Is work reviewed multiple times without adding value?
- Are there manual steps that could be eliminated entirely?

### Defects (D) — Errors and rework
- What breaks in this workflow and how often?
- What percentage of instances require correction or rework?
- Are there downstream effects of errors (escalations, complaints, delays)?

### Skills (S) — Misallocated talent
- Are senior people doing data entry or clerical work?
- Is specialized knowledge used for tasks that could be standardized?
- Are there tasks that only one person knows how to do (single point of failure)?

---

## Step 3: Output Identified Wastes

For each waste found, output in this format:

```
### 🔴 [WASTE TYPE] — [Short Name]

**Workflow:** [workflow name]
**Description:** [specific description of the waste in this workflow]
**Example:** "[concrete example from the workflow]"
**Estimated frequency:** [how often per workflow instance]
**Estimated time cost:** [minutes/hours wasted per instance]
**Automation potential:** [what could eliminate this and how]
```

Group by TIMWOODS type. At the end, show a summary count:

```
## Wastes Identified: [N]

| Type | Count |
|---|---|
| Transportation | N |
| Inventory | N |
| Motion | N |
| Waiting | N |
| Overproduction | N |
| Overprocessing | N |
| Defects | N |
| Skills | N |
```

---

## Step 4: Append to Waste Log

For each identified waste, append a row to `sessions/[slug]/waste-log.md`:

```
| W[NN] | [Workflow Name] | [Type] | [Short description] | [1-5] | [1-5] | [1-5] | [1-5] | [score] | [tier emoji] |
```

Use these preliminary scores based on what's extractable from the description:
- If time cost is mentioned specifically, score accordingly
- If frequency is described as "every time" → 5, "often" → 4, "sometimes" → 3, etc.
- For automation potential: if an obvious AI/integration solution exists → 4-5

Update `wastes_identified` count in `session.json`.

---

## Step 5: Prompt next action

```
✅ TIMWOODS complete for [Workflow Name]
[N] wastes logged. Total across engagement: [total N]

What's next?
- /waste-workflow — map another workflow
- /waste-score — score all wastes and calculate ROI
- /waste-status — see full session summary
```
