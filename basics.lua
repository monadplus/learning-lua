local str = "Arnau"
print(string.upper(str))
print(string.sub(str, 0, 3))
print(str .. ":" .. str)
print( string.format("Hello Mr. %s! How old are you? %d", "Arnau", 27))
print( string.format("Double %.10f", math.pi))

local msg = 'email me at moon@lua.com for more info'
local pat = '[%w%d%-_]+@[%w%d%-_]+%.[%w%d%-_]+'
print( string.match(msg, pat) )

local num = math.random(1, 100)
if (num < 25) then
    print( string.format("%d < 25", num) )
elseif (num < 50) then
    print( string.format("%d < 50", num) )
else
    print( string.format("%d >= 50", num) )
end

local i = 1
while i <= 5 do
    io.write(i, " ")
    i = i + 1
end
io.write("\n")

local i = 1
repeat
    io.write(i, " ")
    i = i + 1
until i > 5
io.write("\n")

-- local min, max = 1, 100
-- local secret = math.random(min, max)
-- while true do
--     io.write(string.format("Guess a number from %d to %d: ", min, max))
--     local guess = io.read("*n") -- "*n" means read a number
--     if guess == secret then
--         print("Correct!")
--         break
--     else
--         if guess > secret then
--             print("The guess is too high!")
--         else
--             print ("The guess is too low!")
--         end
--     end
-- end

-- Lua only has hashmaps!
local vec1 = {"a", "b"}
local vec2 = {[1] = "a", [2] = "b"}
print(vec1 == vec1)
print(vec1 == vec2) -- Compares reference

local T =  {
    4, 8, "x",         -- indexed with T[1], T[2], T[3]
    ["title"] = "Lua", -- indexed with T["title"] or T.title
    x = 3,             -- indexed with T["x"] or T.x
    ["the page"] = 5,  -- indexed with T["the page"]
    [123] = 456,       -- indexed with T[123]
    {4, 5, 6}          -- indexed with T[4][1], T[4][2], T[4][3]
}
print( #T ) -- # returns only the last consecutive integer key !!

local T = {"b", "c", "d"} --> {[1]="b", [2]="c", [3]="d"}
T[1] = "a" --> {[1]="a", [2]="c", [3]="d"}
T[10] = "j" --> {[1]="a", [2]="c", [3]="d", [10]="j"}

table.insert(T, "e") --> {[1]="a", [2]="c", [3]="d", [4],"e", [10]="j"}
table.insert(T, 2, "b") --> {[1]="a", [2]="b", [3]="c", [4]="d", [5],"e", [10]="j"}

T[3] = nil --> {[1]="a", [2]="b", [3]=nil, [4]="d", [5],"e", [10]="j"}
table.remove(T, 3) --> {[1]="a", [2]="b", [4]="d", [5],"e", [10]="j"}

for index, value in ipairs(T) do
    print(index, value)
end

local T = {[1]="a", [2]="b", [3]="c", [10]="j"}
print( table.concat(T, ", ", 2, 3) ) -- b, c

local T = {2, 3, 4, 5}
table.move(T, 3, 4, 1)


local T = {"John", "Mary", "Thomas"}

local function comp(s1, s2)
    return string.sub(s1,2,2) > string.sub(s2,2,2)
end

table.sort(T, comp) --> T = {John, Thomas, Mary}

local function add (a, b)
    return a + b
end

local add
add = function (a, b)
    b = b or 2
    return a + b
end

print(add(2,3))
print(add(3))

function arith(a, b)
    local r1 = a + b
    local r2 = a - b
    local r3 = a * b
    return r1, r2, r3
end

local a, b, c, d = arith(5,4)
print( a, b, c, d )

local function arith(a, b)
    r1 = a + b
    r2 = a - b
    r3 = a * b
    return {r1, r2, r3}
end
local k, l, m = table.unpack(arith(5,4))
print( k, l, m ) --> k=9, l=1, m=20


local function average(...)
    local sum = 0
    local arg = {...} -- capture arguments in a table
    for _, value in ipairs(arg) do
        sum = sum + value
    end
    return (sum / #arg)
end
print( string.format("The average is %.f.", average(10,5,3,4,5,6)) )


-- Common pattern in libs
local M = {} -- create an empty table
function M.gcd(a, b)
    if b ~= 0 then
        return M.gcd(b, a % b)
    else
        return math.abs(a)
    end
end
print( M.gcd(8, 12) ) --> 4
