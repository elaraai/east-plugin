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

## Examples

TypeScript example files in `examples/` mirror each skill's decision tree. Browse by package:

### `examples/east/` — Core Language

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `expressions/` | `basics.ts` | `East.value()`, `East.str`, `$.let()`, `$.const()` |
| `types/` | `primitives.ts`, `collections.ts`, `compound.ts` | All East types: Integer, Float, String, Boolean, DateTime, Blob, Null, Array, Set, Dict, Ref, Struct, Variant, Recursive |
| `functions/` | `sync.ts`, `async.ts`, `platform.ts`, `closures.ts` | `East.function()`, `East.asyncFunction()`, `East.platform()`, higher-order functions |
| `blocks/` | `variables.ts`, `control-flow.ts`, `match.ts`, `error-handling.ts` | `$.let`, `$.if`, `$.while`, `$.for`, `$.match`, `$.try` |
| `boolean/` | `logic.ts`, `bitwise.ts` | `.not()`, `.and()`, `.or()`, `.ifElse()`, `.bitAnd()`, `.bitOr()`, `.bitXor()` |
| `integer/` | `math.ts`, `formatting.ts` | Arithmetic, `printCommaSeperated`, `printCompact`, `printOrdinal`, `printCurrency` |
| `float/` | `math.ts`, `formatting.ts` | Arithmetic, trig, `printFixed`, `printCurrency`, `roundToDecimals`, `approxEqual` |
| `string/` | `transform.ts`, `query.ts`, `encoding.ts` | Concat, split, replace, indexOf, `encodeUtf8`, `parseJson`, `printJson` |
| `datetime/` | `construction.ts`, `components.ts`, `arithmetic.ts`, `rounding.ts` | `fromComponents`, `getYear`, `addDays`, `durationDays`, `roundDownDay`, `parseFormatted` |
| `blob/` | `encoding.ts`, `beast.ts`, `csv.ts` | UTF-8/16 encode/decode, Beast serialization, CSV encode/decode |
| `array/` | `read.ts`, `mutate.ts`, `transform.ts`, `search.ts`, `reduce.ts`, `convert.ts`, `group.ts` | All array operations: get, push, map, filter, reduce, groupReduce |
| `set/` | `read.ts`, `mutate.ts`, `set-ops.ts`, `transform.ts`, `convert.ts`, `group.ts` | Set operations: union, intersection, difference, filter, reduce |
| `dict/` | `read.ts`, `mutate.ts`, `transform.ts`, `convert.ts`, `group.ts` | Dict operations: get, insert, merge, map, filter, reduce |
| `struct/` | `fields.ts` | Direct field access, nested structs |
| `variant/` | `matching.ts` | `.match()`, `$.match()`, `.unwrap()`, `.hasTag()`, `.getTag()` |
| `ref/` | `mutable.ts` | `.get()`, `.update()`, `.merge()` |
| `comparisons/` | `equality.ts`, `ordering.ts` | `East.equal`, `East.less`, `East.min`, `East.max`, `East.clamp` |
| `patches/` | `diff-apply.ts` | `East.diff`, `East.applyPatch`, `East.invertPatch`, `East.composePatch` |
| `serialization/` | `ir.ts`, `beast.ts` | `.toIR()`, `EastIR.fromJSON()`, Beast encode/decode |

### `examples/east-node-std/` — Node.js Platform

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `console/` | `output.ts` | `Console.log`, `Console.error`, `Console.write` |
| `filesystem/` | `text.ts`, `binary.ts`, `query.ts`, `directory.ts` | Read/write files, exists, isFile, createDirectory, readDirectory |
| `fetch/` | `requests.ts` | `Fetch.get`, `Fetch.getBytes`, `Fetch.post`, `Fetch.request` |
| `crypto/` | `hashing.ts` | `Crypto.uuid`, `Crypto.randomBytes`, `Crypto.hashSha256` |
| `time/` | `timestamps.ts` | `Time.now`, `Time.sleep` |
| `path/` | `manipulation.ts` | `Path.join`, `Path.resolve`, `Path.dirname`, `Path.basename`, `Path.extname` |
| `random/` | `basic.ts`, `continuous.ts`, `discrete.ts`, `composite.ts` | `Random.uniform`, `Random.normal`, `Random.exponential`, `Random.bernoulli`, `Random.seed` |
| `testing/` | `describe.ts`, `assertions.ts` | `describeEast`, test hooks, `Assert.equal`, `Assert.throws` |

