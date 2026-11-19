local TITLE = "FX forward (solve blank)"
local FORMULA = "F = S ((1+r1)/(1+r2))^t; r1: price ccy"

local fields = {
  {k="s0", lab="S  spot (ccy1 per ccy2)", v=""},
  {k="t", lab="t  periods", v=""},
  {k="r1", lab="r1 of ccy1 (or blank)", v=""},
  {k="r2", lab="r2 of ccy2 (or blank)", v=""},
  {k="f", lab="F  forward (or blank)", v=""},
}

local function calc(V)
  local f, r1, r2 = V.f, V.r1, V.r2
  if V.s0 and V.t and V.s0 ~= 0 and V.t ~= 0 then
    if f == nil and r1 and r2 and 1 + r2 ~= 0 then
      f = V.s0 * ((1 + r1) / (1 + r2)) ^ V.t
    elseif r1 == nil and f and r2 and f / V.s0 > 0 then
      r1 = (1 + r2) * (f / V.s0) ^ (1 / V.t) - 1
    elseif r2 == nil and f and r1 and f / V.s0 > 0 then
      r2 = (1 + r1) / ((f / V.s0) ^ (1 / V.t)) - 1
    end
  end
  return {{"F  forward rate", fmt(f)}, {"r1 (ccy1)", pct(r1)}, {"r2 (ccy2)", pct(r2)}}
end

--@include shared/form_standard.lua
