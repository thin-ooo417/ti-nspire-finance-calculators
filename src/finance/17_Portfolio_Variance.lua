local TITLE = "Portfolio variance (2 assets)"
local FORMULA = "σP² = xA²σA² + xB²σB² + 2xAxBρσAσB"

local fields = {
  {k="xa", lab="xA  weight A", v=""},
  {k="xb", lab="xB  (blank = 1-xA)", v=""},
  {k="sa", lab="σA  std dev A", v=""},
  {k="sb", lab="σB  std dev B", v=""},
  {k="rho", lab="ρA,B  correlation", v=""},
}

local function calc(V)
  local xb = V.xb
  if xb == nil and V.xa then xb = 1 - V.xa end
  local cov, var, sd
  if V.xa and xb and V.sa and V.sb and V.rho then
    cov = V.rho * V.sa * V.sb
    var = V.xa^2 * V.sa^2 + xb^2 * V.sb^2 + 2 * V.xa * xb * cov
    if var >= 0 then sd = math.sqrt(var) end
  end
  local out = {{"xB used", fmt(xb)}, {"Cov σA,B", fmt(cov)},
               {"Variance σP²", fmt(var)}, {"Std dev σP", fmt(sd)}}
  if V.rho and (V.rho < -1 or V.rho > 1) then
    out[#out + 1] = {"!", "ρ must lie between -1 and 1."}
  end
  return out
end

--@include shared/form_standard.lua
