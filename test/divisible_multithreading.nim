import std/[threadpool]
import suru

var # variable declaration
  max_dividers: int
  max_dividers_value: int

const maxPoolSize = 4
setMaxPoolSize(maxPoolSize)

let #* временная замена пользовательского ввода 
  start_num = 1
  end_num = 10

proc countDivisors(n: int): int{.thread.} = #* Функция вычисления количества делений нацело для одного числа
  var count = 0
  for i in 1..n:
    if n mod i == 0:
      count += 1
  return count
  # echo "n = ", n, "; count = ", count

var matrix: array[1000000, int]

for n in suru(start_num - 1..<end_num):
  matrix[n] = ^spawn countDivisors(n)

sync()



#TODO: 
# if matrix > max_dividers:
#   max_dividers_value = matrix
#   max_dividers = n





echo "record: ", max_dividers, " can be divided by ", max_dividers_value, " values", "\n"