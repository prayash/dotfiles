if [ -f ~/.zshrc ]; then
   source ~/.zshrc
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

