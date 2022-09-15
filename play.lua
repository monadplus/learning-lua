local function randomVec(len)
  local v1 = {}
  if (len <= 0) then
    return v1
  end
  for i = 1, len, 1 do
    v1[i] = math.random(100)
  end
  return v1
end

local function printVec(v)
    local s = "{"
    local sep = ""
    for i in ipairs(v) do
        s = s .. sep .. v[i]
        sep = ", "
    end
    print(s .. "}")
end

local v1 = randomVec(100)
printVec(v1)
table.sort(v1, function (e1, e2) return e1 < e2 end)
printVec(v1)
