local TITLE = "Covariance of returns"
local FORMULA = "σA,B = ρA,B σA σB"

local fields = {
  {k="rho", lab="ρA,B  correlation", v=""},
  {k="sa", lab="σA  std dev A", v=""},
  {k="sb", lab="σB  std dev B", v=""},
}

local function calc(V)
  local c
  if V.rho and V.sa and V.sb then c = V.rho * V.sa * V.sb end
  local out = {{"Covariance σA,B", fmt(c)}}
  if V.rho and (V.rho < -1 or V.rho > 1) then
    out[#out + 1] = {"!", "ρ must lie between -1 and 1."}
  end
  return out
end

--@include shared/form_standard.lua
