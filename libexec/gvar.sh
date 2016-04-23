#!/usr/bin/env bash

VERSION=0.1.0
FILE=$HOME/.gvar

test -e $FILE || touch $FILE

version() {
  echo "gvar version $VERSION"
}

help() {
  echo "usage: gvar [<variable>[=<value>]] [-u <variable> | --unset=<variable>]"
  echo "            [-d | --delete-environment] [-h | --help] [-v | --version]"
}

get_variable() {
  cat $FILE | grep -w $1 | cut -d'=' -f2
}

set_variable() {
  echo $1=$2 >> $FILE
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
    -d | --delete-environment)
      echo -n > $FILE
    ;;
    *=*)
      variable="${option%=*}"
      value="${option#*=}"
      remove_variable $variable
      set_variable $variable $value
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
