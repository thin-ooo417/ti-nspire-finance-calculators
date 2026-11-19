local TITLE = "Deferred perpetuity"
local FORMULA = "PV = C / (r (1+r)^T)  first pay T+1"

local fields = {
  {k="c", lab="C  yearly payment", v=""},
  {k="r", lab="r  rate (decimal)", v=""},
  {k="t", lab="T  years deferred", v="", d=0},
}

local function calc(V)
  local p
  local out = {}
  if V.c and V.r and V.t and V.r ~= 0 then
    p = V.c / (V.r * (1 + V.r) ^ V.t)
  end
  out[1] = {"PV", fmt(p)}
  if V.r and V.r <= 0 then out[#out + 1] = {"!", "r <= 0: formula invalid."} end
  if V.t and (V.t < 0 or V.t ~= math.floor(V.t)) then
    out[#out + 1] = {"!", "T should be a whole number >= 0."}
  end
  return out
end

--@include shared/form_standard.lua
