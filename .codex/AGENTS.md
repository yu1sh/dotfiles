# Global Rules

- Keep changes scoped; avoid unrelated refactors and preserve existing user work.
- Prefer existing patterns and dependencies; justify new production dependencies.
- Be context-efficient: avoid redundant reads, searches, and output, but never sacrifice correctness or necessary validation.
- Run relevant validation after changes and report what was actually verified.
- Do not weaken tests just to make them pass.
- Make reasonable low-risk assumptions; ask only about consequential ambiguity.
- Do not commit, push, publish, or release unless explicitly requested..
