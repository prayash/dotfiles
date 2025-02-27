# zshrc
# Prayash Thapa (hi@prayash.io)
# Run `ln -s ~/Developer/.zshrc .zshrc` in ~ to bind.

# You may need to manually set your language environment.
export LANG=en_US.UTF-8

# -----------------------------------------------------------
## Colors

autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# -----------------------------------------------------------
## Plugins!

## Syntax Highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Autosuggestions (https://github.com/zsh-users/zsh-autosuggestions)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# -----------------------------------------------------------
## Prompt Configuration

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' [%b]'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%B%F{magenta} %~%F{green}${vcs_info_msg_0_}%f ❯%f%b '
# RPROMPT="%F{111}%K{000}[%D{%f/%m/%y}|%@]"

setopt NO_CASE_GLOB

# -----------------------------------------------------------
## Autocompletion 

autoload -Uz compinit && compinit
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

# Let's make `cd` itself needless!
setopt auto_cd

# -----------------------------------------------------------
## Key Bindings

bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# -----------------------------------------------------------
## History Search

bindkey "^[[A" up-line-or-search # up arrow bindkey
bindkey "^[[B" down-line-or-search # down arrow

# -----------------------------------------------------------
## Aliases

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Source and edit .zshrc
alias serc='source ~/.zshrc'

# nvm
alias n6='nvm use 6'
alias n8='nvm use 8'
alias nu='nvm use'

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

# PNPM
alias pi='pnpm i'
alias ps='pnpm start'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pl='pnpm lint'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh' #Recursive list of files and directories
alias lsn='ls -1'     #A column contains name of files and directories

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
alias duf='du -sh *'
(( $+commands[fd] )) || alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
autoload -Uz is-at-least
if is-at-least 4.2.0; then
  # open browser on urls
  if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
  fi

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done

  if [[ -n "$XIVIEWER" ]]; then
    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts; do alias -s $ft='$XIVIEWER'; done
  fi

  _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts; do alias -s $ft=mplayer; done

  #read documents
  alias -s pdf=acroread
  alias -s ps=gv
  alias -s dvi=xdvi
  alias -s chm=xchm
  alias -s djvu=djview

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
  alias -s ace="unace l"
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# -----------------------------------------------------------
# Node.js

# Auto-switch Node version using .nvmrc
autoload_nvmrc() {
  if [ -f .nvmrc ]; then
    local node_version=$(nvm version)
    local required_version=$(nvm version "$(cat .nvmrc)")

    if [ "$required_version" = "N/A" ]; then
      echo "Node version $(cat .nvmrc) not installed. Installing..."
      nvm install
    elif [ "$node_version" != "$required_version" ]; then
      nvm use
    fi
  fi
}

# Trigger auto-load on directory change
autoload -U add-zsh-hook
add-zsh-hook chpwd autoload_nvmrc
autoload_nvmrc  # Run on initial terminal load

# -----------------------------------------------------------
## Git

alias gto='git-open'
alias gc='git clone'
alias gpull='git pull'
alias gfpull='git fetch -p; git pull'
alias gpush='git push'
alias gpushf='git push --force-with-lease'
alias gdf='git diff'
alias glg='git log'
alias glgo='git log --oneline'
alias gst='git status'
alias gad='git add'
alias gb='git branch'
alias gbd='git branch -D'
alias gcm='git commit -m'
alias gcam='git commit --amend'
alias gmff='git merge --ff-only'

alias gch='git checkout'
alias gchb='git checkout -b'

alias gcfd='git clean -fd'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'
alias grhh='git reset --hard HEAD'
alias grlb='git branch | grep -v "master" | xargs git branch -D'
alias unwip='git reset --soft HEAD^'

# Directories
alias d='cd ~/dev'
alias dfiles='cd ~/Developer && code .'

alias simrun="xcrun simctl spawn booted" # simrun LaunchApp -unlock com.apple.Preferences

# -----------------------------------------------------------
## Utility

copypasta() {
	local command="$@"
	echo "$command\n$(eval {$command})" | tee >(pbcopy)
}

showCurrentXcodeSDK() {
	xcrun --show-sdk-path --sdk $1
}

alias ugh='rm -rf ~/Library/Developer/Xcode/DerivedData'

# -----------------------------------------------------------
## Paths

# Default
export PATH="$HOME/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# Some custom binaries I use are stored here
export PATH="$HOME/bin:$PATH"

# MySQL
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Ruby
# export PATH="$PATH:$HOME/.rbenv/shims"

# rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# Python
alias python=/opt/homebrew/bin/python3

# Created by `pipx` on 2025-02-12 04:14:33
export PATH="$PATH:/Users/prayash/.local/bin"

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"

# Android
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# Fastlane
# export PATH="$HOME/.fastlane/bin:$PATH"

# -----------------------------------------------------------
# Utils

alias server='http-server -o --cors -c-1 -a localhost -p 8000'
alias killdups='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user;killall Finder;echo "Rebuilt Open With, relaunching Finder"'
alias kill3000='kill -9 $(lsof -i tcp:3000 -t)'
alias whatsMyWiFiPassword='security find-generic-password -ga "PrayPal" | grep password:'

