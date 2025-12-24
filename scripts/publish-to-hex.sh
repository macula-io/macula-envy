#!/usr/bin/env bash
set -e

# Hex.pm publish script for macula_envy
# Fork of shortishly/envy with rebar3 support

cd "$(dirname "$0")/.."

# Source secrets if available
[ -f "$HOME/.config/zshrc/01-secrets" ] && source "$HOME/.config/zshrc/01-secrets"

echo "============================================"
echo "  Publishing macula_envy to hex.pm"
echo "============================================"
echo ""

# Version check
PACKAGE_VERSION=$(grep -oP '(?<={vsn, ")[^"]+' src/envy.app.src)
echo "Version: $PACKAGE_VERSION"
echo ""

# Clean build
echo "Cleaning previous build..."
rm -rf _build rebar.lock
echo ""

# Get dependencies
echo "Fetching dependencies..."
rebar3 get-deps
echo ""

# Compile
echo "Compiling..."
rebar3 compile
echo ""

# Build docs (validates documentation)
echo "Building documentation..."
rebar3 ex_doc || echo "Documentation build had warnings"
echo ""

# Build hex package
echo "Building hex package..."
rebar3 hex build
echo ""

# Show package contents
echo "Package contents:"
rebar3 hex build --unpack | head -20 || true
echo ""

# Publish
echo "Publishing to hex.pm..."
rebar3 hex publish --yes
echo ""

echo "============================================"
echo "  Done! Published macula_envy $PACKAGE_VERSION"
echo "============================================"
