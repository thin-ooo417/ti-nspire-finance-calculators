local TITLE = "CAPM / security market line"
local FORMULA = "E(ri) = rf + βi(μM - rf)"

local fields = {
  {k="rf", lab="rf  risk-free (decimal)", v=""},
  {k="beta", lab="βi  beta", v=""},
  {k="mm", lab="μM  market E(r) (decimal)", v=""},
}

local function calc(V)
  local mrp, er
  if V.rf and V.mm then mrp = V.mm - V.rf end
  if V.rf and V.beta and mrp then er = V.rf + V.beta * mrp end
  return {{"Market risk premium", fmt(mrp)}, {"E(ri)", fmt(er)}, {"E(ri)  as %", pct(er)}}
end

--@include shared/form_standard.lua
