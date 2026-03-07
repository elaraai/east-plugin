import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { buildSearchIndex, formatResults, MIN_SCORE } from "./search.js";

const __dirname = dirname(fileURLToPath(import.meta.url));
// When bundled by esbuild into dist/hooks/, __dirname is dist/hooks/
// so we need ../../index.json to reach the project root.
// When run unbundled from lib/, __dirname is lib/ so ../index.json works.
// Use ../../ since the bundled path is the one that matters at runtime.
const INDEX_PATH = join(__dirname, "..", "..", "index.json");

let indexPromise = null;

/**
 * Lazily load the search index. Only call this after fast checks
 * confirm we actually need to search (East project, East file, etc).
 */
function getIndex() {
  if (!indexPromise) {
    indexPromise = buildSearchIndex(INDEX_PATH);
  }
  return indexPromise;
}

/**
 * Search the index and return formatted results.
 * Returns null if no relevant results found.
 * @param {string} query - Search text
 * @param {string[]|null} filterSkills - Only return results matching these skills
 * @param {number} limit - Max results
 */
export async function searchAndFormat(query, filterSkills = null, limit = 5) {
  let miniSearch;
  try {
    miniSearch = await getIndex();
  } catch {
    return null;
  }

  let results = miniSearch.search(query, { limit: limit * 2 });

  results = results.filter((r) => r.score >= MIN_SCORE);

  if (filterSkills && results.length > 0) {
    const filtered = results.filter((r) => filterSkills.includes(r.skill));
    if (filtered.length > 0) {
      results = filtered;
    }
  }

  results = results.slice(0, limit);

  if (results.length === 0) return null;

  return formatResults(results);
}

export { MIN_SCORE, formatResults };
