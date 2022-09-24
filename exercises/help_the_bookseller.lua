local solution = {}

function solution.stockSummary(artList, firstLetters)
  local result = ""
  if #artList > 0 and #firstLetters > 0 then
    local catalogue = {}
    for _, s in ipairs(artList) do
      local category = string.sub(string.match(s, "([%u]+)"), 1,1)
      local quantity = tonumber(string.match(s, "([%d]+)"))
      catalogue[category] = (catalogue[category] or 0) + quantity
    end
    local summary = {}
    for _, label in ipairs(firstLetters) do
      local quantity = catalogue[label] or 0
      local value = string.format("(%s : %d)", label, quantity)
      table.insert(summary, value)
    end
    result = table.concat(summary, " - ")
  end
  return result
end

return solution
