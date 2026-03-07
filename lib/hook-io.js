/**
 * Read and parse JSON hook input from stdin.
 */
export async function readHookInput() {
  let input = "";
  for await (const chunk of process.stdin) {
    input += chunk;
  }
  return JSON.parse(input);
}

/**
 * Write hook output with additionalContext.
 */
export function writeHookOutput(hookEventName, additionalContext) {
  const output = {
    hookSpecificOutput: {
      hookEventName,
      additionalContext,
    },
  };
  process.stdout.write(JSON.stringify(output));
}
