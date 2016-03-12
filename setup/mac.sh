for f in $(find mac -type f -name '*.sh' | sort); do
		source $f
done
