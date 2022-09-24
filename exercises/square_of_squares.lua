-- https://www.codewars.com/kata/54c27a33fb7da0db0100040e/train/lua

local solution = {}

function solution.issquare(n)
  local x = math.sqrt(n)
  return x == math.floor(x)
end

return solution
