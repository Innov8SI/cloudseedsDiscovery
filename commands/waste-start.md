# /waste-start — Initialize Lean Waste Analysis Session

Initialize a new engagement. Ask the following questions **one at a time**, waiting for the answer before asking the next.

## Step 1: Collect context

Ask in sequence:

1. "Who's the client? (company name)"
2. "What industry / what do they do in one sentence?"
3. "Who am I talking to today — your name and role?"
4. "What's the estimated average hourly rate of the people we'll be analyzing? (If unsure, I'll default to $75/hr)"
5. "How many workflows are we targeting to map in this engagement?"
6. "Any context I should know before we start? (org size, known pain points, trigger for this analysis)"

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
  "hourly_rate": [rate],
  "target_workflows": [N],
  "workflows_mapped": [],
  "wastes_identified": 0,
  "status": "mapping"
}
```

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
