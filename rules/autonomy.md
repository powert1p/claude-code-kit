# Autonomy Protocol — for ALL agents

## Main Rule
NEVER ask the user TECHNICAL questions.
Don't write "should I proceed?" — PROCEED.
Don't write "is this approach OK?" — architect decided, DO IT.

### CAN ask (via coordinator -> user)
- Business logic not in docs/product.md ("how do you calculate retention?")
- Priorities ("do A or B first?")
- Domain knowledge ("what does 'qualified lead' mean for your business?")

### CANNOT ask
- Where to put a file -> read docs/module-map.md
- Which pattern -> read existing code via Grep/Glob
- How to fix a bug -> read error message, search in code, then on the internet
- Plan approval -> planner agent approves, not human

---

## Decision Tree

### DECIDE YOURSELF
- Architecture: choice between 2 approaches -> take the simpler one
- Type/interface: don't know -> read backend schema
- File: where to put -> read module-map.md
- Import: which path -> grep existing code
- Test: what to test -> happy path + error + edge case

### ESCALATE TO COORDINATOR (message coordinator)
- Spec contradicts existing code
- Need to change >10 files not mentioned in spec
- 3 attempts to fix an error didn't help

### ESCALATE TO HUMAN (coordinator -> user)
- DROP TABLE / DROP COLUMN / DELETE without WHERE
- Deploy to production
- Auth/security change not specified in spec
- 3+ failed cycles at coordinator level
- Business question with no answer in docs/product.md

---

## Error Recovery

1. Error -> read error message carefully
2. Attempt #1 -> fix -> run tests
3. Attempt #2 -> different approach -> run tests
4. **BEFORE attempt #3 -> MANDATORY WebSearch/context7** for the error. Don't guess — search
5. Attempt #3 -> with findings -> run tests
6. If still broken -> message coordinator: "Failed after 3 attempts: [error]. Tried: [what]. Found online: [what]"

---

## Context Isolation

You start with ZERO context. Read ONLY:
1. Spec file (path in task)
2. Codebase files (via Read/Grep/Glob)
3. PROJECT.md (general project context)

Do NOT rely on chat history or messages from other agents without verification. If you were told "API shape is X" — verify in code that it's true.

---

## Test Protection

UNACCEPTABLE to modify or delete existing tests to make code pass.
- Test fails -> fix the CODE, NEVER the test
- Only exception: test covers removed functionality (explicitly stated in spec)
- If you can't understand why a test fails -> message coordinator, do NOT delete the test

---

## File Ownership

Within one wave EACH file belongs to EXACTLY ONE agent.
- Two agents do NOT modify one file in the same wave
- If two changes in one file -> combine into one task OR separate into waves
- Architect determines ownership in JSON task block of the spec

---

## Definition of Done

### Code Implementation
- [ ] Code has no syntax errors
- [ ] All existing tests pass
- [ ] New tests written (happy + error + edge)
- [ ] Follows project patterns (check module-map)
- [ ] SQL is parameterized. No f-strings
- [ ] No hardcoded secrets
- [ ] Comments in Russian

### Data Pipeline
- [ ] Migration is idempotent (IF NOT EXISTS, ON CONFLICT)
- [ ] MV: UNIQUE INDEX for REFRESH CONCURRENTLY
- [ ] SQL verified: NOT NULL, NOT 0
- [ ] Key metric deviation <5%

### Frontend
- [ ] TypeScript types match backend schemas
- [ ] Data fetching via proper library (NOT useState+useEffect)
- [ ] Component <150 lines, Tailwind only
- [ ] `npx tsc --noEmit` passes
- [ ] Playwright verification: snapshot + console + screenshot

### Test
- [ ] Happy path
- [ ] Error case (invalid input, 404, 403)
- [ ] Edge case (null, empty, 0)
- [ ] Project tests pass
- [ ] No sleep/setTimeout in tests

---

## Communication

- **Message coordinator**: when task is complete, blocked, or need decision
- **Message teammate**: when passing artifact (API shape, types, test results)
- **NEVER message human directly** — everything through coordinator
- Message format: concrete facts, not opinions. Write file:line, SQL results, error output
