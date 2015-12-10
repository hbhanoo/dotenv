#!/bin/bash
_copy_file() {
		file=$1
		dotfile=`echo ${file} | sed -e s/source././`
		if [ -f ~/${dotfile} ]; then
			 if ( cmp --silent ~/${dotfile} $file ); then
					 # no worries.
					 echo $dotfile already up to date
			 else
					 echo $file and ~/$dotfile are different. Figure it out manually:
					 diff $file ~/$dotfile
			 fi
		else
				echo copying $file to home directory as $dotfile
				cp $file ~/$dotfile
		fi
}

_find_dot_files() {
		find . -type f -name source.\*
}

for f in $(_find_dot_files); do
		_copy_file $f
done
