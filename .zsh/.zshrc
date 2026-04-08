## ----------------------------------------------------------------------------
## file    : .zshrc
## brief   : general configration.
## module  : .zsh
##
## author  : Teppei Kobayashi <tkobayashi@kirisame.tech>
## date    : 2025/08/20
## ----------------------------------------------------------------------------


## ----------------------------------------------------------------------------
## brief   : terminal multiprexer configuration.
## note    : -
## ----------------------------------------------------------------------------
# launch tmux on terminal emulator
if [ $SHLVL = 1 ]; then
    tmux
fi
# show processing command on mode-line
case "${TERM}" in
    screen*|xterm*)
        preexec() {
            echo -ne "\ek$1\e\\"
        }
        precmd() {
            echo -ne "\ek$(basename $(pwd))\e\\"
        }
        ;;
esac
SPROMPT=$'%U%F{yellow}Did you mean%f%u : %F{red}%R%f -> %F{green}%r%f [n,y,a,e]'


## ----------------------------------------------------------------------------
## brief   : zsh options.
## note    : -
## ----------------------------------------------------------------------------
setopt always_last_prompt  # -
setopt always_to_end       # -
setopt append_history      # add command history
setopt auto_list           # list up commands with ambiguity input
setopt auto_menu           # -
setopt auto_param_keys     # -
setopt auto_param_slash    # add slash last when comp. is directory name
#setopt auto_remove_slash   # remove slash when modifier is last figure

#setopt auto_pushd   # push to stack directories
setopt no_beep      # disable beep sound
#setopt bad_pattern  # display error message when input bad pattern
#setopt bsd_echo     # set echo command behavor compatible bash
setopt c_bases      # change display 16#00 -> 0x00
#setopt cdable_vars  # set comp. dir from home directory
unsetopt chase_links  # convert symbolic link to true directory name
setopt correct      # command spell check

#setopt correct_all           # argument spell check in command
setopt extended_glob         # file name generate conf
#setopt extended_history      # add time data to history
setopt no_flow_control       # disable flow control
setopt print_eight_bit
setopt globdots              # enable completion with dotfiles
setopt hist_ignore_all_dups  # remove duplicate command in history
setopt hist_ignore_dups      # ignore duplicate last command

setopt hist_ignore_space   # remove command from history with first space
setopt hist_no_store       # remove history-command from history
setopt hist_find_no_dups
setopt hist_reduce_blanks  # remove unnecessary spaces from command
setopt hist_no_store
setopt no_hup              # disable send hop signal to job
setopt no_hist_beep
setopt no_list_beep        # disable beep sound when completion
setopt list_types          # show filetype modifier in completion
setopt magic_equal_subst   # -
setopt mark_dirs           # add slash to dir-name

#setopt multios            # option for multi redirection
setopt notify             # notify background job status immediately
setopt numeric_glob_sort  # show numeric file-names numeric sort
setopt prompt_subst       # enable extension completion
setopt pushd_ignore_dups  # ignore duplicate dir-name in stack
setopt pushd_silent       # disable showing directory stack
#setopt share_history      # good config for command history

setopt transient_rprompt    # remove rprompt when run command
setopt no_print_exit_value  # -

# Modern zsh options (added 2024)
setopt auto_cd              # automatically cd into directories
setopt cdable_vars          # cd into variables that start with ~
setopt chase_dots           # resolve .. in cd commands
setopt complete_in_word     # allow completion in middle of word
setopt glob_complete        # complete globs
setopt hash_list_all        # hash entire command path on first execution
setopt interactive_comments # allow comments in interactive shell
setopt long_list_jobs       # show job info in long format
setopt multios              # perform multiple I/O operations
setopt no_bg_nice           # don't nice background jobs
setopt no_clobber           # don't overwrite files with >
setopt path_dirs            # perform path search on commands with /
setopt rc_expand_param      # array expansion with parameters


