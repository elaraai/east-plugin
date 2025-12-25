---
description: Get a dataset value from e3 workspace
argument-hint: <repo> <path> [-f east|json|beast2]
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3-get.sh)"]
---

# e3 Get

Get a dataset value from an e3 workspace.

Path format: `workspace.path.to.dataset` (e.g., `dev.inputs.name`, `dev.tasks.greet.output`)

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3-get.sh" $ARGUMENTS
```
