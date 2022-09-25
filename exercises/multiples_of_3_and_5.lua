local solution = {}

function solution.solution(n)
  local sum = 0
  for i = 3, n - 1 do
    if (i % 3 == 0) or (i % 5 == 0) then
      sum = sum + i
    end
  end
  return sum
end

return solution
