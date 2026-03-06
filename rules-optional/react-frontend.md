---
globs: "**/*.{ts,tsx,jsx}"
---

# React/TypeScript Rules

## React Query (TanStack v5)
- GET: `useQuery({ queryKey, queryFn, staleTime: 5 * 60 * 1000 })`
- POST/PUT/DELETE: `useMutation({ mutationFn, onSuccess: invalidateQueries })`
- DON'T use useState+useEffect for data fetching — React Query only
- staleTime: 5 minutes default

## Tailwind CSS
- Only Tailwind classes. No CSS-in-JS, styled-components, inline styles
- Responsive: `sm:`, `md:`, `lg:` prefixes

## Components
- One component = one file. Max 150 lines
- If larger — split into subcomponents
- PascalCase for components, camelCase for functions

## Types
- TypeScript types MUST match backend Pydantic schemas
- No `any`. Don't know the type — check backend schema

## API
- Use project's API client. Don't create fetch/axios calls directly

## Frontend Verification (MANDATORY after changes)
After ANY frontend changes, agent MUST verify via Playwright MCP:
1. Make sure dev server is running (`npm run dev` / `vite`)
2. `browser_navigate` -> `http://localhost:5173` (or actual URL)
3. `browser_snapshot` — check elements are in place, no render errors
4. `browser_take_screenshot` — visually assess result
5. `browser_console_messages` — check for console errors
6. If problems found — FIX and repeat verification
7. Do NOT say "done" until verified in browser
8. In report: what was checked, screenshot, found and fixed problems
