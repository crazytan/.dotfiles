#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="$(date +%Y%m%d%H%M%S)"
DRY_RUN=0
INSTALL_BREW=0
INSTALL_NPM=0

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--dry-run] [--brew] [--npm]

Symlinks the extracted bash, Starship, and Ghostty configs into $HOME.
Existing files are moved aside with a timestamped .backup suffix.

Options:
  --dry-run  Show what would happen without changing files
  --brew     Run brew bundle using this repo's Brewfile
  --npm      Install npm-packages.txt globally with npm
USAGE
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

link_file() {
  local rel="$1"
  local source="${DOTFILES_DIR}/${rel}"
  local target="${HOME}/${rel}"

  if [[ ! -e "$source" ]]; then
    printf 'missing source: %s\n' "$source" >&2
    return 1
  fi

  run mkdir -p "$(dirname "$target")"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    printf 'already linked: %s\n' "$target"
    return 0
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.backup.${BACKUP_SUFFIX}"
    printf 'backup: %s -> %s\n' "$target" "$backup"
    run mv "$target" "$backup"
  fi

  printf 'link: %s -> %s\n' "$target" "$source"
  run ln -s "$source" "$target"
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    --brew)
      INSTALL_BREW=1
      ;;
    --npm)
      INSTALL_NPM=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'unknown option: %s\n\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

FILES=(
  ".bash_profile"
  ".bashrc"
  ".config/starship.toml"
  ".config/ghostty/config"
  ".config/ghostty/shaders/cursor_tail.glsl"
)

if [[ "$INSTALL_BREW" -eq 1 ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Homebrew is not installed. Install it first: https://brew.sh/\n' >&2
    exit 1
  fi
  run brew bundle --file "${DOTFILES_DIR}/Brewfile"

  FZF_INSTALL="$(brew --prefix)/opt/fzf/install"
  if [[ -x "$FZF_INSTALL" ]]; then
    run "$FZF_INSTALL" --key-bindings --completion --no-update-rc --no-zsh --no-fish --no-nushell
  fi
fi

for rel in "${FILES[@]}"; do
  link_file "$rel"
done

if [[ "$INSTALL_NPM" -eq 1 ]]; then
  if ! command -v npm >/dev/null 2>&1; then
    printf 'npm is not installed. Run ./install.sh --brew first or install Node.js.\n' >&2
    exit 1
  fi
  run xargs npm install -g < "${DOTFILES_DIR}/npm-packages.txt"
fi

printf '\nDone. Open a new shell, or run: source ~/.bashrc\n'
