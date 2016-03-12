#!/bin/bash
if hash gitx 2> /dev/null; then
		echo gitx found
else
		echo getting gitx
		cd /tmp
		wget http://frim.frim.nl/GitXStable.app.zip
		unzip GitXStable.app.zip
		mv GitX.app /Applications
		echo enable terminal usage from the GitX menu...
		open -a gitx
fi
