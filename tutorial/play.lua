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

----------------------------------

local Vector = {}

function Vector:new (obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Vector:fill(n)
  if (n <= 0) then
    return
  end
  for i = 1, n, 1 do
    self[i] = math.random(100)
  end
end

function Vector.__tostring(v)
  return "{" .. table.concat(v, ", ") .. "}"
end

local vec = Vector:new()
vec:fill(100)
table.sort(vec, function (e1, e2) return e1 < e2 end)
print(vec)

----------------------------------

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

local str = "hello world"
local i, j = string.find(str, "world")
print(string.sub(str, i, j))

-- Careful with unicode
print(string.len("⧬⥬")) -- 6
print(utf8.len("⧬⥬")) -- 2

for line in io.lines("README.md") do
  print(line)
end

local h = io.open("README.md", "r")
if h
  then
    -- print(h:read("a"))
    local line = h:read "l"
    while line do
      print(line)
      line = h:read "l"
    end
    h:close()
  else print("File README.md does not exists")
end

local t1 = os.time()
print(t1)
print(os.date())
local t2 = os.time()
print(os.difftime(t2, t1))
