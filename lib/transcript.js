import { readFile } from "node:fs/promises";

const MAX_READ_BYTES = 200_000; // Read at most 200KB from end of transcript

/**
 * Read recent entries from a transcript JSONL file.
 * Reads from the end of the file for efficiency on large transcripts.
 */
export async function readRecentEntries(transcriptPath, maxEntries = 30) {
  let raw;
  try {
    const buf = await readFile(transcriptPath);
    // Only parse the tail of large files
    const slice = buf.length > MAX_READ_BYTES
      ? buf.subarray(buf.length - MAX_READ_BYTES)
      : buf;
    raw = slice.toString("utf-8");
  } catch {
    return [];
  }

  const lines = raw.trimEnd().split("\n");
  const entries = [];

  for (let i = lines.length - 1; i >= 0 && entries.length < maxEntries; i--) {
    try {
      const entry = JSON.parse(lines[i]);
      if (entry.type === "assistant" || entry.type === "user") {
        entries.push(entry);
      }
    } catch {
      // skip malformed lines (including partial first line from slice)
    }
  }

  return entries;
}

/**
 * Extract recent context from the transcript for search queries.
 * Combines reasoning text (text + thinking blocks) with file paths
 * being worked on, to provide rich search context even when the
 * most recent entries are just tool calls.
 */
export function extractRecentContext(entries) {
  const texts = [];
  const files = [];
  let textCount = 0;

  for (const entry of entries) {
    if (entry.type !== "assistant" || !entry.message?.content) continue;

    for (const block of entry.message.content) {
      if (block.type === "text" && block.text) {
        texts.push(block.text);
        textCount++;
      } else if (block.type === "thinking" && block.thinking) {
        texts.push(block.thinking);
        textCount++;
      } else if (block.type === "tool_use") {
        // Collect file paths for context
        const filePath = block.input?.file_path;
        if (filePath && !files.includes(filePath)) {
          files.push(filePath);
        }
        // Also grab search queries (Grep patterns, Glob patterns)
        if (block.name === "Grep" && block.input?.pattern) {
          texts.push(block.input.pattern);
        }
      }
    }

    // Stop once we have enough text context
    if (textCount >= 5) break;
  }

  // Combine reasoning text + file basenames for search
  const fileContext = files.slice(0, 5).map((f) => f.split("/").pop()).join(" ");
  const reasoning = texts.join("\n").slice(0, 2000);

  return [reasoning, fileContext].filter(Boolean).join("\n");
}

/**
 * Extract recent reasoning text from assistant messages (text + thinking blocks).
 * @deprecated Use extractRecentContext instead for richer context.
 */
export function extractRecentReasoning(entries, maxAssistantTurns = 3) {
  const texts = [];
  let count = 0;

  for (const entry of entries) {
    if (entry.type !== "assistant" || !entry.message?.content) continue;
    if (count >= maxAssistantTurns) break;
    count++;

    for (const block of entry.message.content) {
      if (block.type === "text" && block.text) {
        texts.push(block.text);
      } else if (block.type === "thinking" && block.thinking) {
        texts.push(block.thinking);
      }
    }
  }

  return texts.join("\n").slice(0, 2000);
}

/**
 * Extract recent file paths from tool_use blocks (Read, Edit, Write).
 */
export function extractRecentFiles(entries, maxFiles = 10) {
  const files = [];

  for (const entry of entries) {
    if (entry.type !== "assistant" || !entry.message?.content) continue;

    for (const block of entry.message.content) {
      if (block.type !== "tool_use") continue;
      if (!["Read", "Edit", "Write"].includes(block.name)) continue;

      const filePath = block.input?.file_path;
      if (filePath && !files.includes(filePath)) {
        files.push(filePath);
        if (files.length >= maxFiles) return files;
      }
    }
  }

  return files;
}
