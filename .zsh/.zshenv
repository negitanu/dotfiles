## ----------------------------------------------------------------------------
## file    : .zshenv
## brief   : zsh configuration file.
## module  : .zsh
##
## author  : Teppei Kobayashi <kobayanes@gmail.com>
## date    : 2025/08/20 (modernized)
## ----------------------------------------------------------------------------


## ----------------------------------------------------------------------------
## brief   : assign directory to zsh configuration files.
## note    : -
## ----------------------------------------------------------------------------
export ZDOTDIR=$HOME/dotfiles/.zsh
umask 022


## ----------------------------------------------------------------------------
## brief   : environment variables.
## note    : -
## ----------------------------------------------------------------------------
# terminal settings
export TERM=tmux-256color

# dircolors configuration (OS-specific)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: use gdircolors if available (from Homebrew coreutils)
    if command -v gdircolors >/dev/null 2>&1; then
        eval $(gdircolors ~/.dir_colors 2>/dev/null)
    elif command -v dircolors >/dev/null 2>&1; then
        eval $(dircolors ~/.dir_colors 2>/dev/null)
    fi
    # macOS also uses LSCOLORS for ls command (fallback)
    # Format: exfxcxdxbxegedabagacad (see 'man ls' for details)
    export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"
else
    # Linux: use standard dircolors
    if command -v dircolors >/dev/null 2>&1; then
        eval $(dircolors ~/.dir_colors 2>/dev/null)
    fi
fi

# history settings
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
export HISTIGNORE=?:??:???:????

# lang. variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# path configuration (modern tools)
export PATH=/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin  # system

# Development tools
export PATH=$PATH:/usr/local/go/bin:$GOBIN                # Go
export PATH=$PATH:$CARGO_HOME/bin                         # Rust
export PATH=$PATH:$PYENV_ROOT/bin                         # Python (pyenv)
export PATH=$PATH:$PNPM_HOME                              # Node.js (pnpm)

# Modern CLI tools
export PATH=$PATH:/usr/local/bin/bat                      # bat (better cat)
export PATH=$PATH:/usr/local/bin/fd                       # fd (better find)
export PATH=$PATH:/usr/local/bin/rg                       # ripgrep (better grep)
export PATH=$PATH:/usr/local/bin/eza                      # eza (better ls)
export PATH=$PATH:/usr/local/bin/zoxide                   # zoxide (better cd)

# User binaries
export PATH=$PATH:$HOME/bin:$HOME/.local/bin              # user

# command
export MANPAGER='less'
export LESS_TERMCAP_mb=$'\e[33m'     # yellow
export LESS_TERMCAP_md=$'\e[33m'     # yellow
export LESS_TERMCAP_me=$'\e[0m'      # reset bold/blink
export LESS_TERMCAP_so=$'\e[47;30m'  # black/white
export LESS_TERMCAP_se=$'\e[0m'      # reset reverse video
export LESS_TERMCAP_us=$'\e[32m'     # green
export LESS_TERMCAP_ue=$'\e[0m'      # reset underline
export GIT_EDITOR='nano'
export EDITOR='nano'

# fzf
export FZF_TMUX=1
export FZF_DEFAULT_OPTS='-i --cycle --ansi --select-1 --exit-0 --multi'

# less
export LESS="-g -i -M -N -R -S -W -x4 -X"
export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

# Modern development tools
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

# Node.js version management
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/.local/share/pnpm"

# Python tools
export PYENV_ROOT="$HOME/.pyenv"
export PIPX_HOME="$HOME/.local/share/pipx"
export PIPX_BIN_DIR="$HOME/.local/bin"

# Modern CLI tools
export BAT_THEME="Solarized (dark)"
export FD_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# Docker and containers
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Mac OS X Homebrew Hide Hints
export HOMEBREW_NO_ENV_HINTS=1

# Powerline configuration
# Powerline looks for config in $XDG_CONFIG_HOME/powerline
# Create symlink if it doesn't exist: ln -s ~/dotfiles/conf/powerline ~/.config/powerline
# Or set XDG_CONFIG_HOME to point to dotfiles/conf directory
# For now, we'll create a symlink automatically if it doesn't exist
if [ ! -e "$XDG_CONFIG_HOME/powerline" ] && [ -d "$HOME/dotfiles/conf/powerline" ]; then
    mkdir -p "$XDG_CONFIG_HOME"
    ln -sf "$HOME/dotfiles/conf/powerline" "$XDG_CONFIG_HOME/powerline" 2>/dev/null || true
fi
# Detect OS and set Powerline command path
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: use python3 -m powerline.config or find powerline-config in user's Python bin
    if [ -f "$HOME/Library/Python/3.9/bin/powerline-config" ]; then
        export POWERLINE_CONFIG_COMMAND="$HOME/Library/Python/3.9/bin/powerline-config"
    elif [ -f "$HOME/Library/Python/3.10/bin/powerline-config" ]; then
        export POWERLINE_CONFIG_COMMAND="$HOME/Library/Python/3.10/bin/powerline-config"
    elif [ -f "$HOME/Library/Python/3.11/bin/powerline-config" ]; then
        export POWERLINE_CONFIG_COMMAND="$HOME/Library/Python/3.11/bin/powerline-config"
    elif [ -f "$HOME/Library/Python/3.12/bin/powerline-config" ]; then
        export POWERLINE_CONFIG_COMMAND="$HOME/Library/Python/3.12/bin/powerline-config"
    elif command -v powerline-config >/dev/null 2>&1; then
        export POWERLINE_CONFIG_COMMAND="powerline-config"
    else
        # Fallback to python3 module
        export POWERLINE_CONFIG_COMMAND="python3 -m powerline.config"
    fi
    # Add Python user bin to PATH if it exists
    for py_version in 3.9 3.10 3.11 3.12; do
        if [ -d "$HOME/Library/Python/$py_version/bin" ]; then
            export PATH="$PATH:$HOME/Library/Python/$py_version/bin"
        fi
    done
else
    # Linux: standard locations
    if command -v powerline-config >/dev/null 2>&1; then
        export POWERLINE_CONFIG_COMMAND="powerline-config"
    elif [ -f "$HOME/.local/bin/powerline-config" ]; then
        export POWERLINE_CONFIG_COMMAND="$HOME/.local/bin/powerline-config"
    else
        export POWERLINE_CONFIG_COMMAND="python3 -m powerline.config"
    fi
fi