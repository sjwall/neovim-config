#!/bin/sh
#
# neovim-config installer
# https://github.com/sjwall/neovim-config
#
# Usage:
#   curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/sjwall/neovim-config/main/install.sh | sh
#

set -e

# Configuration
REPO_URL="${NVIM_CONFIG_REPO_URL:-https://github.com/sjwall/neovim-config.git}"
RAW_URL="${NVIM_CONFIG_RAW_URL:-https://raw.githubusercontent.com/sjwall/neovim-config/main}"
BRANCH="${NVIM_CONFIG_BRANCH:-main}"
INSTALL_DIR="${NVIM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/nvim}"

# Setup colors if running in a terminal
if [ -t 1 ]; then
  BOLD="\033[1m"
  GREEN="\033[32m"
  BLUE="\033[34m"
  YELLOW="\033[33m"
  RED="\033[31m"
  RESET="\033[0m"
else
  BOLD=""
  GREEN=""
  BLUE=""
  YELLOW=""
  RED=""
  RESET=""
fi

info() {
  printf "${BLUE}==>${RESET} ${BOLD}%s${RESET}\n" "$1"
}

success() {
  printf "${GREEN}==>${RESET} ${BOLD}%s${RESET}\n" "$1"
}

warn() {
  printf "${YELLOW}warning:${RESET} %s\n" "$1"
}

error() {
  printf "${RED}error:${RESET} %s\n" "$1" >&2
}

IS_UPDATE=0

# Create parent directory if needed
mkdir -p "$(dirname "$INSTALL_DIR")"

# Clone or update repository
if [ -d "$INSTALL_DIR/.git" ]; then
  IS_UPDATE=1
  info "Existing git repository found at $INSTALL_DIR. Updating..."
  if command -v git >/dev/null 2>&1; then
    (
      cd "$INSTALL_DIR"
      git fetch origin "$BRANCH" 2>/dev/null || true
      git checkout -q "$BRANCH" 2>/dev/null || true
      git pull --ff-only origin "$BRANCH" 2>/dev/null || git pull --ff-only 2>/dev/null || warn "Could not fast-forward update git repository. Using existing files."
    )
  else
    warn "git command not found. Keeping existing repository."
  fi
elif [ -d "$INSTALL_DIR" ]; then
  BACKUP_DIR="${INSTALL_DIR}.backup.$(date +%Y%m%d%H%M%S)"
  warn "Existing non-git directory found at $INSTALL_DIR."
  info "Backing up existing configuration to $BACKUP_DIR..."
  mv "$INSTALL_DIR" "$BACKUP_DIR"
  success "Backup created at $BACKUP_DIR"

  info "Installing Neovim configuration to $INSTALL_DIR..."
  if command -v git >/dev/null 2>&1; then
    info "Cloning repository..."
    git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$INSTALL_DIR"
  elif command -v curl >/dev/null 2>&1 && command -v tar >/dev/null 2>&1; then
    info "Downloading archive..."
    mkdir -p "$INSTALL_DIR"
    curl -fsSL "https://github.com/sjwall/neovim-config/archive/refs/heads/${BRANCH}.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1
  elif command -v wget >/dev/null 2>&1 && command -v tar >/dev/null 2>&1; then
    info "Downloading archive..."
    mkdir -p "$INSTALL_DIR"
    wget -qO- "https://github.com/sjwall/neovim-config/archive/refs/heads/${BRANCH}.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1
  else
    error "Neither git nor curl/wget+tar was found. Please install git and try again."
    exit 1
  fi
else
  info "Installing Neovim configuration to $INSTALL_DIR..."
  if command -v git >/dev/null 2>&1; then
    info "Cloning repository..."
    git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$INSTALL_DIR"
  elif command -v curl >/dev/null 2>&1 && command -v tar >/dev/null 2>&1; then
    info "Downloading archive..."
    mkdir -p "$INSTALL_DIR"
    curl -fsSL "https://github.com/sjwall/neovim-config/archive/refs/heads/${BRANCH}.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1
  elif command -v wget >/dev/null 2>&1 && command -v tar >/dev/null 2>&1; then
    info "Downloading archive..."
    mkdir -p "$INSTALL_DIR"
    wget -qO- "https://github.com/sjwall/neovim-config/archive/refs/heads/${BRANCH}.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1
  else
    error "Neither git nor curl/wget+tar was found. Please install git and try again."
    exit 1
  fi
fi

# Verify init.lua exists
if [ ! -f "$INSTALL_DIR/init.lua" ]; then
  error "Failed to locate $INSTALL_DIR/init.lua"
  exit 1
fi

# Check for Neovim binary
if ! command -v nvim >/dev/null 2>&1; then
  warn "nvim command not found. Please install Neovim (v0.10+ recommended) to use this configuration."
fi

echo ""
if [ "$IS_UPDATE" -eq 1 ]; then
  success "Neovim configuration updated successfully!"
else
  success "Neovim configuration installed successfully!"
fi
echo ""
echo "Start Neovim to initialize plugins:"
echo "  nvim"
echo ""
