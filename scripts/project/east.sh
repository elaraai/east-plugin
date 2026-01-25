#!/usr/bin/env bash
#
# East Project Scaffolding (AGPL-3.0)
# Usage: curl -sSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/project/east.sh | bash
#    or: ./east.sh [project-name]
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
}

create_project() {
    [ -d "$PROJECT_NAME" ] && { echo -e "${RED}Directory '$PROJECT_NAME' exists${NC}"; exit 1; }

    echo -e "${BLUE}Creating East project: $PROJECT_NAME (AGPL-3.0)${NC}"
    mkdir -p "$PROJECT_NAME"/src

    cat > "$PROJECT_NAME/package.json" << EOF
{
  "name": "@elaraai/$PROJECT_NAME",
  "version": "0.0.1",
  "description": "$DISPLAY_NAME",
  "type": "module",
  "scripts": {
    "build": "tsc",
    "test": "node --enable-source-maps --test 'dist/**/*.spec.js'",
    "lint": "eslint ."
  },
  "dependencies": {
    "@elaraai/east": "beta",
    "@elaraai/east-node-std": "beta",
    "@elaraai/east-node-io": "beta"
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
EOF

    cat > "$PROJECT_NAME/src/index.ts" << 'EOF'
import { East, StringType } from "@elaraai/east";

export const greet = East.function(
    [StringType],
    StringType,
    ($, name) => East.str`Hello, ${name}!`
);
EOF

    cat > "$PROJECT_NAME/Makefile" << 'EOF'
.PHONY: install build run test lint clean refresh

install:
	npm install

refresh:
	npm update @elaraai/east @elaraai/east-node-std @elaraai/east-node-io

build:
	npm run build

run: build
	node --enable-source-maps dist/index.js

test: build
	npm test

lint:
	npm run lint

clean:
	rm -rf dist node_modules *.tsbuildinfo
EOF

    echo "22" > "$PROJECT_NAME/.nvmrc"

    cat > "$PROJECT_NAME/README.md" << EOF
# $DISPLAY_NAME

East project (AGPL-3.0).

## Setup

\`\`\`bash
npm install
npm run build
\`\`\`
EOF

    echo -e "${GREEN}Created $PROJECT_NAME${NC}"
    echo "  cd $PROJECT_NAME && npm install"
}

get_project_name "$1"
create_project
