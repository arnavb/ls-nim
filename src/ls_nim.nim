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
import os
import strformat
import sequtils

const usage = "usage: ls_nim [folder]"
const version = "0.1.0"

proc exitWithMessage(message: string, exitCode: int32): int32 =
  echo message
  result = exitCode

proc main(cliArgs: seq[string]): int32 =
  var folderName = "."
  var folderSet = false

  # Argument parsing
  var optParser = initOptParser(cliArgs)

  for kind, key, value in optParser.getopt():
    case kind
    of cmdArgument:
      if folderSet:
        return exitWithMessage(&"Error! Too many arguments passed!\n{usage}", 1)
      else:
        folderSet = true
        folderName = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h":
        return exitWithMessage(&"ls_nim v{version}\n{usage}", 0)
      of "version", "V":
        return exitWithMessage(&"ls_nim v{version}", 0)
      else:
        return exitWithMessage(&"Error! Invalid option '{key}'\n{usage}", 1)
    of cmdEnd:
      assert false
  # End argument parsing

  let resolvedPath = normalizedPath(absolutePath(folderName))

  # Directory not found
  if not existsDir(resolvedPath):
    return exitWithMessage(&"Error! Directory {resolvedPath} was not found!\n{usage}", 1)

  # List all paths found in specified directory
  for i, foundPath in walkDir(resolvedPath, relative=true).toSeq:
    let foundPath = foundPath.path
    
    if foundPath.len > 19:
      let output = &"{foundPath[0..10]}..."
      stdout.write(&"{output:20}")  
    else:
      stdout.write(&"{foundPath:20}")

    if (i + 1) mod 4 == 0:
      echo ""
  echo ""
  return 0

when isMainModule:
  let exit_code = main(commandLineParams())
  programResult = exit_code
