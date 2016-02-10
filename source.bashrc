# RVM
export PATH=".:$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# android tools
export ANDROID_SDK=/usr/local/Cellar/android-sdk/24.1.2
export ANDROID_NDK=/usr/local/Cellar/android-ndk/r10d
export JAVA_HOME=`/usr/libexec/java_home -v 1.6.0_65-b14-466.1`
if [ -x $HOME/dotenv/bin/editor ]; then
   export EDITOR=$HOME/dotenv/bin/editor
else
   export EDITOR=`which emacs`
fi

source ~/dotenv/bootstrap.sh
