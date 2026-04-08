## ----------------------------------------------------------------------------
## file    : .zshenv
## brief   : zsh configuration file.
## module  : .zsh
##
## author  : Teppei Kobayashi <tkobayashi@kirisame.tech>
## date    : 2025/08/20
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
eval $(dircolors ~/.dir_colors)

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
