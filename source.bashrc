# RVM
export PATH=".:$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -x $HOME/dotenv/bin/editor ]; then
   export EDITOR=$HOME/dotenv/bin/editor
else
   export EDITOR=`which emacs`
fi
alias ec="$EDITOR"
source ~/dotenv/bootstrap.sh
