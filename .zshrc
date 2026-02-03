# ============================================================
# ZSHRC - Prayash Thapa (hi@prayash.io)
# Run `ln -s ~/Developer/dotfiles/.zshrc ~/.zshrc` to bind.
# ============================================================

# ------------------------------------------------------------
# 1. ENVIRONMENT & LOCALE
# ------------------------------------------------------------

export LANG=en_US.UTF-8
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# ------------------------------------------------------------
# 2. PATH CONFIGURATION
# ------------------------------------------------------------

# Default paths
export PATH="$HOME/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# Custom binaries
export PATH="$HOME/bin:$PATH"

# pipx
export PATH="$PATH:$HOME/.local/bin"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# ------------------------------------------------------------
# 3. TOOL INITIALIZATION
# ------------------------------------------------------------

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv
eval "$(pyenv init --path)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

autoload -U add-zsh-hook
add-zsh-hook chpwd autoload_nvmrc
autoload_nvmrc

# ------------------------------------------------------------
# 4. SHELL OPTIONS & COMPLETION
# ------------------------------------------------------------

# Colors
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Shell options
setopt NO_CASE_GLOB
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt PROMPT_SUBST
setopt auto_cd

# Autocompletion
autoload -Uz compinit && compinit
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Key bindings
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# ------------------------------------------------------------
# 5. PROMPT
# ------------------------------------------------------------

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' [%b]'
PROMPT='%B%F{magenta} %~%F{green}${vcs_info_msg_0_}%f ❯%f%b '

# ------------------------------------------------------------
# 6. PLUGINS
# ------------------------------------------------------------

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ------------------------------------------------------------
# 7. ALIASES
# ------------------------------------------------------------

# --- Shell Basics ---
alias serc='source ~/.zshrc'
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

alias l='ls -lAFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ll='ls -l'
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh'
alias lsn='ls -1'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'
alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias dud='du -d 1 -h'
alias duf='du -sh *'
(( $+commands[fd] )) || alias fd='find . -type d -name'
alias ff='find . -type f -name'

# Global aliases (pipes)
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

# --- Git ---
alias gc='git clone'
alias gpull='git pull'
alias gfpull='git fetch -p; git pull'
alias gpush='git push'
alias gpushf='git push --force-with-lease'
alias gdf='git diff'
alias glg='git log'
alias glgo='git log --format="%C(yellow)%h %C(blue)%ad%C(auto)%d %C(reset)%s %C(dim)<%an>" --date=short'
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

# --- Node/NPM/Yarn/PNPM ---
alias nu='nvm use'

alias ni='npm install'
alias ns='npm start'
alias nrd='npm run dev'
alias nrb='npm run build'

alias ys='yarn start'
alias yrd='yarn run dev'
alias yrb='yarn run build'
alias yrt='yarn run test'
alias yf='yarn format'
alias yl='yarn lint'
alias yw='yarn workspace'

alias pi='pnpm i'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pl='pnpm lint'

# --- Xcode/iOS ---
alias ugh='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias simrun="xcrun simctl spawn booted"

# --- Navigation ---
alias d='cd ~/dev'
alias dfiles='cd ~/Developer && code .'

# --- Utilities ---
alias server='http-server -o --cors -c-1 -a localhost -p 8000'
alias killdups='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user;killall Finder;echo "Rebuilt Open With, relaunching Finder"'
alias kill3000='kill -9 $(lsof -i tcp:3000 -t)'
alias whatsMyWiFiPassword='security find-generic-password -ga "PrayPal" | grep password:'

# ------------------------------------------------------------
# 8. FUNCTIONS
# ------------------------------------------------------------

# --- Git Helpers ---

# Auto open a GitHub pull request in browser (from Solomon Hawk)
function pr() {
  local repo=`git remote -v | grep -m 1 "origin.*(push)" | sed -e "s/.*github.com[:/]\(.*\)\.git.*/\1/"`
  local branch=`git name-rev --name-only HEAD`
  echo "... creating pull request for branch \"$branch\" in \"$repo\""
  open https://github.com/$repo/pull/new/$branch
}

# --- System Utilities ---

function flushDNS() {
  sudo killall -HUP mDNSResponder
}

copypasta() {
  local command="$@"
  echo "$command\n$(eval {$command})" | tee >(pbcopy)
}

# --- Development Tools ---

