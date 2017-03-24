# Helper variables
local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%}"
local _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
local _user="%{$fg_bold[magenta]%}%n%{$reset_color%}: "

# Default prompt
PROMPT='
${_user}${_current_dir}$(git_prompt_info)
${_return_status}%(?.%F{blue}.%F{red})❯%f%b '

# Right prompt (empty for now)
RPROMPT=''

# Spellcheck prompt (default)
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[cyan]%}$me%{$reset_color%}:"
  fi
}

# Git prefixes
ZSH_THEME_GIT_PROMPT_PREFIX=": %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
