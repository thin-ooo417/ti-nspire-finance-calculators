local TITLE = "Asset beta (levels or D/E)"
local FORMULA = "bA = (D bD + E bE)/(D+E)"

local fields = {
  {k="d", lab="D  debt value", v=""},
  {k="e", lab="E  equity value", v=""},
  {k="de", lab="or D/E ratio", v=""},
  {k="bd", lab="bD  debt beta", v="", d=0},
  {k="be", lab="bE  equity beta", v=""},
}

local function calc(V)
  local ba
  if V.be then
    if V.de then
      if 1 + V.de ~= 0 then ba = (V.be + V.de * V.bd) / (1 + V.de) end
    elseif V.d and V.e and V.d + V.e ~= 0 then
      ba = (V.d * V.bd + V.e * V.be) / (V.d + V.e)
    end
  end
  return {{"bA  asset beta", fmt(ba)}}
end

--@include shared/form_standard.lua
