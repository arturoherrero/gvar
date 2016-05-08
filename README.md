# gvar

[![Code Climate](https://codeclimate.com/github/arturoherrero/gvar/badges/gpa.svg)](https://codeclimate.com/github/arturoherrero/gvar)
[![Build Status](https://travis-ci.org/arturoherrero/gvar.svg?branch=master)](https://travis-ci.org/arturoherrero/gvar)

gvar(1) -- display, set, or remove global variables*.

<sub>* When I say global variable, I refer to a key-value pair that you can
read/write at any time in any terminal session. You can think this is similar
to the environment variables because it's a set of dynamic-named values but they
are not session-wide or system-wide related.</sub>


## Description

**gvar** is a pure Bash key-value store where each user has a different collection
of data. The records are stored in the user's home directory as `~/.gvar` file.


## Installation

Clone this repository:

```shell
$ git clone git@github.com:arturoherrero/gvar.git
```

Add `gvar/bin/` to your `PATH`:

```shell
$ echo 'export PATH="${PATH}:path/to/gvar/bin"' >> ~/.bash_profile
```

Source your profile:

```shell
$ source ~/.bash_profile
```

#### OS X

```shell
$ brew tap arturoherrero/formulae
$ brew install gvar
```

## Usage

To print out the names and values of all the global variables, use:

```shell
$ gvar
```

To set global variables, use arguments of the form `<VARIABLE>=<VALUE>`,
setting variable `<VARIABLE>` to value `<VALUE>`:

```shell
$ gvar VARIABLE=VALUE
```

Setting a global variable to an empty value is different from unsetting it:

```shell
$ gvar VARIABLE=
```

To print the value of the global variable `<VARIABLE>`, use:

```shell
$ gvar VARIABLE
```

To remove (unset) a global variable `<VARIABLE>`, use:

```shell
$ gvar -u VARIABLE
$ gvar --unset=VARIABLE
```

To delete the environment, removing all the global variables, use:

```shell
$ gvar -d
$ gvar --delete-environment
```


## Who made this?

This was made by Arturo Herrero under the MIT License. Find me on Twitter
[@ArturoHerrero][1].


[1]: https://twitter.com/ArturoHerrero
