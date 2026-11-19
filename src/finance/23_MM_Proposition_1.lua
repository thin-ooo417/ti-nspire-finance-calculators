local TITLE = "Modigliani-Miller I"
local FORMULA = "A = D + E"

local fields = {
  {k="a", lab="A  total assets", v=""},
  {k="d", lab="D  debt", v=""},
  {k="e", lab="E  equity", v=""},
}

local function calc(V)
  local ra, re, rd
  if V.d and V.e then ra = V.d + V.e end
  if V.a and V.d then re = V.a - V.d end
  if V.a and V.e then rd = V.a - V.e end
  return {{"A = D + E", fmt(ra)}, {"E = A - D", fmt(re)}, {"D = A - E", fmt(rd)}}
end

--@include shared/form_standard.lua
