#!/bin/sh

set -eu

SKILL_NAME="evidence-first-paper-writing"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)

usage() {
  cat <<'EOF'
Usage:
  ./install.sh --codex
  ./install.sh --claude
  ./install.sh --workbuddy
  ./install.sh --all
  ./install.sh --target <skills-directory>
EOF
}

case "${1:-}" in
  --codex) TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills" ;;
  --claude) TARGET_DIR="${CLAUDE_HOME:-$HOME/.claude}/skills" ;;
  --workbuddy) TARGET_DIR="${WORKBUDDY_HOME:-$HOME/.workbuddy}/skills" ;;
  --target)
    [ "$#" -ge 2 ] || { echo "--target requires a directory" >&2; exit 2; }
    TARGET_DIR=$2 ;;
  --all) TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills" ;;
  --help|-h|"") usage; exit 0 ;;
  *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
esac

SOURCE_DIR="$SCRIPT_DIR/$SKILL_NAME"
[ -f "$SOURCE_DIR/SKILL.md" ] || { echo "Run this script from a repository checkout." >&2; exit 1; }

install_to() {
  DEST_DIR="$1/$SKILL_NAME"
  mkdir -p "$1"
  if [ -e "$DEST_DIR" ]; then
    echo "Refusing to overwrite existing directory: $DEST_DIR" >&2
    return 1
  fi
  cp -R "$SOURCE_DIR" "$DEST_DIR"
  echo "Installed: $DEST_DIR"
}

if [ "${1:-}" = "--all" ]; then
  install_to "${CODEX_HOME:-$HOME/.codex}/skills"
  install_to "${CLAUDE_HOME:-$HOME/.claude}/skills"
  install_to "${WORKBUDDY_HOME:-$HOME/.workbuddy}/skills"
else
  install_to "$TARGET_DIR"
fi
