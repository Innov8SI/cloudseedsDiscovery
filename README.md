# Lean Waste Analyst — Claude Code Tool

A structured Lean Waste Analysis agent that runs inside Claude Code. Map workflows, identify TIMWOODS waste, score impact, and generate a full scorecard in MD + HTML + DOCX.

---

## Setup

```bash
cd lean-waste-analyst
claude
```

That's it. Claude Code reads CLAUDE.md and becomes your Lean Waste Analyst.

---

## Workflow

```
/waste-start        → new engagement, collect client context
/waste-workflow     → describe or paste a transcript, get Mermaid diagram
/waste-identify     → TIMWOODS pass on the mapped workflow
/waste-score        → score all wastes, calculate ROI
/waste-scorecard    → generate final deliverable (MD + HTML + DOCX)
/waste-status       → check session progress anytime
```

---

## Input formats for /waste-workflow

All of these work:

- **Written description:** "Our invoice processing starts when..."
- **Bullet points:** "1. AP team receives invoice by email 2. They open SAP..."  
- **Raw call transcript:** Paste the full transcript, speakers and all
- **Audio summary:** Paste Whisper or Otter.ai transcript output
- **Stream of consciousness:** Just describe it naturally, Claude will structure it

For audio: transcribe first with Whisper, Otter.ai, or any tool, then paste the text.

---

## Output

After `/waste-scorecard`:

```
sessions/[client-slug]/
├── session.json
├── waste-log.md
├── workflows/
│   ├── 01-[workflow-name].md
│   └── 02-[workflow-name].md
└── scorecard/
    ├── scorecard.md
    ├── scorecard.html
    └── scorecard.docx
```

---

## Behind the scenes

- **TIMWOODS framework** adapted for knowledge work and operations (not just manufacturing)
- **Scoring model:** 4-dimension weighted score (frequency, time cost, automation potential, business impact)
- **ROI model:** Annual waste hours × hourly rate × automation % → savings vs implementation cost → payback period
- **Roadmap logic:** Phase 1 = Quick Wins (<6mo payback), Phase 2 = build, Phase 3 = Big Bets

---

## Based on engagements with

- Amwell (healthcare operations, 15 workflows)
- Lazer Logistics (yard management, dispatch, invoicing)
- Futura DDB (agency operations)
