local TITLE = "Alpha"
local FORMULA = "E(ri) = α + rf + βi(μM - rf)"

local fields = {
  {k="eri", lab="E(ri)  actual (decimal)", v=""},
  {k="rf", lab="rf  risk-free (decimal)", v=""},
  {k="beta", lab="βi  beta", v=""},
  {k="mm", lab="μM  market E(r) (decimal)", v=""},
}

local function calc(V)
  local a, capm
  if V.rf and V.beta and V.mm then capm = V.rf + V.beta * (V.mm - V.rf) end
  if V.eri and capm then a = V.eri - capm end
  return {{"CAPM E(ri)", fmt(capm)}, {"α  alpha", fmt(a)}, {"α  as %", pct(a)}}
end

--@include shared/form_standard.lua
