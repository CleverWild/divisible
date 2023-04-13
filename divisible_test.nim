import std/[threadpool]
import suru

var # variable declaration
  max_dividers {.threadvar.}: int
  max_dividers_value {.threadvar.}: int
  maxPoolSize = 4
setMaxPoolSize(maxPoolSize)

let
  start_num = 1
  end_num = 1000 

proc countDivisors(n: int) {.thread.} = # Функция вычисления количества делений нацело для одного числа
  var count = 0
  for i in 1..n:
    if n mod i == 0:
      count += 1
  if count > max_dividers:
    max_dividers_value = count
    max_dividers = n
  echo "n = ", n, "; count = ", count


for x in suru(start_num - 1..<end_num):
  spawn countDivisors(x)

sync()


echo "record: ", max_dividers, " can be divided by ", max_dividers_value, " values", "\n"