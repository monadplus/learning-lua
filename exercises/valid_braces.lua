local kata = {}

kata.validBraces = function(str)
  local function inv(e)
    if e == ")" then
      return "("
    elseif e == "]" then
      return "["
    elseif e == "}" then
      return "{"
    else
      error ("unexpected character: %s"):format(e)
    end
  end

  local stack = {}
  for c in str:gmatch"." do
    if c:match("[%[%{%(]") then
      table.insert(stack, c)
    elseif c:match("[%)%}%]]") then
      local prev = table.remove(stack, #stack)
      if prev ~= inv(c) then
        return false
      end
    else
      error ("unexpected character: %s"):format(c)
    end
  end
  return #stack == 0
end

return kata
