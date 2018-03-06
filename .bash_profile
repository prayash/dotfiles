if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Added by Anaconda3 4.1.1 installer
export PATH="/Users/effulgence/anaconda/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
