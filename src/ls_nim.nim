#[
ls_nim - A simple clone of the ls command in Nim
Copyright 2019 Arnav Borborah

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]#

import parseopt
from os import commandLineParams, normalizedPath, absolutePath, existsDir, walkDir
import strformat

const usage = "usage: ls_nim [folder]"
const version = "0.1.0"

proc printHelp =
  echo "ls_nim v" & version
  echo usage

proc main(cliArgs: seq[string]): int32 =
  # Option parser
  var optParser = initOptParser(cliArgs)

  var foldername = "."

  var folderSet = false
  for kind, key, value in optParser.getopt():
    case kind
    of cmdArgument:
      if folderSet:
        echo "Error! Too many arguments passed!"
        echo usage
        return 1
      else:
        folderSet = true
        foldername = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h":
        printHelp()
        return 0
      of "version", "V":
        echo version
        return 0
      else:
        echo "Error! Invalid option '" & key & "'"
        echo usage
        return 1
    of cmdEnd:
      assert false
  
  let resolvedPath = normalizedPath(absolutePath(foldername))

  if not existsDir(resolvedPath):
    echo &"Error! Directory {resolvedPath} was not found!"
    echo usage

  for foundPath in walkDir(resolvedPath, relative=true):
    stdout.write(&"{foundPath.path}\t")
  echo ""

  return 0

when isMainModule:
  let exit_code = main(commandLineParams())
  programResult = exit_code
