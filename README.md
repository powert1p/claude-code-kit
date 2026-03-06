# Claude Code Kit

Production-ready setup for Claude Code: 11 agents, 6 commands, autonomous coordinator pattern.

## What's Inside

### Agents (11)
| Agent | Role |
|-------|------|
| architect | Designs specs down to function signatures |
| implementer | Writes code for a specific subtask |
| reviewer | Code review by quality and security checklist |
| tester | Writes and runs tests (pytest, vitest, Playwright) |
| planner | Autonomous spec validation (APPROVED/NEEDS REVISION) |
| researcher | Explores codebase before implementation |
| verifier | Data verification via SQL (minimum 5 queries) |
| data-engineer | Migrations, MV, ETL pipeline |
| scout | Web researcher (market, APIs, best practices) |
| deployer | Deploy with pre-flight, health check, verification |
| pm | Project Manager — interface with the customer |

### Commands (6)
| Command | What it does |
|---------|-------------|
| /plan-big | From idea to master plan (scouts -> PM -> synthesis) |
| /plan-sprints | Decomposition into sprints (PM -> Architect -> Planner -> Issues) |
| /commit | Smart commit with AI-generated message |
| /test | Auto-detect and run project tests |
| /pm | PM mode: requirements gathering, status, launching workspaces |
| /code-review | Full code review by checklist |

### Rules
- `autonomy.md` — autonomy protocol (agents don't ask permission)
- `tests.md` — test rules (never delete tests)
- `security.md` — security (SQL injection, auth, secrets)

### Optional Rules (stack-specific)
- `python-backend.md` — Python + FastAPI + asyncpg
- `react-frontend.md` — React + TypeScript + Tailwind
- `sql.md` — SQL migrations

### Templates
- `CLAUDE.md` — coordinator pattern (agent coordinates, doesn't code)
- `workflow.md` — autonomous 11-step pipeline

## Installation

```bash
git clone https://github.com/powert1p/claude-code-kit.git
cd claude-code-kit
chmod +x install.sh
./install.sh
```

To remove:

```bash
./uninstall.sh
```

## How It Works

**Coordinator pattern**: the main agent does NOT write code itself. It:
1. Reads PROJECT.md -> determines the task
2. Classifies complexity (simple/medium/complex)
3. Spawns the right agents (scout -> architect -> implementer -> tester -> reviewer)
4. Monitors results, commits

## Workflow

```
/plan-big "Product description"       -> master plan (phases/waves)
/plan-sprints docs/specs/PHASE.md     -> sprints + GitHub Issues
# In Conductor: each issue = workspace -> agent implements autonomously
```

## Customization

1. Copy `templates/CLAUDE.md` to `~/.claude/CLAUDE.md`
2. Fill in sections marked with `<!-- CUSTOMIZE -->`
3. Add your own rules to `~/.claude/rules/`

## File Structure

```
claude-code-kit/
  agents/           # 11 agent definitions
    architect.md
    implementer.md
    reviewer.md
    tester.md
    planner.md
    researcher.md
    verifier.md
    data-engineer.md
    scout.md
    deployer.md
    pm.md
  commands/          # 6 slash commands
    commit.md
    plan-big.md
    plan-sprints.md
    pm.md
    code-review.md
    test.md
  rules/             # Core rules (always install)
    autonomy.md
    tests.md
    security.md
  rules-optional/    # Stack-specific rules (install selectively)
    python-backend.md
    react-frontend.md
    sql.md
  templates/         # CLAUDE.md and workflow templates
    CLAUDE.md
    workflow.md
  examples/          # Example PROJECT.md
    PROJECT.md
  install.sh
  uninstall.sh
```

## Philosophy

- **Agents don't ask questions** — they read the code and decide
- **Coordinator doesn't code** — only manages and monitors
- **Every task is spec'd first** — architect writes, planner validates
- **Parallel execution** — independent tasks run in parallel waves
- **Self-healing** — on error, agents search the web before 3rd attempt
- **Test protection** — never delete or modify existing tests to make code pass

## License

MIT
