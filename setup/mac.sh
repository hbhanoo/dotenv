#!/bin/bash
for f in $(find $(dirname "${BASH_SOURCE[0]}")/mac -type f -name '*.sh' | sort); do
		while true; do
				read -p "Run $(basename $f)? " yn
				case $yn in
						[Yy]* ) source $f; break;;
						[Nn]* ) echo "	skipping $f"; break;;
						* ) echo "Please answer yes or no.";;
				esac
		done
done
