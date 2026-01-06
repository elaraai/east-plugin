# East Plugin for Claude Code

A Claude Code plugin for the East programming language ecosystem.

## Skills

| Skill | Package | Description |
|-------|---------|-------------|
| `east` | `@elaraai/east` | Core East language - types, expressions, compilation |
| `east-node-std` | `@elaraai/east-node-std` | Node.js platform functions (Console, FileSystem, Fetch, Crypto, Random, Time) |
| `east-node-io` | `@elaraai/east-node-io` | I/O platform functions (SQL, NoSQL, S3, FTP, XLSX, compression) |
| `east-py-datascience` | `@elaraai/east-py-datascience` | Data science & ML (MADS, Optuna, XGBoost, Torch, GP, SHAP) |
| `east-ui` | `@elaraai/east-ui` | UI components (50+ typed components for layouts, forms, charts) |
| `e3` | `@elaraai/e3` | East Execution Engine - durable execution for East pipelines |

## Commands

| Command | Description |
|---------|-------------|
| `/compile` | Compile and type-check an East function |
| `/e3-init` | Initialize a new e3 repository |
| `/e3-run` | Run an e3 task |
| `/e3-start` | Start an e3 workspace |
| `/e3-watch` | Watch for changes and re-run tasks |
| `/e3-logs` | View e3 task logs |
| `/e3-status` | Show e3 repository status |
| `/e3-get` | Get a value from e3 repository |
| `/e3-set` | Set a value in e3 repository |

## Installation

**From GitHub:**
```bash
# Add the marketplace
/plugin marketplace add elaraai/east-plugin

# Install the plugin
/plugin install east
```

**From local directory (for development):**
```bash
# Add local marketplace
/plugin marketplace add /path/to/east-plugin

# Install the plugin
/plugin install east
```

## Local Installation

Install the East CLIs directly on your machine (Linux/macOS):

**For users** (installs CLIs from npm/PyPI):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/install.sh | bash
```

**For contributors** (clones all repos and builds from source):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/install-dev.sh | bash
```

| Script | What it does | Requirements |
|--------|--------------|--------------|
| `install.sh` | Installs CLIs globally from npm/PyPI | `curl`, `git` |
| `install-dev.sh` | Clones all repos to `~/east`, builds and tests them | `curl`, `git`, `make` |
| `update.sh` | Updates CLIs to latest versions | `npm` |
| `update-dev.sh` | Pulls latest and rebuilds all repos | `git`, `make` |

**Update CLIs** (fetches latest versions from npm/PyPI):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/update.sh | bash
```

**Update repos** (pulls latest commits and rebuilds from source):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/update-dev.sh | bash
```

Both install scripts install:
- `east-node` - East Node.js CLI
- `e3` - East Execution Engine CLI
- `east-py` - East Python CLI

## Docker Images

Pre-built Docker images provide a consistent execution environment without needing to install Node.js, Python, or any East packages locally.

### Images

| Image | License | Contents |
|-------|---------|----------|
| `ghcr.io/elaraai/east-node` | AGPL-3.0 | Node.js 22 + East + east-node-std/io + east-ui |
| `ghcr.io/elaraai/e3` | BSL + AGPL | Everything in east-node + Python 3.11 + east-py + e3 |

### Usage

```bash
# Pull images
docker pull ghcr.io/elaraai/east-node
docker pull ghcr.io/elaraai/e3

# Run East Node.js programs
docker run --rm -v $(pwd):/workspace ghcr.io/elaraai/east-node \
  npx @elaraai/east-node-cli run program.east

# Run e3 pipelines
docker run --rm -v $(pwd):/workspace -v ~/.e3:/root/.e3 ghcr.io/elaraai/e3 \
  e3 run my-pipeline

# Interactive shell
docker run -it --rm -v $(pwd):/workspace ghcr.io/elaraai/e3 bash
```

### Building Locally

```bash
# Build east-node image (from repo root)
docker build -f docker/Dockerfile.east-node -t ghcr.io/elaraai/east-node .

# Build e3 image (from repo root)
docker build -f docker/Dockerfile.e3 -t ghcr.io/elaraai/e3 .
```

### Firecracker Compatibility

These Docker images are compatible with Firecracker microVMs via:
- [Kata Containers](https://katacontainers.io/) - Run OCI images in Firecracker
- [Ignite](https://github.com/weaveworks/ignite) - `ignite run ghcr.io/elaraai/e3`
- AWS Lambda (uses Firecracker under the hood)

## Links

- [East Language](https://github.com/elaraai/east)
- [East Node](https://github.com/elaraai/east-node)
- [East Python](https://github.com/elaraai/east-py)
- [East UI](https://github.com/elaraai/east-ui)
- [e3 Execution Engine](https://github.com/elaraai/e3)
- [Elara AI](https://elaraai.com/)

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

Before contributing, you must sign our [Contributor License Agreement (CLA)](CLA.md).

## License

This project is dual-licensed under AGPL-3.0 and commercial licenses. See [LICENSE.md](LICENSE.md) for details.

**Note:** The `ghcr.io/elaraai/e3` image contains BSL 1.1 licensed components. Production use requires a commercial license. Contact support@elara.ai.

---

*Developed by [Elara AI Pty Ltd](https://elaraai.com/)*
