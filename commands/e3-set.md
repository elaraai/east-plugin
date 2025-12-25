---
description: Set a dataset value in e3 workspace
argument-hint: <repo> <path> <file> [--type <spec>]
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3-set.sh)"]
---

# e3 Set

Set a dataset value in an e3 workspace from a file.

Path format: `workspace.path.to.dataset` (e.g., `dev.inputs.name`)

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3-set.sh" $ARGUMENTS
```
