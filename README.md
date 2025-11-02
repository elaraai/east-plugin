# East Plugin for Claude Code

A Claude Code plugin that enables writing and validating [East](https://github.com/elaraai/East) code - a portable, type-safe functional language.

## What is East?

East is a statically typed, expression-based functional language that compiles to portable IR (Intermediate Representation). Write East code once, execute it anywhere (JavaScript, Julia, Python, etc.).

## What This Plugin Provides

### Agent Skill
The `east-development` skill teaches Claude how to write East code:
- Complete East type system documentation
- All operations and expressions
- Standard library reference
- Validation workflow with automatic error correction

### MCP Server Integration
Automatically configures the `east_compile` tool for validating East code:
- Compiles TypeScript to East IR
- Validates syntax and types
- Returns clear error messages
- Generates portable IR

## Installation

### Using Claude Code

```bash
/plugin install elaraai/east-plugin
```

Or from a local directory:

```bash
/plugin install /path/to/east-plugin
```

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/elaraai/east-plugin.git
   cd east-plugin
   ```

2. Install in Claude Code:
   ```bash
   /plugin install .
   ```

## Usage

Once installed, Claude automatically recognizes when you want to work with East:

**Example prompts:**
- "Write an East function that adds two integers"
- "Create an East function to filter an array"
- "Help me write East code for a struct type"
- "Validate this East function for me"

Claude will:
1. Use the `east-development` skill to understand East syntax
2. Write East code following best practices
3. Validate the code using the `east_compile` tool
4. Fix any compilation errors automatically
5. Return working, validated East code

## What You Get

### Documentation

- **[USAGE.md](skills/east-development/USAGE.md)** - Complete East developer guide
  - All types and operations
  - Functions and expressions
  - JSON serialization
  - Platform functions

- **[STDLIB.md](skills/east-development/STDLIB.md)** - Standard library reference
  - Formatting utilities
  - Conversion functions
  - Type-specific operations

### Tools

- **east_compile** - Validates East code and generates IR
  - Automatic error detection
  - Type checking
  - IR generation

## Example

**You:** "Write an East function that doubles an integer"

**Claude (using this plugin):**

```typescript
return East.function([East.IntegerType], East.IntegerType, ($, x) => {
  return $.return(x.multiply(2n));
});
```

*Claude validates this with `east_compile` automatically*

## Requirements

- Claude Code (latest version)
- Node.js ≥ 22.0.0 (for MCP server)
- npm or npx (for installing @elaraai/east-mcp)

The MCP server (`@elaraai/east-mcp`) is automatically installed when you activate this plugin.

## Architecture

This plugin consists of:

1. **Skill** (`skills/east-development/`) - Teaches Claude about East
2. **MCP Configuration** (`.mcp.json`) - Connects to the East compilation tool
3. **Documentation** - Complete East reference materials

The MCP server is a separate package ([`@elaraai/east-mcp`](https://www.npmjs.com/package/@elaraai/east-mcp)) that provides the `east_compile` tool.

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

Before contributing, you must sign our [Contributor License Agreement (CLA)](CLA.md).

## License

This project is dual-licensed under AGPL-3.0 and commercial licenses. See [LICENSE.md](LICENSE.md) for details.

**Open Source (AGPL-3.0):** Free to use with source code disclosure requirements
**Commercial License:** Available for proprietary use - contact support@elara.ai

## Links

- **East Language**: https://github.com/elaraai/East
- **East MCP Server**: https://github.com/elaraai/east-mcp
- **East Plugin**: https://github.com/elaraai/east-plugin
- **Documentation**: See [USAGE.md](skills/east-development/USAGE.md)
- **Support**: support@elara.ai

## Development

To modify or extend this plugin:

1. Clone the repository
2. Edit files in `skills/east-development/`
3. Test locally: `/plugin install /path/to/east-plugin`
4. Submit a pull request

### Updating Documentation

When the East language is updated:

```bash
# Copy latest docs from East repository
cp ../East/USAGE.md skills/east-development/
cp ../East/STDLIB.md skills/east-development/

# Review and update SKILL.md if needed
```

## Changelog

### 1.0.0
- Initial release
- Complete East type system documentation
- MCP server integration with east_compile tool
- Automatic validation workflow
