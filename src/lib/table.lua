function invertTable(table)
  reversed = {}
  for i,v in pairs(table) do
    reversed[v] = i
  end
  return reversed
end