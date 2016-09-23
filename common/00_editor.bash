if [ -x $HOME/dotenv/bin/editor ]; then
   export EDITOR="$HOME/dotenv/bin/editor"
else
   export EDITOR=`which emacs`
fi

function ec() {
		nohup $EDITOR -n "$@" 2>&1 > /tmp/nohup.out &
}
