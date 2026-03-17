# /waste-status — Session Progress Summary

Read session state and print a clean status report. No questions, no prompts — just facts.

---

## Output format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LEAN WASTE ANALYSIS — SESSION STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Client:    [client name]
Industry:  [industry]
Analyst:   [name]
Started:   [date]
Status:    [mapping | scoring | complete]

WORKFLOWS
  Mapped:   [N] / [target]
  [list each mapped workflow with ✓]

WASTES
  Identified: [N]
  Scored:     [N]
  
  By type:
    🚚 Transportation:   [N]
    📦 Inventory:        [N]
    🏃 Motion:           [N]
    ⏳ Waiting:          [N]
    📤 Overproduction:   [N]
    🔁 Overprocessing:   [N]
    ❌ Defects:          [N]
    🧠 Skills:           [N]

  By tier:
    🔴 High Priority:    [N]
    🟡 Medium Priority:  [N]
    ⚪ Low Priority:     [N]

FINANCIALS (if scoring complete)
  Annual waste cost:      $[X]
  Savings opportunity:    $[X]/yr
  Quick wins potential:   $[X]/yr

NEXT STEP
  [One line: what the logical next action is]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

If no session exists, say: "No active session. Run /waste-start to begin."
