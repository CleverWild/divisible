import std/[
  strutils,
  sequtils,
  os,
  math,
]
import suru
import threadpool

const workers = 100 # Количество потоков

proc distribute(arr: seq[int]): seq[seq[int]] =
  ## Распределяет массив между массивами.
  var newSeq: seq[seq[int]] = newSeqWith(workers, newSeq[int]())
  let n = (arr.len + workers - 1) div workers
  for i in 0..<workers:
    let start_n = i * n
    let end_n = min((i + 1) * n, arr.len)
    newSeq[i] = arr[start_n ..< end_n]
  return newSeq

func countDivisors(n: int): int =
  ## Возвращает количество делителей числа `n`.
  var count = 0
  for i in 1..int(sqrt(float(n))):
    if n mod i == 0:
      count += 2
      if i * i == n:
        count -= 1
  return count

proc workerFunc(arr: seq[int]): array[2, int] =
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

proc findMax(arr: array[workers, array[2, int]]): array[2, int] =
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
  let end_num = readLine(stdin).parseInt()
  echo "number pool size: ", end_num - start_num + (start_num == 1).int



  var workerSeq = distribute(toSeq(start_num..end_num))
  var result_table: array[workers, FlowVar[array[2, int]]]
  for i in 0..<workers: # Запускаем каждого worker
    result_table[i] = spawn workerFunc(workerSeq[i]) # [max_dividers, max_dividers_value]


  var echoTable: array[2, int]
  var result_table_int: array[workers, array[2, int]]
  var i: int
  for flowVar in suru(result_table):
    result_table_int[i] = ^result_table[i]
    i.inc
  echoTable = findMax(result_table_int)


  # echo "\nSanity check = 60 by 12"
  echo "\nrecord: ", echoTable[1], " can be divided by ", echoTable[0],
      " values", "\n"

