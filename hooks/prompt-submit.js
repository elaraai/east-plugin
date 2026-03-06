import { readFile } from "node:fs/promises";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { buildSearchIndex, formatResults, MIN_SCORE } from "../lib/search.js";

const __dirname = dirname(fileURLToPath(import.meta.url));
// Two levels up from dist/hooks/ to project root
const INDEX_PATH = join(__dirname, "..", "..", "index.json");

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
 * Detect which East skill names the project uses.
 */
function detectProjectSkills(pkg) {
  if (!pkg) return null;
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
  return skills.length > 0 ? skills : null;
}

async function main() {
  let input = "";
  for await (const chunk of process.stdin) {
    input += chunk;
  }

  const event = JSON.parse(input);
  const prompt = event.prompt;
  if (!prompt) process.exit(0);

  // Load the index
  let miniSearch;
  try {
    miniSearch = await buildSearchIndex(INDEX_PATH);
  } catch {
    // Index not built yet — exit silently
    process.exit(0);
  }

  // Detect project skills for optional filtering
  const cwd = event.cwd || process.cwd();
  const pkg = await findPackageJson(cwd);
  const projectSkills = detectProjectSkills(pkg);

  // Search the index
  let results = miniSearch.search(prompt, { limit: 10 });

  // Filter out low-relevance noise
  results = results.filter((r) => r.score >= MIN_SCORE);

  // Filter by project skills if detected
  if (projectSkills && results.length > 0) {
    const filtered = results.filter((r) => projectSkills.includes(r.skill));
    // Only use filtered results if we still have matches
    if (filtered.length > 0) {
      results = filtered;
    }
  }

  // Take top 5
  results = results.slice(0, 5);

  if (results.length === 0) process.exit(0);

  const context = formatResults(results);

  const output = {
    hookSpecificOutput: {
      hookEventName: "UserPromptSubmit",
      additionalContext: context,
    },
  };

  process.stdout.write(JSON.stringify(output));
}

main().catch(() => process.exit(0));
