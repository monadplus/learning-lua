-------------------------------------------------------
-- Values and types

-- Basic types:  https://www.lua.org/manual/5.4/manual.html#2.1
-- Coercions: https://www.lua.org/manual/5.4/manual.html#3.4.3

-- Strings ops

local str = "Arnau"
print(string.upper(str))
print(string.sub(str, 0, 3))
print(str .. ":" .. str)
-- https://www.lua.org/manual/5.4/manual.html#6.4.1
print( string.format("Hello Mr. %s! How old are you? %d", "Arnau", 27))
print( string.format("Double %.10f", math.pi))

local msg = 'email me at moon@lua.com for more info'
local pat = '[%w%d%-_]+@[%w%d%-_]+%.[%w%d%-_]+'
print( string.match(msg, pat) )

-------------------------------------------------------
-- Control flow structures

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

-------------------------------------------------------
-- The only data type: Associative arrays

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

-------------------------------------------------------
-- Fucntions

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

-------------------------------------------------------
-- Common patterns


local M = {} -- create an empty table
function M.gcd(a, b)
    if b ~= 0 then
        return M.gcd(b, a % b)
    else
        return math.abs(a)
    end
end
print( M.gcd(8, 12) ) --> 4

-------------------------------------------------------
-- Closure

-- Emulate a Class
local function f()
    -- this variable will be captured by the closure
    -- it acts like an instance variable
    local v = 0
    -- nested function
    -- it acts like an instance method
    local function get()
        return v
    end
    -- another nested function
    local function set(new_v)
        v = new_v
    end
    -- enclosing function returns nested functions
    return {get=get, set=set}
end

local t = f() -- create an instance of the closure
print(t.get()) --> 0
t.set(5)
print(t.get()) --> 5


-- Custom iterators
function power_iter(exp, len) -- exp = exponent, len = length of the series
    local iter = 1 -- variable to keep track of where we are in the series

    return function ()
        if iter <= len then
            local res = iter ^ exp
            iter = iter + 1
            return res
        else
            return nil
        end
    end

end

local square = power_iter(2, 5) -- square series of length 5
while true do
    local num = square() -- call iterator to return the next value
    if num == nil then io.write('\n'); break end
    io.write(num, " ")
end

for num in power_iter(3, 10) do
    io.write(num, " ")
end
io.write('\n')


-------------------------------------------------------
-- Metatables & Metamethods (Method overloading)

-- https://www.lua.org/pil/13.html

local function Set (list)
    local set = {}
    for _, v in ipairs(list) do
        set[v] = true
    end
    return set
end

local s1 = Set {1, 2, 3, 2, 4}

--- Better

Set = {}
Set.mt = {} -- create a metatable for Set

-- You can use syntax ':' (see Vec below)
function Set.new (list)
    local set = {}
    setmetatable(set, Set.mt) -- associate each set object with the metatable
    for _, v in ipairs(list) do set[v] = true end
    return set
end

function Set.mt.__add (a, b)
    local res = Set.new {}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

Set.mt.__concat = Set.mt.__add

function Set.mt.__sub (a, b)
    local res = Set.new {}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = nil end
    return res
end

function Set.mt.__eq (s1, s2)
    for k in pairs(s1) do
      if (not s2[k]) then
        return false
      end
    end
    return true
end

function Set.mt.__tostring (set)
    local s = "{"
    local sep = ""
    for e in pairs(set) do
        s = s .. sep .. e
        sep = ", "
    end
    return s .. "}"
end

local s1 = Set.new {1, 2, 3}
local s2 = Set.new {3, 4, 5}
local s3 = s1 + s2
local s4 = s1 - s2
local s5 = s1 .. s1

print( s3 )
print( s4 )
print( s1 == s2 )
print( s1 == s5 )

----------------------------------------
----------------- Overloading

--[[
For each arithmetic operator there is a corresponding field name in a metatable. Besides __add, there are:

    __sub (for subtraction)
    __mul (for multiplication)
    __div (for division)
    __unm (for negation)
    __pow (for exponentiation)
    __mod (for modulo)
    __concat (for the concatenation operator ..).

For relational operators, there are:

    __eq (equality)
    __lt (less than)
    __le (less or equal)

There are no separate metamethods for the other three relational operators, as Lua translates a ~= b to not (a == b), a > b to b < a, and a >= b to b <= a.

Other useful metamethods include:

    __tostring, which is used for string representation.
    __call, which makes the object callable.
    __index, which specifies how we retrieve values from missing keys in a table.
    __newindex, which specifies how we assign values to missing keys.
--]]

------------------------------------
-- Example __index and __newindex

local P = { x=10 }

local meta = { x=0, y=0 }

meta.__index = function(table, key)
    return meta[key]
end

meta.__newindex = function(table, key, value)
    meta[key] = value
end

setmetatable(P, meta)

