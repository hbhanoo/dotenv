if hash gcloud 2> /dev/null; then
		echo gcloud apis found
else
		while true; do
				read -p "Install gcloud apis? " yn
				case $yn in
						[Yy]* ) curl https://sdk.cloud.google.com | bash; echo 'run gcloud init in a new window'; break;;
						[Nn]* ) exit;;
						* ) echo "Please answer yes or no.";;
				esac
		done
fi
