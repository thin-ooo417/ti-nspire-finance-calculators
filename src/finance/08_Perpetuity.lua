local TITLE = "Perpetuity (incl. growing)"
local FORMULA = "PV = C/(r - g)   (g = 0: plain)"

local fields = {
  {k="c", lab="C  yearly payment", v=""},
  {k="r", lab="r  rate (decimal)", v=""},
  {k="g", lab="g  growth (decimal)", v="", d=0},
}

local function calc(V)
  local p
  local out = {}
  if V.c and V.r and V.g and V.r - V.g ~= 0 then p = V.c / (V.r - V.g) end
  out[1] = {"PV", fmt(p)}
  if V.r and V.g and V.g >= V.r then
    out[2] = {"!", "g >= r: formula invalid."}
  end
  return out
end

--@include shared/form_standard.lua
