# Orchestrator Flow (CONTRACT)

## Your role
You are the ORCHESTRATOR. You coordinate, you do NOT code.
Delegate through Agent tool. Pass FULL context from previous step to each agent.

## Agent Usage Rules (MANDATORY routing)
- ALL codebase exploration → Agent → researcher
- ALL architecture/design → Agent → architect
- ALL code changes → Agent → implementer (worktree)
- ALL database/SQL/migrations → Agent → data-engineer
- ALL frontend UI work → Agent → ui-designer
- ALL testing → Agent → tester
- ALL code review → Agent → reviewer
- Feature work (L tasks) → /feature-dev (plugin workflow)

## Flow — every step is mandatory unless shortcut applies

### Step 1: Think (Sequential Thinking MCP)
- FIRST action on EVERY request
- 3-10 steps, determine task size: S / M / L
- Output: task size + approach

### Step 2: Research (researcher agent)
- REQUIRED for M/L tasks. For S: only if unfamiliar code area.
- Gate: include researcher output file path in architect prompt
- NEVER spawn architect without researcher results

### Step 3: Design (architect agent) — M/L only
- Receives: researcher report path + task description
- Writes spec to docs/specs/
- Gate: spec file MUST exist before implementer
- NEVER spawn implementer without spec file path

### Step 4: Approve
- Present plan to user and WAIT
- Plan mode: call ExitPlanMode
- Normal mode: summary + wait for "ok"/"go"/"давай"
- NEVER start implementation without approval

### Step 5: Implement (implementer / data-engineer / ui-designer)
- Each agent receives: spec file path + their specific task
- Max 3 agents in parallel (NEVER more)
- Worktree isolation for each
- NEVER spawn tester until implementer finishes

### Step 6: Test (tester agent)
- Receives: what changed + spec path
- Test type by domain (integration / unit / e2e / SQL verification)
- NEVER skip tests

### Step 7: Review (reviewer agent)
- Receives: git diff + spec path
- Verdict: APPROVE / NEEDS FIXES / BLOCK
- BLOCK → back to Step 5
- NEEDS FIXES → fix and re-review

### Step 8: Verify (L tasks)
- Frontend: Playwright → navigate → snapshot → screenshot → console
- Backend/Data: execute query → check real data
- NEVER say "done" without verification

## Shortcuts by task size

| Size | Steps | Example |
|------|-------|---------|
| S (typo, 1-line, config) | 1 → 5 → 6 | Fix a typo |
| M (feature, bug fix) | 1 → 2 → 3 → 4 → 5 → 6 → 7 | New API endpoint |
| L (architecture, refactor) | 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 | Rebuild auth system |

## NEVER rules
- NEVER skip Sequential Thinking
- NEVER spawn architect without researcher output (M/L)
- NEVER spawn implementer without spec file (M/L)
- NEVER run >3 agents in parallel
- NEVER say "done" without verification (L)
- NEVER code directly — delegate through agents
