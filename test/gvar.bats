#!/usr/bin/env bash

gvar="${BATS_TEST_DIRNAME}/../libexec/gvar.sh"

setup() {
  mv $HOME/.gvar $HOME/.gvar.copy
  echo OTHER=other > $HOME/.gvar
  echo TEST=test >> $HOME/.gvar
  echo TESTING=abc >> $HOME/.gvar
}

@test "invoking gvar prints the names and values of the global variables" {
  run $gvar
  [ "$status" -eq 0 ]
  [ "$output" = "$(printf 'OTHER=other\nTEST=test\nTESTING=abc\n')" ]
}

@test "invoking gvar VARIABLE prints the value of the global variable" {
  run $gvar TEST
  [ "$status" -eq 0 ]
  [ "$output" = "test" ]
}

@test "invoking gvar VARIABLE OTHER prints the value of the first global variable" {
  run $gvar TEST OTHER
  [ "$status" -eq 0 ]
  [ "$output" = "test" ]
}

@test "invoking gvar -u VARIABLE removes the global variable" {
  run $gvar -u TEST
  [ "$status" -eq 0 ]
  run $gvar
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

@test "invoking gvar -u VARIABLE OTHER removes the first global variable" {
  run $gvar -u TEST OTHER
  [ "$status" -eq 0 ]
  run $gvar
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

@test "invoking gvar --unset=VARIABLE removes the global variable" {
  run $gvar --unset=TEST
  [ "$status" -eq 0 ]
  run $gvar
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

teardown() {
  sed -i '' "/TEST=test/d" $HOME/.gvar
  mv $HOME/.gvar.copy $HOME/.gvar
}