print( P.x, P.y, P.z ) --> 10  0  nil

P.z = 20

print( P.x, P.y, P.z ) --> 10  0  20

for name in pairs(P) do print(name) end

--[[
In the above snippet, when we call `P.x`, since `P` has a `x` field, the value of `x` is returned.

When we call `P.y`, Lua sees that `P` does not have a `y` field, but is
associated a metatable that has an `__index` metamethod.
Lua then calls the `__index` method with `P` and `y`.

Finally, when we execute `P.z = 20`, Lua sees that `P` does not have a `z` field,
but has a metatable with a `__newindex` metamethod.
Lua then calls the `__newindex` metamethod and assigns a new key/value pair to `meta`.
--]]

------------------------------------------------------
-- OOP

local Vector = {} -- our class

-- class data members and methods go in the prototype
Vector.prototype = { x=0, y=0, z=0 }

-- metamethods go in the metatable
-- metatable also indexes the prototype table
Vector.mt = { __index = Vector.prototype }

-- constructor
function Vector.new (obj)
    obj = obj or {}   -- create object if user does not provide one
    setmetatable(obj, Vector.mt)
    return obj
end

-- metamethod
Vector.mt.__add = function(v1, v2)
    local vec = Vector.new()
    vec.x = v1.x + v2.x
    vec.y = v1.y + v2.y
    vec.z = v1.z + v2.z
    return vec
end

-- prototype method
Vector.prototype.translate = function (vec, dy, dx, dz)
    vec.x = vec.x + dx
    vec.y = vec.y + dy
    vec.z = vec.z + dz
end

local v1 = Vector.new {x=10,y=10,z=10}
local v2 = Vector.new {x=15, y=15}
local v3 = Vector.new()

v3 = v1 + v2
v1.translate(v1, 10, 10, 10)

print( v1.x, v1.y, v1.z ) --> 20  20  20
print( v2.x, v2.y, v2.z ) --> 15  15  0
print( v3.x, v3.y, v3.z ) --> 25  25  10

--------------------
-- Alternatively

Vector = {  x=0, y=0, z=0 } -- our class

-- constructor
function Vector:new (obj)
    obj = obj or {}   -- create object if user does not provide one
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- metamethod
Vector.__add = function(v1, v2)
    local vec = Vector:new()
    vec.x = v1.x + v2.x
    vec.y = v1.y + v2.y
    vec.z = v1.z + v2.z
    return vec
end

-- prototype method
function Vector:translate (dy, dx, dz)
    self.x = self.x + dx
    self.y = self.y + dy
    self.z = self.z + dz
end

local v1 = Vector:new {x=10,y=10,z=10}
local v2 = Vector:new {x=15, y=15}
local v3 = Vector:new()

v3 = v1 + v2
v1:translate(10, 10, 10)

print( v1.x, v1.y, v1.z ) --> 20  20  20
print( v2.x, v2.y, v2.z ) --> 15  15  0
print( v3.x, v3.y, v3.z ) --> 25  25  10

-------------------------------------------------------
-- Packages

-- Approach 1: returns a table
local M = require("MyPackage")
print("Fib 10: " .. M.fib_m(10))

-- Approach 2: declares a global table
require("MyPackage2")
print("Fib 10: " .. MyPackage2.fib_t(10))


-------------------------------------------------------
-- Global environment


-- Lua keeps all its global variables in a regular table, called the _environment_,
-- and the the environment itself in a global variable `_G`.

print("Before: ", _G["x"])
x = 10
print("After: ", _G["x"])

---------------------------------------------------
-- Standard Libraries

-- https://www.lua.org/manual/5.4/manual.html#6


--------------------------------------------------
-- Coroutines

-- https://www.lua.org/manual/5.4/manual.html#2.6

-- NOTICE, this is not multithreading.
-- Lua doesn't support multithreading by default
-- You need to use something like https://lualanes.github.io/lanes/

function foo (a)
  print("foo", a)
  -- Nested yields behave like yields in the main function
  return coroutine.yield(2*a)
end

co = coroutine.create(
    function (a,b)
       print("co-body", a, b)
       -- 'foo' will yield and make the first 'resum' return the value of the 'yield'.
       -- next 'resum' will be executed from 'foo' assigning 'resum' parameters to 'r'.
       local r = foo(a+1)
       print("co-body", r)
       local r, s = coroutine.yield(a+b, a-b)
       print("co-body", r, s)
       return b, "end"
    end
)

-- co-body 1       10
-- foo     2
-- main    true    4
print("main", coroutine.resume(co, 1, 10))
-- co-body r
-- main    true    11      -9
print("main", coroutine.resume(co, "r"))
-- co-body x       y
-- main    true    10      end
print("main", coroutine.resume(co, "x", "y"))
-- main    false   cannot resume dead coroutine
print("main", coroutine.resume(co, "x", "y"))
