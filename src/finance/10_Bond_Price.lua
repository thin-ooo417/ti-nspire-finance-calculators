local TITLE = "Bond price (+shift, +roll)"
local FORMULA = "PB = (C/y)(1-1/(1+y)^T) + F/(1+y)^T"

local fields = {
  {k="c", lab="C  coupon per period", v=""},
  {k="fp", lab="F  par value", v=""},
  {k="t", lab="T  periods", v=""},
  {k="y", lab="YTM per period (dec)", v=""},
  {k="y2", lab="new YTM (optional)", v=""},
}

local function price(c, f, y, t)
  if y == 0 then return c * t + f end
  return c / y * (1 - 1 / (1 + y) ^ t) + f / (1 + y) ^ t
end

local function calc(V)
  local out = {}
  if not (V.c and V.fp and V.y and V.t) then return {{"!", "Need C, F, T, YTM."}} end
  local p1 = price(V.c, V.fp, V.y, V.t)
  out[#out + 1] = {"PB  price", fmt(p1)}
  if p1 ~= 0 then out[#out + 1] = {"Current yield C/PB", pct(V.c / p1)} end
  if V.t >= 1 then
    out[#out + 1] = {"P next per. (same y)", fmt(price(V.c, V.fp, V.y, V.t - 1))}
  end
  if V.y2 then
    local p2 = price(V.c, V.fp, V.y2, V.t)
    out[#out + 1] = {"P at new YTM", fmt(p2)}
    if p1 ~= 0 then out[#out + 1] = {"Price change", pct((p2 - p1) / p1)} end
  end
  return out
end

--@include shared/form_standard.lua
