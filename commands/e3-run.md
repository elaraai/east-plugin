---
description: Run an e3 task ad-hoc
argument-hint: <repo> <pkg/task> [inputs...] -o <output>
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3-run.sh)"]
---

# e3 Run

Run an e3 task ad-hoc (outside workspace context).

Task format: `pkg/task` or `pkg@version/task`

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3-run.sh" $ARGUMENTS
```
