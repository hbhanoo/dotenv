if hash brew 2> /dev/null; then
		echo brew found
else
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"		
fi
brew update
brew update
brew tap caskroom/cask homebrew/services