### `examples/east-node-io/` — I/O Platform

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `sql/` | `sqlite.ts`, `postgres.ts`, `mysql.ts` | Connect, query, close for each SQL database |
| `nosql/` | `redis.ts`, `mongodb.ts` | Redis get/set/del, MongoDB CRUD operations |
| `storage/` | `s3.ts` | `Storage.S3` put/get/delete/list/presign |
| `transfer/` | `ftp.ts`, `sftp.ts` | FTP and SFTP connect, put, get, list, delete |
| `format/` | `xlsx.ts`, `xml.ts` | XLSX read/write, XML parse/serialize |
| `compression/` | `gzip.ts`, `zip.ts`, `tar.ts` | Gzip/Zip/Tar compress and decompress |

### `examples/east-ui/` — UI Components

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `layout/` | `box.ts`, `stack.ts`, `grid.ts`, `splitter.ts`, `separator.ts` | Box, HStack/VStack, Grid, resizable panels, dividers |
| `typography/` | `text.ts`, `heading.ts`, `code.ts`, `link.ts`, `list.ts` | Text, Heading sizes, CodeBlock, Link, Ordered/Unordered lists |
| `buttons/` | `button.ts`, `icon-button.ts` | Button variants (solid/outline/subtle/ghost), IconButton |
| `forms/` | `input.ts`, `select.ts`, `checkbox.ts`, `switch.ts`, `slider.ts`, `textarea.ts`, `tags-input.ts`, `file-upload.ts`, `field.ts` | String/Integer/Float/DateTime inputs, Select, Checkbox, Switch, Slider, Field wrapper |
| `collections/` | `table.ts`, `data-list.ts`, `tree-view.ts`, `gantt.ts` | Table with columns, DataList key-value, TreeView, Gantt timeline |
| `charts/` | `bar.ts`, `line.ts`, `area.ts`, `scatter.ts`, `pie.ts`, `radar.ts`, `composed.ts`, `bar-list.ts`, `bar-segment.ts`, `sparkline.ts` | All chart types with series config |
| `display/` | `badge.ts`, `tag.ts`, `avatar.ts`, `stat.ts`, `icon.ts` | Badge, Tag, Avatar, Stat with change indicators, Icon |
| `feedback/` | `alert.ts`, `progress.ts` | Alert statuses, Progress bar |
| `disclosure/` | `accordion.ts`, `tabs.ts`, `carousel.ts` | Accordion, Tabs variants, Carousel |
| `overlays/` | `dialog.ts`, `drawer.ts`, `popover.ts`, `tooltip.ts`, `menu.ts`, `hover-card.ts` | Dialog, Drawer placements, Popover, Tooltip, Menu items |
| `container/` | `card.ts` | Card with header/body/footer |
| `state/` | `read-write.ts`, `counter.ts` | `State.initTyped`, `State.readTyped`, `State.writeTyped` patterns |

