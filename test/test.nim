import os, times

let timeout = 5.0
var inputStr: string

echo "Введите текст в течение ", timeout, " секунд:"

let startTime = epochTime()
while epochTime() - startTime < timeout:
  if stdin.readLine(inputStr):
    echo "Вы ввели: ", inputStr
    break

if epochTime() - startTime >= timeout:
  echo "Время вышло!"1