# gvar

[![Code Climate](https://codeclimate.com/github/arturoherrero/gvar/badges/gpa.svg)](https://codeclimate.com/github/arturoherrero/gvar)
[![Build Status](https://travis-ci.org/arturoherrero/gvar.svg?branch=master)](https://travis-ci.org/arturoherrero/gvar)

`gvar` - display, set, or remove global variables.


## Description

**gvar** is a pure Bash key-value store where each user has a different collection
of data. The records are stored in the user's home directory.


## Installation

1. Clone this repository:

        $ git clone git@github.com:arturoherrero/gvar.git

2. Add `gvar/bin/` to your `PATH`:

        $ echo 'export PATH="${PATH}:path/to/gvar/bin"' >> ~/.bash_profile

3. Source your profile

        $ source ~/.bash_profile


## Usage

To print out the names and values of all the global variables, use:

    $ gvar

To set global variables, use arguments of the form <VARIABLE>=<VALUE>,
setting variable <VARIABLE> to value <VALUE>:

    $ gvar VARIABLE=VALUE

Setting a global variable to an empty value is different from unsetting it:

    $ gvar VARIABLE=

To print the value of the global variable <VARIABLE>, use:

    $ gvar VARIABLE

To remove (unset) a global variable <VARIABLE>, use:

    $ gvar -u VARIABLE
    $ gvar --unset=VARIABLE

To delete the environment, removing all the global variables, use:

    $ gvar -d
    $ gvar --delete-environment


## Who made this?

This was made by Arturo Herrero under the MIT License. Find me on Twitter
[@ArturoHerrero][1].


[1]: https://twitter.com/ArturoHerrero
