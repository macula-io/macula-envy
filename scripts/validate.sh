#!/usr/bin/env bash
set -e

# Quality validation script for macula_envy
# Run this before publishing to hex.pm

cd "$(dirname "$0")/.."

echo "============================================"
echo "  Validating macula_envy"
echo "============================================"
echo ""

# Version check
PACKAGE_VERSION=$(grep -oP '(?<={vsn, ")[^"]+' src/envy.app.src)
echo "Version: $PACKAGE_VERSION"
echo ""

# Clean build
echo "[1/5] Cleaning previous build..."
rm -rf _build rebar.lock
echo "OK"
echo ""

# Get dependencies
echo "[2/5] Fetching dependencies..."
rebar3 get-deps
echo "OK"
echo ""

# Compile with warnings as errors
echo "[3/5] Compiling (warnings_as_errors)..."
rebar3 compile
echo "OK"
echo ""

# Build documentation
echo "[4/5] Building documentation..."
rebar3 ex_doc
echo "OK"
echo ""

# Verify hex package builds
echo "[5/5] Building hex package..."
rebar3 hex build
echo "OK"
echo ""

echo "============================================"
echo "  All validations passed!"
echo "  Ready to publish macula_envy $PACKAGE_VERSION"
echo "============================================"
echo ""
echo "To publish, run: ./scripts/publish-to-hex.sh"
