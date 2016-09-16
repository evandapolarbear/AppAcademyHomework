def sum_to(n)
  #sum from 1 to n, including n
  return 1 if n == 1
  n + sum_to(n - 1)
end

def add_numbers(arr)
  #recursively add all the numbers in an array
  return arr[0] if arr.count == 1

  arr[0] + add_numbers(arr[1..-1])
end

def gamma_fnc(n)
  #write a recursive function that returns the factorial of
  #n - 1
  return nil if n < 1
  return 1 if n == 1
  (n - 1) * gamma_fnc(n - 1)
end
