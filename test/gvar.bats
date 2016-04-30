#!/usr/bin/env bash

gvar="${BATS_TEST_DIRNAME}/../libexec/gvar.sh"
FILE=$HOME/.gvar

setup() {
  test -e "$FILE" || touch "$FILE"
  mv "$FILE" "$FILE".copy
  echo OTHER=other  > "$FILE"
  echo TEST=test   >> "$FILE"
  echo TESTING=abc >> "$FILE"
}

@test "invoking gvar prints the names and values of the global variables" {
  run "$gvar"
  [ "$status" -eq 0 ]
  [ "$output" = "$(printf 'OTHER=other\nTEST=test\nTESTING=abc\n')" ]
}

@test "invoking gvar VARIABLE prints the value of the global variable" {
  run "$gvar" TEST
  [ "$status" -eq 0 ]
  [ "$output" = "test" ]
}

@test "invoking gvar VARIABLE OTHER prints the value of the first global variable" {
  run "$gvar" TEST OTHER
  [ "$status" -eq 0 ]
  [ "$output" = "test" ]
}

@test "invoking gvar -u VARIABLE removes the global variable" {
  run "$gvar" -u TEST
  [ "$status" -eq 0 ]
  run "$gvar"
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

@test "invoking gvar -u VARIABLE OTHER removes the first global variable" {
  run "$gvar" -u TEST OTHER
  [ "$status" -eq 0 ]
  run "$gvar"
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

@test "invoking gvar --unset=VARIABLE removes the global variable" {
  run "$gvar" --unset=TEST
  [ "$status" -eq 0 ]
  run "$gvar"
  [ "$output" = "$(printf 'OTHER=other\nTESTING=abc\n')" ]
}

@test "invoking gvar VARIABLE=VALUE adds the global variable" {
  run "$gvar" NAME=arturo
  [ "$status" -eq 0 ]
  run "$gvar" NAME
  [ "$output" = "arturo" ]
}

@test "invoking gvar VARIABLE=VALUE VARIABLE=VALUE adds every global variable of the list" {
  run "$gvar" NAME=arturo SURNAME=herrero
  [ "$status" -eq 0 ]
  run "$gvar" NAME
  [ "$output" = "arturo" ]
  run "$gvar" SURNAME
  [ "$output" = "herrero" ]
}

@test "invoking gvar VARIABLE= adds an empty global variable" {
  run "$gvar" EMPTY=
  [ "$status" -eq 0 ]
  run "$gvar" EMPTY
  [ "$output" = "$(printf '\n')" ]
}

@test "invoking gvar VARIABLE=VALUE for an existing variable, updates the global variable" {
  run "$gvar" TEST=updated
  [ "$status" -eq 0 ]
  run "$gvar" TEST
  [ "$output" = "updated" ]
}

@test "invoking gvar -d deletes all the global variables" {
  run "$gvar" -d
  [ "$status" -eq 0 ]
  run "$gvar"
  [ "$output" = "" ]
}

@test "invoking gvar --delete-environment deletes all the global variables" {
  run "$gvar" --delete-environment
  [ "$status" -eq 0 ]
  run "$gvar"
  [ "$output" = "" ]
}

teardown() {
  mv "$FILE".copy "$FILE"
}
