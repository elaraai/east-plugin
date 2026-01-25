---
description: View e3 task logs
argument-hint: <repo> <path> [--follow]
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3/logs.sh)"]
---

# e3 Logs

View logs from e3 tasks.

Path format: `workspace` or `workspace.taskName` (e.g., `dev`, `dev.process`)

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3/logs.sh" $ARGUMENTS
```
