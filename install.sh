#!/bin/bash
_find_source_files() {
		find . -type f -name source.\*
}

_install_source_file() {
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

confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

_import_dot_file() {
		dotfile=$1
		sourcefile=source`basename ${dotfile}`
		if grep -Fxq $sourcefile .dotenvignore
		then
				echo skipping `basename $dotfile`\; marked for never-import
				return
		fi
		if [ -f ${sourcefile} ]; then
				if ( cmp --silent ${dotfile} $sourcefile ); then
						# no worries.
						echo $dotfile already imported.
				else
						echo $dotfile and $sourcefile are different. Figure it out manually:
						diff $dotfile $sourcefile
				fi
		else
				undecided=true
				while $undecided; do
						undecided=false
						read -r -p "Import $dotfile as $sourcefile [y/N/neVer/cat] " response
						response=`echo $response | tr '[:upper:]' '[:lower:]'` # tolower
						case $response in
								yes|y)
										echo cp $dotfile $sourcefile
										cp $dotfile $sourcefile
										;;
								cat|c)
										echo ---
										cat $dotfile
										echo ---
										undecided=true
										;;
								never|v)
										echo adding $sourcefile to .dotenvignore
										echo $sourcefile >> .dotenvignore
										;;
								*)
										false
										;;
						esac
				done
		fi
}

_find_dot_files() {
		find ~/ -type f -name .\*[^~] -maxdepth 1
}

for f in $(_find_source_files); do
		_install_source_file $f
done

for f in $(_find_dot_files); do
		_import_dot_file $f
done
