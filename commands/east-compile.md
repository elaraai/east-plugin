---
description: Compile and type-check an East function
argument-hint: [file-or-expression]
allowed-tools: [Read, Bash]
---

# East Compile

Compile and type-check an East function or file.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

1. If a file path is provided in $ARGUMENTS, use that file
2. If no arguments provided, look for TypeScript files with East code in the current directory

3. Run the compile script:
   ```bash
   bash ${CLAUDE_PLUGIN_ROOT}/scripts/east-compile.sh <file>
   ```

4. If the script is not available or fails, fall back to:
   - If Docker is available: `docker run --rm -v $(pwd):/workspace ghcr.io/elaraai/east-node npx tsc --noEmit <file>`
   - If npx is available: `npx tsc --noEmit <file>`

5. Analyze any errors and provide:
   - Line numbers and error messages
   - Suggestions for fixing type errors
   - Missing import suggestions

6. If the code is valid, confirm it compiles successfully

## Example Usage

```
/east-compile src/pipeline.ts
/east-compile
```
