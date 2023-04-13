import strutils, random, os
randomize()

let dataDir: string = joinPath(getCurrentDir(), "data.txt")
echo getCurrentDir()
echo dataDir
writeFile(dataDir, "")

proc saveValue*(num: int, lineNum: int) =
  var lines = readFile(dataDir).splitLines

  if lines.len < lineNum: # поиск нужной строки
    for i in 1..(lineNum - lines.len):
      lines.add("0")
  lines[lineNum - 1] = $num
  let text = lines.join("\n")
  writeFile(dataDir, text)

proc getMaxNumberPosInFile*(): int =
  let lines = readFile(dataDir).splitLines
  var i, maxNumIter, maxNumber: int

  for number in lines:
    if number.parseInt > maxNumber:
      maxNumber = number.parseInt
      maxNumIter = i
    i.inc
  result = maxNumIter





saveValue(rand(20), 1)
echo "test 1 pass"
saveValue(rand(20), 2)
echo "test 2 pass"
saveValue(rand(20), 5)
echo "test 3 pass"
saveValue(rand(20), 2)
echo "test 4 pass"

echo "max value pos is: ", getMaxNumberPosInFile()
echo readFile(dataDir).splitLines
echo "all tests pass, clearing file:"

sleep(10000)