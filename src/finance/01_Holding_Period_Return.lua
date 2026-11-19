local TITLE = "Holding-period return"
local FORMULA = "r = (Pt+1 - Pt + It) / Pt"

local fields = {
  {k="p0", lab="Pt  price at t", v=""},
  {k="p1", lab="Pt+1  price at t+1", v=""},
  {k="inc", lab="It  income at t+1", v="", d=0},
}

local function calc(V)
  local r
  if V.p0 and V.p1 and V.inc and V.p0 ~= 0 then
    r = (V.p1 - V.p0 + V.inc) / V.p0
  end
  return {{"r  return", fmt(r)}, {"r  as %", pct(r)}}
end

--@include shared/form_standard.lua
