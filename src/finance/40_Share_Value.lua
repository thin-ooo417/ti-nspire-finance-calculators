local TITLE = "Share value: CAPM + g-perp"
local FORMULA = "r = rf + b MRP; P = FCF1/((r-g)N)"

local fields = {
  {k="b", lab="beta", v=""},
  {k="rf", lab="rf  (decimal)", v=""},
  {k="mm", lab="E(rM)  (or blank)", v=""},
  {k="mp", lab="MRP  (or blank)", v=""},
  {k="f1", lab="FCF year 1", v=""},
  {k="g", lab="g  growth (decimal)", v="", d=0},
  {k="n", lab="N  shares (opt)", v=""},
}

local function calc(V)
  local mrp = V.mp or (V.mm and V.rf and V.mm - V.rf)
  local r, v, px
  if V.b and V.rf and mrp then r = V.rf + V.b * mrp end
  if r and V.f1 and V.g and r - V.g ~= 0 then v = V.f1 / (r - V.g) end
  if v and V.n and V.n ~= 0 then px = v / V.n end
  local out = {{"r  cost of equity", pct(r)}, {"V  firm value", fmt(v)},
               {"Price per share", fmt(px)}}
  if r and V.g and V.g >= r then out[#out + 1] = {"!", "g >= r: invalid."} end
  return out
end

--@include shared/form_standard.lua
