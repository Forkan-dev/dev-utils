# ── PATH ─────────────────────────────────
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# ── HISTORY ──────────────────────────────
HISTSIZE=10000; SAVEHIST=10000; HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# ── PLUGINS (from Brewfile) ───────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── PROMPT + SMART NAV ───────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# ── GIT ──────────────────────────────────
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbr='git branch'
alias glog='git log --oneline --graph --decorate'
alias gwip='git add -A && git commit -m "wip"'
alias gunwip='git reset --soft HEAD~1'
alias gstash='git stash'
alias gpop='git stash pop'

# ── DOCKER ───────────────────────────────
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dprune='docker system prune -af --volumes'
alias ld='lazydocker'
dsh()   { docker exec -it "$1" /bin/sh; }
dbash() { docker exec -it "$1" /bin/bash; }

# ── LARAVEL ──────────────────────────────
alias art='php artisan'
alias artm='php artisan migrate'
alias artmf='php artisan migrate:fresh --seed'
alias artr='php artisan route:list'
alias artq='php artisan queue:work'
alias sail='./vendor/bin/sail'
alias sailup='./vendor/bin/sail up -d'
alias saildown='./vendor/bin/sail down'
alias pint='./vendor/bin/pint'
alias pest='./vendor/bin/pest'

# ── GO ────────────────────────────────────
alias gor='go run .'
alias gob='go build .'
alias got='go test ./...'
alias gotv='go test -v ./...'
alias gomod='go mod tidy'

# ── TMUX ─────────────────────────────────
alias t='tmux'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# ── SYSTEM ───────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --level=2 --icons'
alias cat='bat'
alias vim='nvim'
alias vi='nvim'
alias zrc='nvim ~/dotfiles/zsh/.zshrc'
alias zs='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
mkcd() { mkdir -p "$1" && cd "$1"; }
gcl()  { git clone "$1" && cd "$(basename "$1" .git)"; }
