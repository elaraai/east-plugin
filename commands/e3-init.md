---
description: Initialize a new e3 repository
argument-hint: [repo-path]
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3-init.sh)"]
---

# e3 Init

Initialize a new e3 repository.

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3-init.sh" $ARGUMENTS
```

If no path was provided, the repository was initialized in the current directory.
