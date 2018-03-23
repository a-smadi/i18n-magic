#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $I18N_MAGIC_DIR ]; then export I18N_MAGIC_DIR=$HOME/workspace/i18n-magic; fi

cd $I18N_MAGIC_DIR

tmux new-session  -d -s i18n-magic
tmux set-environment -t i18n-magic -g I18N_MAGIC_DIR $I18N_MAGIC_DIR

tmux new-window     -t i18n-magic -n 'guard'
tmux send-key       -t i18n-magic 'cd $I18N_MAGIC_DIR'      Enter 'bundle exec guard'                                    Enter

tmux new-window     -t i18n-magic -n 'console'
tmux send-key       -t i18n-magic 'cd $I18N_MAGIC_DIR'      Enter 'bundle console'                                       Enter

tmux new-window     -t i18n-magic -n 'vim'
tmux send-key       -t i18n-magic 'cd $I18N_MAGIC_DIR'      Enter 'vim .'                                                Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux -2 attach-session -t i18n-magic
else
  tmux -2 switch-client -t i18n-magic
fi
