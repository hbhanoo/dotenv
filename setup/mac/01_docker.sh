#!/bin/bash
if hash docker 2> /dev/null; then
		echo docker found
else
		echo follow instructions here:
		open https://docs.docker.com/mac/step_one/
fi
