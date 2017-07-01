# zshrc
# Prayash Thapa (prayash@effulgence.io)

# -----------------------------------------------------------
## Init


# nvm
export NVM_LAZY_LOAD=true

plugins+=(zsh-nvm)

# zsh auto-suggestions
plugins+=(zsh-autosuggestions)

# zsh-syntax highlight
 plugins+=(zsh-syntax-highlighting)

# Path to your oh-my-zsh installation.
export ZSH=/Users/$(whoami)/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="effulgence"

# -----------------------------------------------------------
## Paths

# Default
export PATH="$HOME/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# MySQL
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Ruby
export PATH="$PATH:$HOME/.rbenv/shims"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Node
export PATH="$PATH:$HOME/.npm-packages/bin"

# Anaconda
export PATH="$HOME/anaconda/envs/python2/bin:$PATH"

# Python
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Spark
# export SPARK_HOME=/Users/effulgence/spark
# export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
# export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH

export ANACONDA_ROOT="~/anaconda"

# -----------------------------------------------------------
## Aliases

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Source and edit .zshrc
alias serc='source ~/.zshrc && code ~/Developer/.zshrc'

# Node
alias n6='nvm use 6'
alias n8='nvm use 8'

# NPM
alias ni='npm install'
alias ns='npm start'
alias nrd='npm run dev'
alias nrb='npm run build'

# Yarn
alias ys='yarn start'
alias yrd='yarn run dev'
alias yrb='yarn run build'
alias yrt='yarn run test'
alias yf='yarn format'
alias yl='yarn lint'
alias yw='yarn workspace'

# GitHub
alias clone='git clone'
alias pull='git pull'
alias push='git push'
alias diff='git diff'
alias status='git status'
alias add='git add'
alias fetch='git fetch'
alias merge='git merge'
alias mergeff='git merge --ff-only'
alias rebase='git rebase'
alias commit='git commit'
alias amend='git commit --amend'

alias go='git-open'
alias glog='git log'
alias gst='git status'
alias ga='git add'
alias gf='git fetch'
alias gcm='git commit -m'
alias gm='git merge'
alias gr='git rebase'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gbrm='git branch -D'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'

# Directories
alias d='cd ~/dev'
alias dfiles='cd ~/Developer && code .'
alias dojo='cd ~/dev/_dojo'

# Ruby
alias be='bundle exec'

# Utils
alias server='http-server -o --cors -c-1 -a localhost -p 8000'
alias killdups='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user;killall Finder;echo "Rebuilt Open With, relaunching Finder"'


# -----------------------------------------------------------
## Key Bindings

bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# -----------------------------------------------------------
## Colors

autoload -U colors && colors
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"
NO_COLOUR="\[\033[0m\]"
LS_COLORS=$LS_COLORS:'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export LS_COLORS
zstyle ':completion:*' list-colors 'di=33:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# -----------------------------------------------------------
## Additional Configs

# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)
plugins=(zsh-syntax-highlighting)

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# -----------------------------------------------------------
## Docker

# Docker restart
function docker-start() {
  machine_status=$(docker-machine status)

  if [ "Stopped" == $machine_status ]
  then
    docker-machine start default
  fi

  eval "$(docker-machine env default)"
}

# -----------------------------------------------------------
## Utility

# From Solomon Hawk: Auto open a pull request in browser
function pr() {
  local repo=`git remote -v | grep -m 1 "origin.*(push)" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"`
  local branch=`git name-rev --name-only HEAD`
  echo "... creating pull request for branch \"$branch\" in \"$repo\""
  open https://github.com/$repo/pull/new/$branch
}

# From Ian Brennan: checkout master, pull changes, checkout the branch you were on, then rebase
function update() {
  git checkout master && git pull && git checkout - && git rebase master
}

# Flush DNS
function flushDNS() {
  sudo killall -HUP mDNSResponder
}

# -----------------------------------------------------------

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/effulgence/dev/privia/apps/desktop/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/effulgence/dev/privia/apps/desktop/node_modules/tabtab/.completions/electron-forge.zsh

# direnv
eval "$(direnv hook zsh)"