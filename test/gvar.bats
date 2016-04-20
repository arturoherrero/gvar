#!/usr/bin/env bash

gvar="${BATS_TEST_DIRNAME}/../libexec/gvar.sh"

setup() {
  mv $HOME/.gvar $HOME/.gvar.copy
  echo OTHER=other > $HOME/.gvar
  echo TEST=test >> $HOME/.gvar
}

@test "prints the names and values of the global variables" {
  run $gvar
  [ "$status" -eq 0 ]
  [ "$output" = "$(printf 'OTHER=other\nTEST=test\n')" ]
}

@test "prints the value of the global variable" {
  run $gvar TEST
  [ "$status" -eq 0 ]
  [ "$output" = "test" ]
}

@test "removes the global variable" {
  skip
}

teardown() {
  sed -i '' "/TEST=test/d" $HOME/.gvar
  mv $HOME/.gvar.copy $HOME/.gvar
}
