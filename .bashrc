# Homebrew on Apple Silicon and Intel Macs.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

[[ -r "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash"

if [[ "${TERM:-}" != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lha --group-directories-first --icons'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias less='bat --paging=always'
fi

command -v rg >/dev/null 2>&1 && alias grep='rg'
command -v fd >/dev/null 2>&1 && alias fd='fd -H'

alias gst='git status'
alias clc='clear'
alias gb='git branch'
alias gco='git checkout'
alias gl='git pull'
alias glg='git log'
alias glg1='git log -1'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'

command -v claude >/dev/null 2>&1 && alias cc='claude --dangerously-skip-permissions'
command -v codex >/dev/null 2>&1 && alias cdx='codex --dangerously-bypass-approvals-and-sandbox'

if command -v brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for f in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$f" ]] && source "$f"
    done
  fi
fi

if [[ -r "$HOME/.openclaw/completions/openclaw.bash" ]]; then
  source "$HOME/.openclaw/completions/openclaw.bash"
fi

[[ -r "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
