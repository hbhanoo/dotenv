#!/bin/bash
_find_source_files() {
		find . -type f -name source.\*
}

# _merge_files $home $repo
_maybe_merge_files() {
		homefile=$1
		repofile=$2
		#		if confirm "$file and ~/$dotfile are different. Try merging?"; then
		if confirm "$repofile and $homefile are different. Try merging?"; then
				echo 
				tmpfile=$(mktemp /tmp/$repofile.XXXXXX)
				echo "type '?' for help with sdiff merge"
				echo --------------------------------------------------------------------------------
				echo "(REPO)$repofile                    ---                    (HOME) $homefile"
				sdiff -o $tmpfile -d $repofile $homefile
				echo result:
				echo vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
				cat $tmpfile
				echo ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				if confirm "accept merge?"; then
						echo accepting
						cp $tmpfile $repofile
						cp $tmpfile $homefile
				else
						echo 'ignoring'
				fi
				rm $tmpfile
		fi
}

_install_source_file() {
		file=$1
		dotfile=`echo ${file} | sed -e s/source././`
		if [ -f ~/${dotfile} ]; then
			 if ( cmp --silent ~/${dotfile} $file ); then
					 # no worries.
					 echo $dotfile already up to date
			 else
					 _maybe_merge_files ~/$dotfile $file
			 fi
		else
				echo copying $file to home directory as $dotfile
				cp $file ~/$dotfile
		fi
}


# if confirm "do this thing? "; then
#    thing
# fi
confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? } [y/N] " response
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
						_maybe_merge_files $dotfile $sourcefile
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

echo ">> installing files from repo into home directory
"
for f in $(_find_source_files); do
		_install_source_file $f
done

echo ">> seeing if there are any files that need importing
"
for f in $(_find_dot_files); do
		_import_dot_file $f
done
