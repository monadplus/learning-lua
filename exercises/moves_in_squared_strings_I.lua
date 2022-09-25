local solution = {}

function solution.horMirror(s)
    local r = {}
    for w in string.gmatch(s, "%S+") do
      table.insert(r, 1, w)
    end
    return table.concat(r, "\n")
end

function solution.vertMirror(s)
    local r = {}
    for w in string.gmatch(s, "%S+") do
      table.insert(r, string.reverse(w))
    end
    return table.concat(r, "\n")
end

function solution.oper(f, s) return f(s) end

return solution
