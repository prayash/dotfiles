local ret_status="%(?:%{$fg_bold[blue]%}//:%{$fg_bold[red]%}//)"
PROMPT='${ret_status} %F{magenta}${SSH_TTY:+%n@%m }%F{white}%1~%f${vcs_info}\
%(!.%B%F{red}#%f%b.%B %(?.%F{blue}.%F{red})❯%f%b) '
  RPROMPT=''
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
