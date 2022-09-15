local function fib_r (n)
    if n <= 1 then return n else return fib_r(n-1) + fib_r(n-2) end
end

-- Notice, we don't need the prefix M
local function fib_m (n)
    local memo = {1, 1}
    local function inner (n)
        if memo[n] == nil then
            memo[n] = inner(n - 1) + inner(n - 2)
        end
        return memo[n]
    end
    return inner(n)
end

local function fib_t (n)
    local T = {}
    T[1], T[2] = 0, 1
    for i=1,n-1 do
        T[i+1] = T[i+1] + T[i]
        T[i+2] = T[i]
    end
    T[#T] = T[#T] + T[#T-1]
    return T[#T]
end

-- MyPackage is global, so no need for `return MyPackage`
MyPackage2 = {
    fib_r = fib_r,
    fib_t = fib_t
}
