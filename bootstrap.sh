# bootstrap.sh
# source this from your .bashrc file
#
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
dotenv=~/dotenv
if [ ! -d ${dotenv} ]; then
  echo not sure where to find your environment. sorry.
  exit
fi

_dotenv_find_files() {
  directory=${1:-common} #private or common
  if [ -d ${dotenv}/${directory} ]; then
    find ${dotenv}/${directory} -type f -name ${2:-'*'} | sort
  fi
}

_dotenv_source_files() {
  if [[ "$DOTENV_DEBUG" -gt 0 ]]; then
    echo "will source:"
    _dotenv_find_files $@ | xargs -n1 echo
    for f in $(_dotenv_find_files $@); do
      read -p "[Enter] to source: $f"
      source $f
    done
  else
    for f in $(_dotenv_find_files $@); do
      source $f
    done
  fi
}

_dotenv_debug() {
  export DOTENV_DEBUG=${1:-1}
  if [[ "$DOTENV_DEBUG" -gt 0 ]]; then
    echo debug mode on
  else
    echo debug mode off
  fi
}

bootstrap=${dotenv}/common/bash
if [ -f ${bootstrap} ]; then
  alias sp="source ${bootstrap}"
  echo Type 'sp' to get your env started.
else
  echo bootstrap file not found!
fi
