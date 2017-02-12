export PATH=$HOME/local/bin:$PATH
export PATH=$PATH:/usr/texbin
S1='\u:\W\$ '
export PS1='$ '
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Colors -----------------------------------------------------------
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"
NO_COLOUR="\[\033[0m\]"

# Exports ----------------------------------------------------------
export LC_CTYPE=en_US.UTF-8
export CLICOLOR=1;
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

# Taken from http://github.com/twerth/dotfiles/blob/master/etc/bashrc
# Aliases ----------------------------------------------------
alias l='LC_ALL=C ls -lah'
alias f='find . -iname'
alias killdups='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user;killall Finder;echo "Rebuilt Open With, relaunching Finder"'
alias server='python -m SimpleHTTPServer'

if [ "$OS" = "linux" ] ; then
    alias processes_all='ps -aulx'
else
    alias top='top -o cpu' # os x
fi
