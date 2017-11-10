#!/bin/bash
if hash gitx 2> /dev/null; then
		echo gitx found
else
		echo getting gitx
		cd /tmp
		wget http://builds.phere.net/GitX/development/GitX-dev.dmg
		echo move it to your apps folder
		open GitX-dev.dmg
		echo enable terminal usage from the GitX menu...
		open -a gitx
fi
