local TITLE = "MM2: new rE after more debt"
local FORMULA = "rE' = rA + (D'/E)(rA - rD)"

local fields = {
  {k="d", lab="D  current debt", v=""},
  {k="e", lab="E  current equity", v=""},
  {k="rd", lab="rD  (decimal)", v=""},
  {k="re", lab="rE  current (decimal)", v=""},
  {k="dd", lab="new debt raised", v="", d=0},
}

local function calc(V)
  local ra, re2
  if V.d and V.e and V.rd and V.re and V.dd and V.d + V.e ~= 0 and V.e ~= 0 then
    ra = (V.d * V.rd + V.e * V.re) / (V.d + V.e)
    local d2 = V.d + V.dd
    re2 = ra + (d2 / V.e) * (ra - V.rd)
  end
  return {{"rA (pre, MM no tax)", pct(ra)}, {"rE new", pct(re2)}}
end

--@include shared/form_standard.lua
