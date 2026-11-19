local TITLE = "Sharpe ratio"
local FORMULA = "S = (ri - rf) / σi"

local fields = {
  {k="ri", lab="ri  return of i (decimal)", v=""},
  {k="rf", lab="rf  risk-free (decimal)", v=""},
  {k="si", lab="σi  sd of excess returns", v=""},
}

local function calc(V)
  local s
  if V.ri and V.rf and V.si and V.si ~= 0 then s = (V.ri - V.rf) / V.si end
  return {{"Sharpe ratio S", fmt(s)}}
end

--@include shared/form_standard.lua