### `examples/east-py-datascience/` — Data Science & ML

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `mads/` | `unconstrained.ts`, `constrained.ts` | MADS derivative-free optimization |
| `optuna/` | `float-params.ts`, `categorical-params.ts` | Bayesian optimization with Optuna |
| `simanneal/` | `permutation.ts`, `subset.ts` | Simulated annealing for combinatorial problems |
| `alns/` | `optimize.ts` | Adaptive Large Neighborhood Search |
| `scipy/` | `minimize.ts`, `dual-annealing.ts`, `curve-fit.ts` | Scipy optimization and curve fitting |
| `sklearn/` | `splitting.ts`, `scaling.ts`, `metrics.ts`, `encoding.ts` | Train/test split, scalers, metrics, label encoding |
| `xgboost/` | `regressor.ts`, `classifier.ts`, `quantile.ts` | XGBoost regression, classification, quantile prediction |
| `lightgbm/` | `regressor.ts`, `classifier.ts` | LightGBM gradient boosting |
| `ngboost/` | `regressor.ts` | NGBoost probabilistic predictions |
| `torch/` | `train-predict.ts`, `encode-decode.ts` | MLP train/predict, encode/decode embeddings |
| `lightning/` | `mlp.ts`, `autoencoder.ts`, `conv1d.ts`, `sequential.ts`, `transformer.ts` | Lightning architectures: MLP, autoencoder, Conv1D, LSTM/GRU, transformer |
| `gp/` | `regression.ts` | Gaussian Process regression |
| `mapie/` | `regressor.ts`, `classifier.ts`, `cqr.ts` | Conformal prediction intervals and sets |
| `shap/` | `tree-explainer.ts`, `kernel-explainer.ts` | SHAP feature importance and explanations |

### `examples/e3/` — Execution Engine

| Category | Files | Demonstrates |
|----------|-------|-------------|
| `sdk/` | `input-task.ts`, `pipeline.ts`, `custom-task.ts` | `e3.input()`, `e3.task()`, `e3.package()`, `e3.export()`, `e3.customTask()` |

## Compile

Type-check East TypeScript with `scripts/east/compile.sh`:

```bash
# Project mode (from a directory with package.json + tsconfig.json)
./scripts/east/compile.sh

# Single file mode
./scripts/east/compile.sh path/to/file.ts
```

Uses Docker (`ghcr.io/elaraai/east-node`) when available, falls back to local `npx tsc`.

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

## Project Scaffolding

Create new East projects with a single command:

**East project** (AGPL-3.0, Node.js only):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/project/east.sh | bash
```

**e3 project** (BSL-1.1, Node.js + Python):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/project/e3.sh | bash
```

| Script | License | Contents |
|--------|---------|----------|
| `scripts/project/east.sh` | AGPL-3.0 | east, east-node-std, east-node-io |
| `scripts/project/e3.sh` | BSL-1.1 | Everything in east + e3, east-py-datascience |

Generated projects include:
- TypeScript configuration with strict mode
- Makefile with `install`, `build`, `run`, `test`, `refresh` targets
- Example East function ready to build and run

## Local Installation

Install the East CLIs directly on your machine (Linux/macOS):

**For users** (installs CLIs from npm/PyPI):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/global/install.sh | bash
```

**For contributors** (clones all repos and builds from source):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/global/install-dev.sh | bash
```

| Script | What it does | Requirements |
|--------|--------------|--------------|
| `scripts/global/install.sh` | Installs CLIs globally from npm/PyPI | `curl`, `git` |
| `scripts/global/install-dev.sh` | Clones all repos to `~/east`, builds and tests them | `curl`, `git`, `make` |
| `scripts/global/update.sh` | Updates CLIs to latest versions | `npm` |
| `scripts/global/update-dev.sh` | Pulls latest and rebuilds all repos | `git`, `make` |

**Update CLIs** (fetches latest versions from npm/PyPI):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/global/update.sh | bash
```

**Update repos** (pulls latest commits and rebuilds from source):
```bash
curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/global/update-dev.sh | bash
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

## Testing

Run all tests:
```bash
./tests/test-all.sh          # All tests including Docker builds
./tests/test-all.sh --quick  # Skip Docker builds
```

Individual test scripts:
| Script | What it tests |
|--------|---------------|
| `tests/test-scripts-syntax.sh` | Bash syntax validation for all scripts |
| `tests/test-project-east.sh` | East project scaffolding, install, build, run |
| `tests/test-project-e3.sh` | e3 project scaffolding, install, build, e3 export |
| `tests/test-docker-builds.sh` | Docker image builds |

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
