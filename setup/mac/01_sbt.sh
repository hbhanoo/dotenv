if hash sbt 2> /dev/null; then
		echo sbt found
else
		while true; do
				read -p "Install sbt? " yn
				case $yn in
						[Yy]* ) brew install sbt; break;;
						[Nn]* ) exit;;
						* ) echo "Please answer yes or no.";;
				esac
		done
fi
