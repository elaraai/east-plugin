import { readFile } from "node:fs/promises";
import MiniSearch from "minisearch";

export const MIN_SCORE = 50;

/**
 * Load and build the MiniSearch index from an index.json file.
 */
export async function buildSearchIndex(indexPath) {
  const raw = await readFile(indexPath, "utf-8");
  const data = JSON.parse(raw);

  const miniSearch = new MiniSearch({
    fields: ["keywordsText", "test", "suite", "source"],
    storeFields: ["skill", "package", "suite", "test", "keywords", "imports", "source"],
    searchOptions: {
      boost: { keywordsText: 3, test: 2, suite: 1.5, source: 1 },
      fuzzy: 0.2,
      prefix: true,
    },
  });

  // Prepare entries: join keywords array into searchable text
  const documents = data.entries.map((entry) => ({
    ...entry,
    keywordsText: entry.keywords.join(" "),
  }));

  miniSearch.addAll(documents);
  return miniSearch;
}

/**
 * Format search results into an annotated context block.
 */
export function formatResults(results) {
  const sections = results.map((r) => {
    const keywordsStr = r.keywords.join(", ");
    const imports = r.imports.join("\n");
    return [
      `### ${r.test}`,
      `Suite: ${r.suite} | Package: ${r.package} | Keywords: ${keywordsStr}`,
      "",
      "```typescript",
      imports,
      "",
      r.source,
      "```",
    ].join("\n");
  });

  return ["<east-examples>", "## Relevant East Examples", "", ...sections, "</east-examples>"].join(
    "\n"
  );
}
