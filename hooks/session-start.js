import { readFile } from "node:fs/promises";
import { join, dirname } from "node:path";

// Package name to skill name mapping
const PACKAGE_SKILL_MAP = {
  "@elaraai/east": "east",
  "@elaraai/east-node-std": "east-node-std",
  "@elaraai/east-node-io": "east-node-io",
  "@elaraai/east-py-datascience": "east-py-datascience",
  "@elaraai/east-ui": "east-ui",
  "@elaraai/e3": "e3",
};

/**
 * Find package.json by walking up from cwd.
 * Returns parsed JSON or null if not found.
 */
async function findPackageJson(startDir) {
  let dir = startDir;
  while (true) {
    try {
      const content = await readFile(join(dir, "package.json"), "utf-8");
      return JSON.parse(content);
    } catch {
      const parent = dirname(dir);
      if (parent === dir) return null;
      dir = parent;
    }
  }
}

/**
 * Detect East packages in dependencies and return matching skill names.
 */
function detectEastSkills(pkg) {
  const allDeps = {
    ...pkg.dependencies,
    ...pkg.devDependencies,
  };
  const skills = [];
  for (const [packageName, skillName] of Object.entries(PACKAGE_SKILL_MAP)) {
    if (packageName in allDeps) {
      skills.push(skillName);
    }
  }
  return skills;
}

async function main() {
  let input = "";
  for await (const chunk of process.stdin) {
    input += chunk;
  }

  const event = JSON.parse(input);
  const cwd = event.cwd || process.cwd();

  const pkg = await findPackageJson(cwd);
  if (!pkg) process.exit(0);

  const skills = detectEastSkills(pkg);
  if (skills.length === 0) process.exit(0);

  const skillList = skills.map((s) => `- ${s}`).join("\n");
  const context = [
    "This is an East project. The following East skills are available and should be used when working with East code:",
    "",
    skillList,
    "",
    "Use /east (or the relevant skill) when writing East programs. The skills provide type-safe API patterns and examples.",
  ].join("\n");

  const output = {
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      additionalContext: context,
    },
  };

  process.stdout.write(JSON.stringify(output));
}

main().catch(() => process.exit(0));
