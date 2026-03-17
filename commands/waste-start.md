# /waste-start — Initialize Lean Waste Analysis Session

Initialize a new engagement. Ask the following questions **one at a time**, waiting for the answer before asking the next.

## Step 1: Collect context

Ask in sequence:

1. "Who's the client? (company name)"
2. "What industry / what do they do in one sentence?"
3. "Who am I talking to today — your name and role?"
4. "How big is the company? I need a few numbers to keep the analysis realistic:"
   - Annual revenue (e.g., €10M)
   - EBITDA or operating margin if known (e.g., 15%)
   - Number of employees
   - Average monthly salary (e.g., €3,000 gross)
   - Currency they operate in
5. "What's the estimated average hourly rate of the people we'll be analyzing? (If unsure, I'll calculate from the salary you gave me)"
6. "How many workflows are we targeting to map in this engagement?"
7. "Any context I should know before we start? (known pain points, trigger for this analysis)"

**Hourly rate calculation fallback:** If the user provides avg monthly salary but not hourly rate:
`hourly_rate = (monthly_salary × 12) / (working_days_per_year × 8)` where working_days_per_year = 220

## Step 2: Create session

After collecting answers, create the following:

**`sessions/[client_slug]/session.json`:**
```json
{
  "client": "[Client Name]",
  "client_slug": "[slugified]",
  "industry": "[industry]",
  "analyst": "[name]",
  "started": "[today's date]",
  "financials": {
    "currency": "EUR",
    "annual_revenue": 10000000,
    "ebitda": 1500000,
    "ebitda_margin_pct": 15,
    "employee_count": 50,
    "avg_monthly_salary": 3000,
    "total_annual_labor_cost": 1800000
  },
  "hourly_rate": [rate],
  "target_workflows": [N],
  "workflows_mapped": [],
  "wastes_identified": 0,
  "status": "mapping"
}
```

**Derived fields (auto-calculated):**
- `total_annual_labor_cost` = employee_count × avg_monthly_salary × 12
- `ebitda_margin_pct` = (ebitda / annual_revenue) × 100 (if EBITDA given)
- `hourly_rate` = (avg_monthly_salary × 12) / (220 × 8) if not explicitly provided

**`sessions/[client_slug]/waste-log.md`:**
```markdown
# Waste Log — [Client Name]
*Started: [date] | Analyst: [name]*

| ID | Workflow | TIMWOODS Type | Waste Description | Frequency | Time Cost | Auto Potential | Biz Impact | Score | Tier |
|---|---|---|---|---|---|---|---|---|---|
```

**`sessions/[client_slug]/workflows/`** — create empty directory.

## Step 3: Confirm and prompt

After creating files, output:

```
✅ Session initialized for [Client Name]

📁 sessions/[client_slug]/
├── session.json
├── waste-log.md
└── workflows/

Ready to map your first workflow. Run /waste-workflow and describe the workflow 
— paste a description, bullet points, or a call transcript. I'll handle the rest.
```
