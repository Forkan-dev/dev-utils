#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  MacBook M5 Dev Setup — bootstrap.sh
#  Run once on a fresh Mac:  bash bootstrap.sh
#  Everything is idempotent — safe to re-run.
# ─────────────────────────────────────────────────────────────
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log()  { echo -e "\033[1;32m▶\033[0m  $*"; }
warn() { echo -e "\033[1;33m⚠\033[0m  $*"; }
ok()   { echo -e "\033[1;32m✓\033[0m  $*"; }

echo ""
echo "  MacBook M5 Dev Setup"
echo "  ────────────────────────────────────────"
echo ""

# ── 1. Homebrew ───────────────────────────────────────────────
log "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
ok "Homebrew ready  $(brew --version | head -1)"

# ── 2. All tools from Brewfile ────────────────────────────────
log "Installing tools from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
ok "All Brewfile tools installed"

# ── 3. Symlink dotfiles with GNU Stow ────────────────────────
log "Symlinking dotfiles..."
cd "$DOTFILES_DIR"

# Stow each package (skip bootstrap.sh and Brewfile at root)
for pkg in zsh git tmux nvim starship; do
  if [ -d "$pkg" ]; then
    stow --restow --target="$HOME" "$pkg"
    ok "Stowed $pkg"
  fi
done

# ── 4. LazyVim (Neovim base) ─────────────────────────────────
log "Setting up Neovim / LazyVim..."
NVIM_CONFIG="$HOME/.config/nvim"
if [ ! -f "$NVIM_CONFIG/init.lua" ]; then
  # Clone starter into a temp dir, copy base files only.
  # Stow already owns ~/.config/nvim (symlinked from dotfiles/nvim/.config/nvim),
  # so we copy only the LazyVim base files without overwriting our custom lua files.
  git clone https://github.com/LazyVim/starter /tmp/lazyvim-starter
  cp -n /tmp/lazyvim-starter/init.lua "$NVIM_CONFIG/" 2>/dev/null || true
  cp -rn /tmp/lazyvim-starter/lua/lazyvim "$NVIM_CONFIG/lua/" 2>/dev/null || true
  rm -rf /tmp/lazyvim-starter
  ok "LazyVim base installed — custom keymaps + plugins already in place via stow"
else
  ok "Neovim config already exists"
fi

# ── 5. Tmux plugin manager (TPM) ─────────────────────────────
log "Installing TPM (tmux plugin manager)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  ok "TPM cloned — open tmux and press Ctrl+a then Shift+I to install plugins"
else
  ok "TPM already installed"
fi

# ── 6. Docker runtime (Colima) ────────────────────────────────
log "Setting up Colima (Docker runtime)..."
if ! colima status &>/dev/null 2>&1; then
  colima start --cpu 4 --memory 8 --disk 60 --arch aarch64
  brew services start colima
  ok "Colima started and set to auto-start on login"
else
  ok "Colima already running"
fi

# ── 7. SSH key ────────────────────────────────────────────────
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  warn "No SSH key found. Run the following to generate one:"
  echo ""
  echo "  ssh-keygen -t ed25519 -C \"you@email.com\" -f ~/.ssh/id_ed25519"
  echo "  ssh-add --apple-use-keychain ~/.ssh/id_ed25519"
  echo "  pbcopy < ~/.ssh/id_ed25519.pub"
  echo "  # Then paste at github.com/settings/keys"
  echo ""
else
  ok "SSH key exists"
fi

# ── 8. GitHub CLI auth ────────────────────────────────────────
if ! gh auth status &>/dev/null 2>&1; then
  warn "GitHub CLI not authenticated. Run:  gh auth login"
else
  ok "GitHub CLI authenticated"
fi

# ── Done ──────────────────────────────────────────────────────
echo ""
echo "  ────────────────────────────────────────"
echo "  Setup complete!"
echo ""
echo "  Next steps:"
echo "  1. Open a new terminal — zsh + starship will be active"
if ! gh auth status &>/dev/null 2>&1; then
echo "  2. Run 'gh auth login' to authenticate GitHub CLI"
echo "  3. Run 'ssh-keygen -t ed25519 -C you@email.com' to generate SSH key"
fi
echo "  4. Run 'nvim' — LazyVim plugins install automatically on first launch"
echo "  5. Open tmux and press Ctrl+a then Shift+I to install tmux plugins"
echo ""
