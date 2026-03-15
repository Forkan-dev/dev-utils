# dev-utils

Personal developer environment setup — interactive guides, dotfiles, and project templates for Mac and Linux.

## Quick start

Open `dev_setup.html` in a browser. Use the **⚡ Mac / 🐧 Linux** toggle to switch between setups. Follow phases in order, check off steps as you go.

## What's inside

```
dev-utils/
├── dev_setup.html              ← unified interactive guide (Mac + Linux)
│
├── mac/
│   ├── macbook_m5_dev_setup.html   ← standalone Mac guide
│   ├── dotfiles/                   ← copy to ~/dotfiles, then run bootstrap.sh
│   │   ├── bootstrap.sh            ← single-command Mac restore script
│   │   ├── Brewfile                ← all tools declared in one file
│   │   ├── zsh/.zshrc
│   │   ├── git/.gitconfig
│   │   ├── git/.gitignore_global
│   │   ├── tmux/.tmux.conf
│   │   ├── nvim/.config/nvim/lua/
│   │   │   ├── config/keymaps.lua
│   │   │   └── plugins/extras.lua
│   │   └── starship/.config/starship.toml
│   └── templates/
│       ├── docker-compose.yml      ← universal project template
│       ├── .env.example
│       ├── go/Dockerfile           ← multi-stage distroless build
│       └── laravel/Dockerfile      ← PHP 8.3 FPM + Composer
│
├── linux/
│   └── linux_dev_setup.html        ← standalone Linux guide (Ubuntu / Arch)
│
└── windows/
    └── windows_dev_setup.html      ← (coming soon)
```

## Mac setup — one command

Copy the dotfiles folder to your home directory, then run the bootstrap script:

```bash
cp -r mac/dotfiles ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

The script handles everything in order — Homebrew, Brewfile tools, dotfile symlinks via GNU Stow, Colima (Docker), and LazyVim. Takes ~15 minutes, mostly download time.

## What the Mac setup covers

| Phase | What it does |
|---|---|
| 1 · Homebrew | Installs all tools from `Brewfile` in one shot |
| 2 · Git + SSH | `.gitconfig`, Ed25519 SSH key, GitHub auth |
| 3 · Zsh | `.zshrc` with git, docker, laravel, go aliases — no Oh-My-Zsh |
| 4 · Tmux | Ctrl+a prefix, vim pane nav, Catppuccin status bar, session restore |
| 5 · Neovim | LazyVim + custom keymaps + Go/Blade/Copilot plugins |
| 6 · Docker | Colima runtime (no Docker Desktop), lazydocker |
| 7 · Dockerfiles | Production Go (distroless) and Laravel (PHP 8.3) multi-stage builds |
| 8 · Dotfiles | GNU Stow symlink setup + private GitHub repo backup |

## What the Linux setup covers

| Phase | What it does |
|---|---|
| 1 · System | apt/pacman update, zsh, Nerd Font |
| 2 · CLI Tools | ripgrep, fd, fzf, bat, eza, zoxide, starship, tmux |
| 3 · Git + SSH | `.gitconfig`, Ed25519 key, ssh-agent in shell profile |
| 4 · Zsh | `.zshrc` with all aliases, system-path plugin sources |
| 5 · Docker | Docker CE via official repo, rootless setup, lazydocker |
| 6 · Languages | Go (binary), Node.js (nvm), PHP 8.3 + Composer |
| 7 · Neovim | Latest Neovim + LazyVim |
| 8 · Dotfiles | GNU Stow setup + GitHub CLI + bootstrap.sh |

## Dotfiles structure (GNU Stow)

Each subfolder in `~/dotfiles/` is a Stow package. Running `stow */` from inside `~/dotfiles/` creates symlinks at the correct `$HOME` paths:

```
dotfiles/zsh/.zshrc          → ~/.zshrc
dotfiles/git/.gitconfig      → ~/.gitconfig
dotfiles/tmux/.tmux.conf     → ~/.tmux.conf
dotfiles/nvim/.config/nvim/  → ~/.config/nvim/
dotfiles/starship/.config/starship.toml → ~/.config/starship.toml
```

## Tech stack

- **Shell** — Zsh, no Oh-My-Zsh, ~100ms startup
- **Prompt** — Starship
- **Terminal** — WezTerm + JetBrains Mono Nerd Font
- **Multiplexer** — Tmux (TPM, tmux-resurrect, tmux-continuum)
- **Editor** — Neovim + LazyVim
- **Package manager** — Homebrew (Mac) / apt + pacman (Linux)
- **Docker** — Colima (Mac) / Docker CE (Linux), no Docker Desktop
- **Dotfiles** — GNU Stow
