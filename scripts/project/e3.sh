#!/usr/bin/env bash
#
# e3 Project Scaffolding (BSL-1.1)
# Usage: curl -sSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/project/e3.sh | bash
#    or: ./e3.sh [project-name]
#

set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; BLUE='\033[0;34m'; NC='\033[0m'

get_project_name() {
    if [ -n "$1" ]; then
        PROJECT_NAME="$1"
    else
        echo -e "${BLUE}Enter project name:${NC}"
        read -r PROJECT_NAME < /dev/tty
    fi
    [ -z "$PROJECT_NAME" ] && { echo -e "${RED}Project name required${NC}"; exit 1; }
    PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' _' '--')
    DISPLAY_NAME=$(echo "$PROJECT_NAME" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    WORKSPACE_NAME=$(echo "$PROJECT_NAME" | tr '-' '_')
}

create_project() {
    [ -d "$PROJECT_NAME" ] && { echo -e "${RED}Directory '$PROJECT_NAME' exists${NC}"; exit 1; }

    echo -e "${BLUE}Creating e3 project: $PROJECT_NAME (BSL-1.1)${NC}"
    mkdir -p "$PROJECT_NAME"/{src,tests}

    cat > "$PROJECT_NAME/package.json" << EOF
{
  "name": "@elaraai/$PROJECT_NAME",
  "version": "0.0.1",
  "description": "$DISPLAY_NAME",
  "type": "module",
  "scripts": {
    "build": "tsc",
    "main": "node --max-old-space-size=16000 ./dist/main.js",
    "test": "node --enable-source-maps --test 'dist/**/*.spec.js'",
    "lint": "eslint ."
  },
  "dependencies": {
    "@elaraai/east": "beta",
    "@elaraai/east-node-std": "beta",
    "@elaraai/east-node-io": "beta",
    "@elaraai/east-py-datascience": "beta",
    "@elaraai/e3": "beta",
    "@elaraai/e3-types": "beta"
  },
  "devDependencies": {
    "@types/node": "^22",
    "typescript": "^5",
    "eslint": "^9",
    "@typescript-eslint/eslint-plugin": "^8",
    "@typescript-eslint/parser": "^8"
  },
  "engines": { "node": ">=22" }
}
EOF

    cat > "$PROJECT_NAME/pyproject.toml" << EOF
[project]
name = "$PROJECT_NAME"
description = "$DISPLAY_NAME"
requires-python = ">=3.11"
version = "0.1.0"
dependencies = [
  "east-py-std @ git+https://github.com/elaraai/east-py@main#subdirectory=packages/east-py-std",
  "east-py-io @ git+https://github.com/elaraai/east-py@main#subdirectory=packages/east-py-io",
  "east-py-datascience @ git+https://github.com/elaraai/east-py@main#subdirectory=packages/east-py-datascience",
  "pytest",
]
EOF

    cat > "$PROJECT_NAME/tsconfig.json" << 'EOF'
{
  "exclude": ["dist"],
  "compilerOptions": {
    "outDir": "./dist",
    "module": "nodenext",
    "target": "esnext",
    "lib": ["esnext", "es2024"],
    "types": ["node"],
    "sourceMap": true,
    "declaration": true,
    "declarationMap": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "strict": true,
    "jsx": "react-jsx",
    "verbatimModuleSyntax": true,
    "isolatedModules": true,
    "noUncheckedSideEffectImports": true,
    "moduleDetection": "force",
    "skipLibCheck": true,
    "noErrorTruncation": true,
    "incremental": true
  }
}
EOF

    cat > "$PROJECT_NAME/.gitignore" << 'EOF'
node_modules/
dist/
*.tsbuildinfo
.venv/
__pycache__/
.e3/
EOF

    cat > "$PROJECT_NAME/src/index.ts" << 'EOF'
import e3 from "@elaraai/e3";
import { East, StringType } from "@elaraai/east";

export const nameInput = e3.input("name", StringType);

export const greetFn = East.function(
    [StringType],
    StringType,
    ($, name) => East.str`Hello, ${name}!`
);

export const greet = e3.task("greet", [nameInput], greetFn);
EOF

    cat > "$PROJECT_NAME/src/main.ts" << EOF
import e3 from "@elaraai/e3";
import { greet } from "./index.js";

const pkg = e3.package('$PROJECT_NAME', '1.0.0', greet);
void e3.export(pkg, '/tmp/pkg.zip');
export default pkg;
EOF

    cat > "$PROJECT_NAME/tests/test_unit.py" << 'EOF'
def test_placeholder():
    assert True
EOF

    cat > "$PROJECT_NAME/Makefile" << EOF
.PHONY: install build test lint clean refresh start

install:
	npm install
	uv sync

refresh:
	npm update @elaraai/east @elaraai/east-node-std @elaraai/east-node-io @elaraai/east-py-datascience @elaraai/e3 @elaraai/e3-types
	uv lock --upgrade-package east-py-std --upgrade-package east-py-io --upgrade-package east-py-datascience
	uv sync --reinstall-package east-py-std --reinstall-package east-py-io --reinstall-package east-py-datascience

build:
	npm run build

test: build
	npm test
	uv run pytest -v

lint:
	npm run lint

clean:
	rm -rf dist node_modules .venv uv.lock *.tsbuildinfo

start: build
	npm run main
	e3 workspace create . $WORKSPACE_NAME 2>/dev/null || true
	e3 workspace deploy . $WORKSPACE_NAME $PROJECT_NAME@1.0.0
	e3 start . $WORKSPACE_NAME
EOF

    echo "22" > "$PROJECT_NAME/.nvmrc"
    echo "3.11" > "$PROJECT_NAME/.python-version"

    cat > "$PROJECT_NAME/README.md" << EOF
# $DISPLAY_NAME

e3 project (BSL-1.1).

## Setup

\`\`\`bash
make install
\`\`\`

## Usage

\`\`\`bash
make build      # Build TypeScript
make test       # Run tests
make start      # Package and deploy to e3
make refresh    # Update packages
\`\`\`
EOF

    echo -e "${GREEN}Created $PROJECT_NAME${NC}"
    echo "  cd $PROJECT_NAME && make install"
}

get_project_name "$1"
create_project
