import std/[
  strutils,
  sequtils,
  os,
  math,
]
import weave

const workers = 100 # Количество потоков

func distribute(arr: seq[int]): seq[seq[int]] =
  ## Распределяет массив между массивами.
  var newSeq: seq[seq[int]] = newSeqWith(workers, newSeq[int]())
  let n: int = (arr.len + workers - 1) div workers
  for i in 0..<workers:
    newSeq[i] = arr[i * n ..< min((i + 1) * n, arr.len)] # start_n ..< end_n
  return newSeq 

func countDivisors(n: int): int =
  ## Возвращает количество делителей числа `n`.
  var count = 0
  for i in 1..int(sqrt(float(n))):
    if n mod i == 0:
      count += 2
      if i * i == n:
        dec count
  return count

func workerFunc(arr: seq[int]): array[2, int] {.thread.} =
  ## Функция работы для каждого worker.
  ##
  ## Возвращает локальный максимум и его значение.
  var number, max_dividers, max_dividers_value: int
  for i in arr:
    number = countDivisors(i)
    if number > max_dividers:
      max_dividers = number
      max_dividers_value = i
  return [max_dividers, max_dividers_value]

func findMax(arr: array[workers, array[2, int]]): array[2, int] =
  ## Находит максимальное значение из массива.
  var maxVal: array[2, int]
  for val in arr:
    if val[0] > maxVal[0]:
      maxVal = val
  return maxVal


while true:
  echo "MaxThreadPoolSize: ", workers # (default 256)

  echo "Enter your start number:"
  let start_num = readLine(stdin).parseInt()
  echo "Enter your end number:"
  let end_num = max(readLine(stdin).parseInt(), start_num + workers)
  echo "number pool size: ", end_num - start_num + (start_num == 1).int

  var workerSeq = distribute(toSeq(start_num..end_num))
  var result_table: array[workers, array[2, int]]

  init(Weave)

  parallelFor i in 0..<workers: # Запускаем каждого worker
    captures: {workerSeq}
    result_table[i] = workerFunc(workerSeq[i]) # [max_dividers, max_dividers_value]

  exit(Weave)

  let echoTable = findMax(result_table)
  # echo "\nSanity check = 60 by 12"
  echo "\nrecord: ", echoTable[1], " can be divided by ", echoTable[0],
      " values", "\n"
  
  break

