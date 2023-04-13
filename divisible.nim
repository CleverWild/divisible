import std/[math, strutils]
import suru

var # variable declaration
  max_dividers = 0
  max_dividers_value = 0


while true:
  echo "Enter your start number:"
  let start_num = readLine(stdin).parseInt()
  echo "Enter your end number:"
  let end_num = readLine(stdin).parseInt()

  var
    temp_number = 0
    sum = 0
    i = 0

  if int(round((end_num - start_num) / 100)) <= 10: # safe_mode = false
    for numbers in start_num .. end_num:
      echo "\n", "number", " = ", numbers

      temp_number = numbers
      sum = 0
      i = numbers

      while i > 0:
        if temp_number mod i == 0:
          sum.inc
          echo numbers, " is divisible by: ", i
        i.dec

      if sum > max_dividers:
        max_dividers = sum
        max_dividers_value = numbers

      echo numbers, " can be divided by ", sum, " values", "\n"

  else: # safe_mode = true
    for numbers in suru((start_num - 1)..<end_num):

      temp_number = numbers
      sum = 0
      i = numbers

      while i > 0:
        if temp_number mod i == 0:
          sum.inc
        i.dec

      if sum > max_dividers:
        max_dividers = sum
        max_dividers_value = numbers

  echo "record: ", max_dividers_value, " can be divided by ", max_dividers, " values", "\n"

