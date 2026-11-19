local TITLE = "2-asset portfolio (mu + sd)"
local FORMULA = "one entry: E(r), variance, sd"

local fields = {
  {k="xa", lab="xA  weight of A", v=""},
  {k="xb", lab="xB (blank = 1-xA)", v=""},
  {k="ma", lab="E(rA)  (decimal)", v=""},
  {k="mb", lab="E(rB)", v=""},
  {k="sa", lab="sdA", v=""},
  {k="sb", lab="sdB", v=""},
  {k="rho", lab="rho  correlation", v=""},
}

local function calc(V)
  local xb = V.xb or (V.xa and 1 - V.xa)
  local mu, var, sd
  if V.xa and xb then
    if V.ma and V.mb then mu = V.xa * V.ma + xb * V.mb end
    if V.sa and V.sb and V.rho then
      var = V.xa ^ 2 * V.sa ^ 2 + xb ^ 2 * V.sb ^ 2
            + 2 * V.xa * xb * V.rho * V.sa * V.sb
      if var >= 0 then sd = math.sqrt(var) end
    end
  end
  local out = {{"xB used", fmt(xb)}, {"E(r) portfolio", pct(mu)},
               {"Variance", fmt(var)}, {"Std dev", pct(sd)}}
  if V.rho and (V.rho > 1 or V.rho < -1) then
    out[#out + 1] = {"!", "rho outside [-1, 1]."}
  end
  return out
end

--@include shared/form_standard.lua
