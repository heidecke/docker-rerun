#!/bin/bash

if [ ! $APPDIR ]; then export APPDIR=./; fi
if [ ! $RERUN_MODULES ]; then export RERUN_MODULES=./modules; fi

function create-module-links {
  if [ -d $APPDIR/modules ]; then
    for module in $APPDIR/modules/*; do
      if [ -d $module ]; then
        module_name="$(basename "${module}")"
        ln -sf $module $RERUN_MODULES/$module_name
      fi
    done
  else
    echo "No local modules found."
  fi
}

# if empty, display versions of all modules
if [[ $# -eq 0 ]]; then
  rerun
  exit 0
fi

# parse for options
while [ "$1" != "" ]; do
  case $1 in
    -s|--shell)
      create-module-links
      echo "Starting interactive shell..."
      exec bash
      ;;
    *)
      create-module-links
      exec rerun $1
      ;;
  esac
  shift
done