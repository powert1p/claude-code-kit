#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Kit Installer ==="
echo ""

# Create directories
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/rules"

# Copy agents
echo "Installing agents..."
for f in "$SCRIPT_DIR/agents/"*.md; do
  name=$(basename "$f")
  if [ -f "$CLAUDE_DIR/agents/$name" ]; then
    echo "  SKIP $name (already exists)"
  else
    cp "$f" "$CLAUDE_DIR/agents/$name"
    echo "  OK   $name"
  fi
done

# Copy commands
echo "Installing commands..."
for f in "$SCRIPT_DIR/commands/"*.md; do
  name=$(basename "$f")
  if [ -f "$CLAUDE_DIR/commands/$name" ]; then
    echo "  SKIP $name (already exists)"
  else
    cp "$f" "$CLAUDE_DIR/commands/$name"
    echo "  OK   $name"
  fi
done

# Copy mandatory rules
echo "Installing rules..."
for f in "$SCRIPT_DIR/rules/"*.md; do
  name=$(basename "$f")
  if [ -f "$CLAUDE_DIR/rules/$name" ]; then
    echo "  SKIP $name (already exists)"
  else
    cp "$f" "$CLAUDE_DIR/rules/$name"
    echo "  OK   $name"
  fi
done

# Optional rules
echo ""
echo "Optional rules (stack-specific):"
for f in "$SCRIPT_DIR/rules-optional/"*.md; do
  name=$(basename "$f")
  read -p "  Install $name? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$f" "$CLAUDE_DIR/rules/$name"
    echo "  OK   $name"
  else
    echo "  SKIP $name"
  fi
done

# Templates
echo ""
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  read -p "Install CLAUDE.md template? (Y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    cp "$SCRIPT_DIR/templates/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo "  OK   CLAUDE.md (edit ~/.claude/CLAUDE.md to customize)"
  fi
else
  echo "  SKIP CLAUDE.md (already exists)"
fi

if [ ! -f "$CLAUDE_DIR/workflow.md" ]; then
  cp "$SCRIPT_DIR/templates/workflow.md" "$CLAUDE_DIR/workflow.md"
  echo "  OK   workflow.md"
else
  echo "  SKIP workflow.md (already exists)"
fi

echo ""
echo "=== Done! ==="
echo "Agents:   $(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Commands: $(ls "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Rules:    $(ls "$CLAUDE_DIR/rules/"*.md 2>/dev/null | wc -l | tr -d ' ')"
echo ""
echo "Next: edit ~/.claude/CLAUDE.md to customize for your project"
