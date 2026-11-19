local TITLE = "Security futures (solve)"
local FORMULA = "Ft = S0(1 + rf - y)^t"

local fields = {
  {k="s0", lab="S0  spot price", v=""},
  {k="t", lab="t  periods", v=""},
  {k="rf", lab="rf  (or blank)", v=""},
  {k="y", lab="y  div yield (or blank)", v=""},
  {k="f", lab="Ft  (or blank)", v=""},
}

local function calc(V)
  local f, y, rf = V.f, V.y, V.rf
  if V.s0 and V.t and V.s0 ~= 0 and V.t ~= 0 then
    if f == nil and rf and y then
      f = V.s0 * (1 + rf - y) ^ V.t
    elseif y == nil and f and rf and f / V.s0 > 0 then
      y = 1 + rf - (f / V.s0) ^ (1 / V.t)
    elseif rf == nil and f and y and f / V.s0 > 0 then
      rf = (f / V.s0) ^ (1 / V.t) - 1 + y
    end
  end
  return {{"Ft", fmt(f)}, {"y  div yield", pct(y)}, {"rf", pct(rf)}}
end

--@include shared/form_standard.lua
