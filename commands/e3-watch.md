---
description: Watch for changes and auto-deploy
argument-hint: <repo> <workspace> <source.ts> [--start] [--abort-on-change]
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/e3/watch.sh)"]
---

# e3 Watch

Watch a TypeScript file and automatically deploy and run on changes.

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/e3/watch.sh" $ARGUMENTS
```

This runs in the foreground watching for file changes.
