if [ -x $HOME/dotenv/bin/editor ]; then
   export EDITOR=$HOME/dotenv/bin/editor
else
   export EDITOR=`which emacs`
fi

function ec() {
		nohup $EDITOR $* 2>&1 > /tmp/nohup.out &
}
