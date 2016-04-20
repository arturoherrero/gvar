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

getvar() {
  cat $FILE | grep -w $1 | cut -d'=' -f2
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
      VALUE="$2"
      echo $VALUE
      exit 0
    ;;
    --unset=*)
      VALUE="${i#*=}"
      echo $VALUE
      exit 0
    ;;
    *=*)
      VARIABLE="${i%=*}"
      VALUE="${i#*=}"
      echo $VARIABLE
      echo $VALUE
    ;;
    *)
      variable="$1"
      getvar $variable
      exit 0
    ;;
  esac
done

if [[ $# == 0 ]]; then
  cat $FILE
fi
