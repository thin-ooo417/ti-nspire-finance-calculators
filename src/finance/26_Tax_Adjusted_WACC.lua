local TITLE = "Tax-adjusted WACC"
local FORMULA = "r* = (D/A)(1-T)rD + (E/A)rE"

local fields = {
  {k="d", lab="D  debt value", v=""},
  {k="e", lab="E  equity value", v=""},
  {k="rd", lab="rD (or blank w/ int)", v=""},
  {k="int", lab="interest exp (opt)", v=""},
  {k="re", lab="rE  cost of equity", v=""},
  {k="tau", lab="T  tax rate (decimal)", v=""},
}

local function calc(V)
  local rd = V.rd
  if rd == nil and V.int and V.d and V.d ~= 0 then rd = V.int / V.d end
  local r
  if V.d and V.e and rd and V.re and V.tau and V.d + V.e ~= 0 then
    local a = V.d + V.e
    r = (V.d / a) * (1 - V.tau) * rd + (V.e / a) * V.re
  end
  return {{"rD used", pct(rd)}, {"r*  tax-adj WACC", pct(r)}}
end

--@include shared/form_standard.lua
