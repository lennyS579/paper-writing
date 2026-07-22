#!/bin/sh

set -eu

REPO_URL="https://github.com/lennyS579/paper-writing.git"
SKILL_NAME="evidence-first-paper-writing"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd || true)

usage() {
  cat <<'EOF'
用法：
  ./install.sh --codex
  ./install.sh --claude
  ./install.sh --workbuddy
  ./install.sh --all
  ./install.sh --target <技能目录>

远程一行安装：
  curl -fsSL https://raw.githubusercontent.com/lennyS579/paper-writing/master/install.sh | sh -s -- --codex
EOF
}

case "${1:-}" in
  --codex)
    TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
    ;;
  --claude)
    TARGET_DIR="${CLAUDE_HOME:-$HOME/.claude}/skills"
    ;;
  --workbuddy)
    TARGET_DIR="${WORKBUDDY_HOME:-$HOME/.workbuddy}/skills"
    ;;
  --target)
    [ "$#" -ge 2 ] || { echo "--target 需要一个目录路径" >&2; exit 2; }
    TARGET_DIR=$2
    ;;
  --all)
    TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
    ;;
  --help|-h|"")
    usage
    exit 0
    ;;
  *)
    echo "未知选项：$1" >&2
    usage >&2
    exit 2
    ;;
esac

SOURCE_DIR=""
if [ -f "$SCRIPT_DIR/$SKILL_NAME/SKILL.md" ]; then
  SOURCE_DIR="$SCRIPT_DIR/$SKILL_NAME"
else
  command -v git >/dev/null 2>&1 || { echo "远程安装需要 git" >&2; exit 1; }
  TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t paper-writing)
  trap 'rm -rf "$TEMP_DIR"' EXIT INT TERM
  git clone --quiet --depth 1 "$REPO_URL" "$TEMP_DIR/repository"
  SOURCE_DIR="$TEMP_DIR/repository/$SKILL_NAME"
fi

install_to() {
  DEST_DIR="$1/$SKILL_NAME"
  mkdir -p "$1"
  if [ -e "$DEST_DIR" ]; then
    echo "目标已存在，为避免覆盖而停止：$DEST_DIR" >&2
    return 1
  fi
  cp -R "$SOURCE_DIR" "$DEST_DIR"
  echo "已安装到：$DEST_DIR"
}

if [ "${1:-}" = "--all" ]; then
  install_to "${CODEX_HOME:-$HOME/.codex}/skills"
  install_to "${CLAUDE_HOME:-$HOME/.claude}/skills"
  install_to "${WORKBUDDY_HOME:-$HOME/.workbuddy}/skills"
else
  install_to "$TARGET_DIR"
fi
