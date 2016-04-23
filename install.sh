
rm -f ~/.zshrc
ln -s ~/code/dotfiles/.* ~/
rm .git

git config --global user.name "Tom Rees"
git config --global user.email "zephod@gmail.com"
git config --global core.excludesfile ~/.gitignore_global
git config --global push.default simple

echo "open vim and run :PlugInstall"

# Update OSX Settings:
# * Remap Caps Lock to Ctrl
# * Set iTerm scrollback to infinity
# * ...


