if hash brew 2> /dev/null; then
		echo brew found
else
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo updating brew
brew update
brew tap caskroom/cask
brew tap homebrew/services
echo installing core packages
brew install brew-cask
brew install bash bash-completion coreutils findutils git libyaml openssl readline wget emacs Caskroom/cask/iterm2
brew install emacs --cocoa

echo setup iterm2 keybindings
open http://brizzled.clapper.org/blog/2009/05/16/mac-os-x-iterm-bash-key-bindings-and-muscle-memory/