function changeIcons() {
  echo "💅 Setting app icons..."
  sudo fileicon set /Applications/Brave\ Browser.app/ ~/Dropbox/Archive/AppIcons/Brave.icns
  sudo fileicon set /Applications/iTerm.app ~/Dropbox/Archive/AppIcons/Hyper__Terminal.icns
  sudo fileicon set /Applications/Focusrite\ Control.app ~/Dropbox/Archive/AppIcons/Focusrite_Control.icns
  sudo fileicon set /Applications/Ableton\ Live\ 11\ Suite.app/ ~/Dropbox/Archive/AppIcons/Ableton_Live_Suite_11.icns
  sudo fileicon set /Applications/Fork.app ~/Dropbox/Archive/AppIcons/Fork.icns
  sudo fileicon set /Applications/Notion.app ~/Dropbox/Archive/AppIcons/Notion.icns
  echo "✨ Done."
}

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
## Utility

# From Solomon Hawk: Auto open a GitHub pull request in browser
function pr() {
  local repo=`git remote -v | grep -m 1 "origin.*(push)" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"`
  local branch=`git name-rev --name-only HEAD`
  echo "... creating pull request for branch \"$branch\" in \"$repo\""
  open https://github.com/$repo/pull/new/$branch
}

# Flush DNS
function flushDNS() {
  sudo killall -HUP mDNSResponder
}

function list_xcode_provisioning_profiles() {
    while IFS= read -rd '' f; do
        2> /dev/null /usr/libexec/PlistBuddy -c 'Print :Entitlements:application-identifier' /dev/stdin \
            <<< $(security cms -D -i "$f")

    done < <(find "$HOME/Library/MobileDevice/Provisioning Profiles" -name '*.mobileprovision' -print0)
}

func listLRCatalogPreviews() {
  local target_dir="$1"

  # If no argument is provided, default to the current directory
  if [[ -z "$target_dir" ]]; then
    echo "No directory specified. Running in the current directory: $(pwd)"
    target_dir="."
  fi

  # Initialize a counter for numbering
  local count=0

  # Execute the find command with numbered, colored output
  find "$target_dir" -type d \( -path "*/.*" -prune \) -o -type d -name "*Previews.lrdata" \
      -exec sh -c 'size=$(du -sh "{}" | cut -f1); path=$(realpath "{}"); \
      count=$((count+1)); \
      printf "%s\033[33m%s\033[0m %s\033[32m%s\033[0m\n" "[$((count))] " "$size" " " "$path"' _ {} \;
}

# setTimezoneOffsetForPhotos +05:45 . to set the photos EXIF metadata to Nepal's timezone
func setTimezoneOffsetForPhotos() {
  # Check if enough arguments are passed
  if [[ $# -lt 2 ]]; then
    echo "Usage: setTimezoneOffsetForPhotos <OFFSET> <FILE_OR_DIRECTORY>"
    echo "Example: setTimezoneOffsetForPhotos +05:45 /path/to/photos"
    return 1
  fi

  # Extract arguments
  local offset="$1"
  shift
  local target="$@"

  # Apply offset using exiftool
  exiftool -overwrite_original_in_place \
    -OffsetTime="$offset" \
    -OffsetTimeOriginal="$offset" \
    -OffsetTimeDigitized="$offset" \
    "$target"

  # Provide feedback
  if [[ $? -eq 0 ]]; then
    echo "Successfully updated timezone offsets to '$offset' for: $target"
  else
    echo "Failed to update timezone offsets."
  fi
}

# -----------------------------------------------------------
## NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# -----------------------------------------------------------
## Fileicons

function changeIcon() {
  icon_path=$1
  app_path="/Applications/$2.app"

  fileicon set $app_path "$1"
}

# -----------------------------------------------------------
## C/C++ toolchains

# GCC alias for standalone C files.
gco() {
  if [ $# -eq 0 ]; then
    echo "Usage: gco <program_name> [additional flags]"
    return 1
  fi
  program=$1
  shift
  mkdir -p build && gcc -o "build/$program" "$program.c" -lm $@ && "./build/$program"
}

# G++ alias for C++.
g() {
  local file=$1                 # Get the .cpp file
  local name=${file%.cpp}       # Remove .cpp extension
  local dir=$(dirname "$file")  # Get directory of source file
  local build_dir="$dir/build"  # Create build dir path
  mkdir -p "$build_dir"         # Create build directory
  shift                         # Remove filename from args
  g++ -std=c++17 "$file" -o "$build_dir/$name" $@ && "$build_dir/$name"
}

# Objective-C compilation and execution
objc() {
  if [ -z "$1" ]; then
      echo "Usage: objc <filename.m>"
      return 1
  fi

  # Get the filename without extension
  filename=$(basename "$1" .m)
  
  # Create build directory if it doesn't exist
  mkdir -p build
  
  # Compile and run
  clang -framework Foundation "$1" -o "build/$filename" && "./build/$filename"
}


# Added by Windsurf
export PATH="/Users/prayash/.codeium/windsurf/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/prayash/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end