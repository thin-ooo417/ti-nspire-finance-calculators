local TITLE = "Cost of delaying one year"
local FORMULA = "delay = C0(1+gc)/(1+r) - C0"

local fields = {
  {k="c0", lab="C0  cost now", v=""},
  {k="gc", lab="gc  cost growth (dec)", v=""},
  {k="r", lab="r  interest (decimal)", v=""},
}

local function calc(V)
  local c1, pv, d
  if V.c0 and V.gc and V.r and 1 + V.r ~= 0 then
    c1 = V.c0 * (1 + V.gc)
    pv = c1 / (1 + V.r)
    d = pv - V.c0
  end
  return {{"Cost next year", fmt(c1)},
          {"PV of next-yr cost", fmt(pv)},
          {"Cost of delay (PV)", fmt(d)}}
end

--@include shared/form_standard.lua
