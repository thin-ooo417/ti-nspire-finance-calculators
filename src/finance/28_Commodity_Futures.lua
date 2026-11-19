local TITLE = "Commodity futures"
local FORMULA = "Ft = S0(1+rf+store-conv)^t"

local fields = {
  {k="s0", lab="S0  spot price", v=""},
  {k="rf", lab="rf  risk-free (dec)", v=""},
  {k="t", lab="t  periods", v=""},
  {k="st", lab="storage (fraction)", v="", d=0},
  {k="cy", lab="conv yield (fraction)", v="", d=0},
  {k="sd", lab="storage $ per unit", v="", d=0},
  {k="cd", lab="conv $ per unit", v="", d=0},
}

local function calc(V)
  local ft, net
  if V.s0 and V.rf and V.t and V.s0 ~= 0 then
    net = (V.st or 0) + (V.sd or 0) / V.s0 - (V.cy or 0) - (V.cd or 0) / V.s0
    ft = V.s0 * (1 + V.rf + net) ^ V.t
  end
  return {{"net cost yield", pct(net)}, {"Ft  futures price", fmt(ft)}}
end

--@include shared/form_standard.lua
