# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTFILESIZE=20000

# TODO (bhanoo): move this to another file.

SHARED_HOME=$HOME # ?? /home/${USER}
SHARED_HISTORY_FILE=${SHARED_HOME}/.shared_history

# Setting PROMPT_COMMAND=prompt_command will automatically notify after a run
# finishes for a job that takes more than a minute.
prompt_command() {
  local history_output=$(HISTTIMEFORMAT="%s " history 1)
  local history_number=${history_output/ */}
  local rest=${history_output#*  }
  local started_at=${rest/ */}
  local last_command=${rest#* }
  local finished_at=$(date +%s)
  if [[ ! -z "$LAST_HISTORY_NUMBER" &&
        "$history_number" != "$LAST_HISTORY_NUMBER" ]] &&
    (( $finished_at - $started_at > 60 )); then
    local elapsed_seconds=$(( $finished_at - $started_at ))
    local ds=$((elapsed_seconds % 60))
    local dm=$(((elapsed_seconds / 60) % 60))
    local dh=$((elapsed_seconds / 3600))
    local elapsed=$(printf '%d:%02d:%02d' $dh $dm $ds)
    if [ -n "$DISPLAY" ]; then
      notify-send "Finished in ${elapsed}:" "$last_command"
    else
      echo "Finished in ${elapsed}"
    fi
  fi
  LAST_HISTORY_NUMBER=$history_number
}

# Log the commands only for user 'hbhanoo'
if [ $USER = hbhanoo ]; then
  PROMPT_COMMAND='echo `date` `tty` `pwd` `history 1` >> ${SHARED_HISTORY_FILE}'
else
  unset -v PROMPT_COMMAND
fi
