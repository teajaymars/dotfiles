These are my dotfiles. There are many like them, but these are mine.

---

### Basic installation

Install packages.

    brew install zsh
    brew install neovim/neovim/neovim
    # Manually install iTerm2.

Set the scrollback on iTerm2 to infinity.

Use OSX accessibility to remap CapsLock to Ctrl.

Overwrite their config with mine.

    rm -f ~/.zshrc
    ln -s ~/code/dotfiles/.* ~/
    rm ~/.git

Set up neovim.

    vim
    :PlugInstall

Set up git.

    git config --global user.name "Tom Rees"
    git config --global user.email "zephod@gmail.com"
    git config --global core.excludesfile ~/.gitignore_global
    git config --global push.default simple

Make sure you've got a decent version of Node & npm.

    [https://github.com/npm/npm/issues/3125#issuecomment-167163364].

Fix neovim's confusion over the `<C-h>` shortcut, which sometimes becomes `<Backspace>`.

    infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
    tic $TERM.ti

Fix OSX's confusion over the `<C-up>` and other arrow keys.

[fix_ctrl_arrow.png]
