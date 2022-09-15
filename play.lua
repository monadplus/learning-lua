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

function willError(n)
  if (n < 10) then
    return 0x10
  else
      error("told you")
  end
end

local isOk, r = pcall(willError, 1)
print(isOk)
print(r)

local isOk, r = pcall(willError, 20)
print(isOk)
print(r)

local x = "1234"
print(x)
local y = tonumber(x)
print(y)
local x = tostring(y)
print(x)

print(2 / 3)
print(2 // 3)

print("1" == 1)
-- print("1" < 1) -- raises error
print(tonumber("1") == 1)

print(type(1))
print(type(1.1))
