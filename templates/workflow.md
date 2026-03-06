# Autonomous Development Workflow

This workflow executes WITHOUT human involvement.
Exceptions: destructive DB operations, deploy, 3+ failed retries, business questions.

---

## 1. Identify Task
- Read PROJECT.md -> find `<<<` marker
- Read linked sprint spec / plan file
- Determine type: feature / data-pipeline / bug / refactor

## 2. Route by Complexity

| Complexity | Criteria | Team |
|------------|----------|------|
| Simple | 1 file, <20 lines | single implementer |
| Medium | 2-5 files | scout -> architect -> implementer(s) -> reviewer |
| Complex | 6+ files | scout -> architect -> planner -> waves -> tester -> reviewer |

For Simple — skip steps 3-6, go straight to Execute.

## 3. Scout (web research)
- Spawn scout teammate (Sonnet, maxTurns: 40)
- Scout searches for: ready solutions, current APIs, best practices, known bugs
- Scout uses: WebSearch, WebFetch, context7 MCP
- Scout report is passed to architect

## 4. Deep Architecture
- Spawn architect teammate (Opus, maxTurns: 200)
- Architect reads: PROJECT.md, module-map, architecture, scout report, existing code
- Architect writes spec: `docs/specs/ARCH-{task-id}.md`
  - Exact files, function signatures, SQL, API contracts
  - JSON task block with tasks, owners, waves
  - Each task < 35 minutes (~50 turns)
  - File ownership: one file = one agent per wave
- Architect messages coordinator when spec is ready

## 5. Validate
- Spawn planner teammate (Sonnet, maxTurns: 40)
- Planner checks spec AUTONOMOUSLY
- APPROVED -> proceed. NEEDS REVISION -> message architect (up to 3 times)
- Do NOT ask human. Planner = decision maker

## 6. Spec Checkpoint
- `git add docs/specs/ARCH-{id}.md && git commit -m "spec: ARCH-{id}"`
- BEFORE any implementation
- If a wave fails — recovery from spec

## 7. Decompose into Waves
- Coordinator reads JSON task block from spec
- Groups by waves (from `wave` field)
- Wave 1: tasks without dependencies (parallel)
- Wave 2: tasks depending on wave 1
- Wave N: until done

## 8. Execute
- Per wave: spawn teammates for each task
- Each teammate gets: spec path + specific task + files
- Teammates in worktree isolation (no file conflicts)
- Coordinator waits for entire wave to complete before next
- On 2+ errors at teammate -> teammate must WebSearch before 3rd attempt

## 9. Test
- Run project tests (determine command from package.json, pyproject.toml, Makefile)
- TypeScript: `npx tsc --noEmit`
- Frontend features: Playwright MCP (browser_snapshot + browser_console_messages)
- If tests fail -> create fix tasks -> assign to implementer -> retry

## 9.5 Verify (data tasks only)
- Spawn verifier teammate with DB access
- NOT NULL, NOT 0 on key fields
- Key metric deviation <5%
- If PROBLEMS -> coordinator creates fix tasks

## 10. Review
- Spawn reviewer teammate
- Reviewer checks git diff
- BLOCKS COMMIT -> reviewer messages implementer -> fix -> re-review (max 3 cycles)
- OK -> coordinator commits

## 10.5 DONE Report (MANDATORY)

Coordinator creates `docs/reports/DONE-{task-id}.md`.

Data sources:
- **Business result**: from spec (Summary + Acceptance Criteria)
- **What appeared**: from spec (Files to Create, API Contract, Frontend Contract)
- **Screenshots**: from tester report (Playwright screenshots in `docs/reports/screenshots/`)
- **How to verify**: coordinator writes step-by-step instruction based on acceptance criteria
- **Tests**: from tester report (section "Business Summary")
- **Data verification**: from verifier report
- **Limitations**: from spec (Out of Scope)

IMPORTANT: report is written for vibe-coder. No code, no file paths, no SQL.
Only business language: "now you can download the report as Excel" instead of "added GET /api/v1/export/report".

## 11. Complete
- `git add docs/reports/DONE-{task-id}.md docs/reports/screenshots/`
- `git commit` with descriptive message
- Update PROJECT.md: mark `[x]`
- Final message:
  ```
  {task_id} done.
  Read report: docs/reports/DONE-{task-id}.md
  ```
- Workspace is complete.

## Recovery (if session was interrupted)
- Open the same workspace -> agent will continue (context preserved in Conductor)
- Or create new workspace with same prompt -> agent reads PROJECT.md + git log
