-- https://www.codewars.com/kata/54da539698b8a2ad76000228/train/lua

return {
    is_valid_walk = function(walk)
        if #walk ~= 10 then return false end
        local x = 0
        local y = 0
        for _, c in ipairs(walk) do
            if c == 'n' then
                y = y + 1
            elseif c == 's' then
                y = y - 1
            elseif c == 'e' then
                x = x + 1
            else
                x = x - 1
            end
        end
        return (x == 0) and (y == 0)
    end
}
