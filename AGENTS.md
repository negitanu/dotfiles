# AGENTS.md

## Cursor Cloud specific instructions

This is a **dotfiles repository** (not an application). It contains personal configuration files for Emacs, Zsh, Tmux, and related tools.

### Repository structure

- `.emacs.d/` — Emacs configuration (`init.el` + `inits/` directory with numbered init scripts loaded via `init-loader`)
- `.zsh/` — Zsh configuration (`.zshrc`, `.zshenv`, `.zaliases`, `.zfunction`, custom functions in `functions/`)
- `.tmux.conf` — Tmux configuration
- `.dir_colors` — Terminal color scheme
- `conf/` — Powerline, Mozc, and terminal configurations (JSON + text files)

### Required system packages

- `emacs` (29.x+)
- `zsh` (5.9+)
- `tmux` (3.4+)

### Validation commands

- **Emacs Lisp syntax**: `emacs --batch --eval '(with-temp-buffer (insert-file-contents "FILE.el") (emacs-lisp-mode) (check-parens))'`
- **Zsh syntax**: `zsh -n FILE`
- **Tmux config**: `tmux -f .tmux.conf start-server`
- **Powerline JSON**: `python3 -c "import json; json.load(open('FILE.json'))"`

### Usage for development

To test configurations, symlink the workspace to `~/dotfiles`:
```
ln -sf /workspace $HOME/dotfiles
ln -sf /workspace/.emacs.d $HOME/.emacs.d
ln -sf /workspace/.tmux.conf $HOME/.tmux.conf
ln -sf /workspace/.dir_colors $HOME/.dir_colors
```

### Notes

- There are no build steps, package managers (npm/pip/etc.), or CI/CD pipelines.
- The `.zshrc` auto-starts tmux and installs zplug plugins on first run — this requires network access.
- The Emacs `init.el` auto-installs MELPA packages on first run — this also requires network access.
- Zsh config sets `ZDOTDIR=$HOME/dotfiles/.zsh`, so the workspace must be symlinked to `~/dotfiles` for full sourcing.
