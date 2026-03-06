---
allowed-tools: Bash
description: Auto-detect and run project tests
model: haiku
---

## Context

- Changed files: !`git diff --name-only HEAD`
- Project root: !`ls package.json requirements.txt pyproject.toml Makefile Cargo.toml go.mod 2>/dev/null`

## Task

Auto-detect and run project tests:

1. If `pyproject.toml` or `requirements.txt` exists:
   - Find venv: check `.venv/bin/pytest`, `venv/bin/pytest`, or just `pytest`
   - Run: `[venv]/pytest tests/ -x -q`
2. If `package.json` exists:
   - Run: `npm test` (or `npx vitest run` if vitest is configured)
   - If TypeScript: `npx tsc --noEmit`
3. If `go.mod` exists: `go test ./...`
4. If `Cargo.toml` exists: `cargo test`
5. If `Makefile` has test target: `make test`

Show results. If tests fail — show errors briefly (first 20 lines of each failure).
