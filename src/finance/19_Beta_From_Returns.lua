local TITLE = "Beta (rearranged CAPM)"
local FORMULA = "βi = (E(ri)-rf)/(E(rM)-rf)"

local fields = {
  {k="eri", lab="E(ri)  (decimal)", v=""},
  {k="rf", lab="rf  risk-free (decimal)", v=""},
  {k="erm", lab="E(rM)  (decimal)", v=""},
}

local function calc(V)
  local b
  if V.eri and V.rf and V.erm and V.erm - V.rf ~= 0 then
    b = (V.eri - V.rf) / (V.erm - V.rf)
  end
  return {{"βi", fmt(b)}}
end

--@include shared/form_standard.lua
