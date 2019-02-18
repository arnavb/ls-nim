# ls-nim

[![Travis Build Status](https://travis-ci.org/arnavb/ls-nim.svg?branch=master)](https://travis-ci.org/arnavb/ls-nim)

This is a simple clone of `ls` command in Nim. I made this mostly
for learning purposes.

## Building and Running

```bash
$ git clone https://github.com/arnavb/ls-nim.git
$ cd ls-nim
$ nimble build
```

The resulting binary (`ls_nim`) will be placed in a folder called `bin`.

### Usage

```
ls_nim v0.1.0
usage: ls_nim [folder]
```

If a file/folder is found with a name greater than 18 characters, the name
will be trimmed to 10 characters with a trailing `...`. This may be changed
in the future.