# GCC for standalone C files
gco() {
  if [ $# -eq 0 ]; then
    echo "Usage: gco <program_name> [additional flags]"
    return 1
  fi
  program=$1
  shift
  mkdir -p build && gcc -o "build/$program" "$program.c" -lm $@ && "./build/$program"
}

# G++ for C++
g() {
  local file=$1
  local name=${file%.cpp}
  local dir=$(dirname "$file")
  local build_dir="$dir/build"
  mkdir -p "$build_dir"
  shift
  g++ -std=c++17 "$file" -o "$build_dir/$name" $@ && "$build_dir/$name"
}

# Objective-C compilation and execution
objc() {
  if [ -z "$1" ]; then
    echo "Usage: objc <filename.m>"
    return 1
  fi
  filename=$(basename "$1" .m)
  mkdir -p build
  clang -framework Foundation "$1" -o "build/$filename" && "./build/$filename"
}

# --- Xcode/iOS ---

showCurrentXcodeSDK() {
  xcrun --show-sdk-path --sdk $1
}

function list_xcode_provisioning_profiles() {
  while IFS= read -rd '' f; do
    2> /dev/null /usr/libexec/PlistBuddy -c 'Print :Entitlements:application-identifier' /dev/stdin \
      <<< $(security cms -D -i "$f")
  done < <(find "$HOME/Library/MobileDevice/Provisioning Profiles" -name '*.mobileprovision' -print0)
}


# -----------------------------------------------------------
## Photo Tools

# --- Photography ---

function listLRCatalogPreviews() {
  local target_dir="$1"

  if [[ -z "$target_dir" ]]; then
    echo "No directory specified. Running in the current directory: $(pwd)"
    target_dir="."
  fi

  local count=0
  find "$target_dir" -type d \( -path "*/.*" -prune \) -o -type d -name "*Previews.lrdata" \
    -exec sh -c 'size=$(du -sh "{}" | cut -f1); path=$(realpath "{}"); \
    count=$((count+1)); \
    printf "%s\033[33m%s\033[0m %s\033[32m%s\033[0m\n" "[$((count))] " "$size" " " "$path"' _ {} \;
}

function setTimezoneOffsetForPhotos() {
# Updates EXIF timezone offsets (Original, Digitized, and Composite) for target files.
# Usage: setTimezoneOffsetForPhotos <OFFSET> <FILE_OR_DIR>
# Example: setTimezoneOffsetForPhotos +05:45 ./nepal_trip
# Dependencies: exiftool (modifies files in-place)
  # Check if enough arguments are passed
  if [[ $# -lt 2 ]]; then
    echo "Usage: setTimezoneOffsetForPhotos <OFFSET> <FILE_OR_DIRECTORY>"
    echo "Example: setTimezoneOffsetForPhotos +05:45 /path/to/photos"
    return 1
  fi

  local offset="$1"
  shift
  local target="$@"

  exiftool -overwrite_original_in_place \
    -OffsetTime="$offset" \
    -OffsetTimeOriginal="$offset" \
    -OffsetTimeDigitized="$offset" \
    "$target"

  if [[ $? -eq 0 ]]; then
    echo "Successfully updated timezone offsets to '$offset' for: $target"
  else
    echo "Failed to update timezone offsets."
  fi
}

# --- App Customization ---

function changeIcons() {
  if ! command -v fileicon &> /dev/null; then
    echo "Error: The 'fileicon' command-line tool is not installed." >&2
    echo "Please install it to continue (e.g., 'brew install fileicon')." >&2
    return 1
  fi

  echo "Setting app icons..."

  typeset -A app_to_icon_map
  app_to_icon_map=(
    "/Applications/Brave Browser.app"          "$HOME/Documents/AppIcons/Brave.icns"
    "/Applications/iTerm.app"                  "$HOME/Documents/AppIcons/Hyper__Terminal.icns"
    "/Applications/Focusrite Control.app"      "$HOME/Documents/AppIcons/Focusrite_Control.icns"
    "/Applications/Ableton Live 11 Suite.app"  "$HOME/Documents/AppIcons/Ableton_Live_Suite_11.icns"
    "/Applications/Fork.app"                   "$HOME/Documents/AppIcons/Fork.icns"
    "/Applications/Notion.app"                 "$HOME/Documents/AppIcons/Notion.icns"
  )

  for app_path in "${(@k)app_to_icon_map}"; do
    local icon_path="${app_to_icon_map[$app_path]}"

    if [[ ! -d "$app_path" ]]; then
      echo "  Skipping: Application not found at '$app_path'"
      continue
    fi

    if [[ ! -f "$icon_path" ]]; then
      echo "  Skipping: Icon file not found for '$app_path' at '$icon_path'"
      continue
    fi

    echo "  -> Setting icon for '$app_path'"
    sudo fileicon set "$app_path" "$icon_path"
  done

  echo "Done."
}

# ------------------------------------------------------------
# 9. EXTERNAL SOURCES
# ------------------------------------------------------------

_f=~/Developer/fruitco-toolbelt/fruitco-toolbelt.zshrc; [[ -f $_f ]] && . $_f
