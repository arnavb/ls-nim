# Package

version       = "0.1.0"
author        = "Arnav Borborah"
description   = "A simple clone of the ls command in Nim"
license       = "Apache-2.0"
srcDir        = "src"
bin           = @["ls_nim"]
skipExt       = @["nim"]


# Dependencies

requires "nim >= 0.19.4"
