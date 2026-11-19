local TITLE = "Profitability index rank"
local FORMULA = "PI = NPV / initial investment"

local fields = {
  {k="i1", lab="Inv 1", v=""}, {k="n1", lab="NPV 1", v=""},
  {k="i2", lab="Inv 2", v=""}, {k="n2", lab="NPV 2", v=""},
  {k="i3", lab="Inv 3", v=""}, {k="n3", lab="NPV 3", v=""},
  {k="i4", lab="Inv 4", v=""}, {k="n4", lab="NPV 4", v=""},
  {k="i5", lab="Inv 5", v=""}, {k="n5", lab="NPV 5", v=""},
  {k="i6", lab="Inv 6", v=""}, {k="n6", lab="NPV 6", v=""},
}

local function calc(V)
  local list = {}
  for idx = 1, 6 do
    local I, N = V["i" .. idx], V["n" .. idx]
    if I and N and I ~= 0 then list[#list + 1] = {idx, N / I} end
  end
  if #list == 0 then return {{"!", "Enter Inv and NPV pairs."}} end
  local s1, s2 = "", ""
  for j = 1, #list do
    local seg = string.format("%d:%.3f ", list[j][1], list[j][2])
    if j <= 3 then s1 = s1 .. seg else s2 = s2 .. seg end
  end
  table.sort(list, function(x, y) return x[2] > y[2] end)
  local rk = ""
  for j = 1, #list do rk = rk .. list[j][1] .. " " end
  local out = {{"PI:", s1}}
  if s2 ~= "" then out[#out + 1] = {"PI:", s2} end
  out[#out + 1] = {"Rank best->worst", rk}
  return out
end

--@include shared/form_standard.lua
