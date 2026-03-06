#!/bin/bash
echo "=== Claude Code Kit Uninstaller ==="
echo "This will remove agents, commands, and rules installed by the kit."
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dir in agents commands rules; do
  for f in "$SCRIPT_DIR/$dir/"*.md; do
    name=$(basename "$f")
    if [ -f "$CLAUDE_DIR/$dir/$name" ]; then
      rm "$CLAUDE_DIR/$dir/$name"
      echo "Removed $dir/$name"
    fi
  done
done

for f in "$SCRIPT_DIR/rules-optional/"*.md; do
  name=$(basename "$f")
  if [ -f "$CLAUDE_DIR/rules/$name" ]; then
    rm "$CLAUDE_DIR/rules/$name"
    echo "Removed rules/$name"
  fi
done

echo "Done. CLAUDE.md and workflow.md were NOT removed (manual cleanup if needed)."