## ----------------------------------------------------------------------------
## brief   : completion configuration.
## note    : -
## ----------------------------------------------------------------------------
# use colors
autoload -Uz colors
colors

# completion config for zsh-completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit -u

# completion config for some modifiers
zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%F{magenta}%U%d%u%f'$DEFAULT
zstyle ':completion:*:warnings' format '%F{red}%Uno matches: %d%u%f'$DEFAULT
zstyle ':completion:*:corrections' format '%F{yellow}%U%d%u%f %F{red}(errors: %e)%f'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{green}%U%d%u%f'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''

# ignore case
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' completer _complete _approximate _match _expand _prefix

# use cache for completion
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $ZDOTDIR/.zsh_cache

# set completion colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# separator
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# keybind configration in completion
zstyle ':completion:*:default' menu select=2

# ignore object-files, and other intermediate files.
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# manual configuration
zstyle ':completion:*:manuals' separate-sections true

# sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# Modern completion enhancements (added 2024)
# Speed up completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Better file completion
zstyle ':completion:*:*:*:*:files' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true

# Process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Host completion
zstyle ':completion:*:ssh:*' hosts $(<~/.ssh/known_hosts)
zstyle ':completion:*:scp:*' hosts $(<~/.ssh/known_hosts)

# Modern tools completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes


## ----------------------------------------------------------------------------
## brief   : bindkey configuration.
## note    : -
## ----------------------------------------------------------------------------
bindkey -e       # use emacs-like keybinds
bindkey -r '^T'  # remove keybind "T"
bindkey -r '^P'  # remove keybind "P"
bindkey -r '^N'  # remove keybind "N"
bindkey -r '^K'  # remove keybind "K"
bindkey '^P' backward-word
bindkey '^N' forward-word
bindkey '^K' kill-word


## ----------------------------------------------------------------------------
## brief   : load other configuration files.
## note    : -
## ----------------------------------------------------------------------------
# zsh aliases
source $ZDOTDIR/.zaliases

# zsh functions
source $ZDOTDIR/.zfunction

# zsh environment variables
if [ -e .env_secrets ]; then
    source $ZDOTDIR/.env_secrets
fi

# local specific configurations
if [ -e ~/.localconf ]; then
    source ~/.localconf
fi

# zsh plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Modern CLI tools initialization
# Python tools
eval "$(uv generate-shell-completion zsh)"
command -v pyenv >/dev/null && eval "$(pyenv init -)"
command -v pipx >/dev/null && eval "$(register-python-argcomplete pipx)"

# Node.js version management
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Modern CLI replacements
# command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
# command -v starship >/dev/null && eval "$(starship init zsh)"
# command -v atuin >/dev/null && eval "$(atuin init zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Rust tools (source only if env file exists; it may not exist if rustup was not installed via official installer)
command -v rustup >/dev/null && [ -f "${CARGO_HOME:-$HOME/.cargo}/env" ] && source "${CARGO_HOME:-$HOME/.cargo}/env"

# Better completion for modern tools
command -v gh >/dev/null && eval "$(gh completion -s zsh)"
command -v docker >/dev/null && eval "$(docker completion zsh)"
command -v kubectl >/dev/null && source <(kubectl completion zsh)

# zplug
export ZPLUG_HOME=$ZDOTDIR/.zplug
export ZPLUG_LOADFILE=$ZDOTDIR/.zpackages

if [ ! -e $ZPLUG_HOME ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source $ZPLUG_HOME/init.zsh

if ! zplug check --verbose; then
    zplug install
fi

if [[ $ZPLUG_LOADFILE -nt $ZPLUG_CACHE_DIR/interface || ! -f $ZPLUG_CACHE_DIR/interface ]]; then
    zplug check || zplug install
fi

zplug load --verbose > /dev/null

# bun completions
[ -s "/home/kobayashi/.bun/_bun" ] && source "/home/kobayashi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias claude-mem='/home/kobayashi/.bun/bin/bun "/home/kobayashi/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
