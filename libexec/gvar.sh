#!/usr/bin/env bash

FILE=$HOME/.gvar
test -e $FILE || touch $FILE

version() {
  echo "gvar version 0.1.0"
}

help() {
  echo "usage: gvar [variable[=value]] [-u variable | --unset=variable]"
  echo "            [-h | --help] [-v | --version]"
}

get_variable() {
  cat $FILE | grep -w $1 | cut -d'=' -f2
}

remove_variable() {
  sed -i '' "/^$1=/d" $HOME/.gvar
}

for option in "$@"; do
  case $option in
    -h | --help)
      help
      exit 0
    ;;
    -v | --version)
      version
      exit 0
    ;;
    -u)
      variable="$2"
      remove_variable $variable
      exit 0
    ;;
    --unset=*)
      variable="${option#*=}"
      remove_variable $variable
      exit 0
    ;;
    *=*)
      VARIABLE="${option%=*}"
      VALUE="${i#*=}"
      echo $VARIABLE
      echo $VALUE
    ;;
    *)
      variable="$1"
      get_variable $variable
      exit 0
    ;;
  esac
done

if [[ $# == 0 ]]; then
  cat $FILE
fi
