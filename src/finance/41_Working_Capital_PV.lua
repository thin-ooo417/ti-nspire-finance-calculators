local TITLE = "PV of working capital (5y)"
local FORMULA = "NWC = AR+Inv-AP; PV of -dNWC"

local fields = {
  {k="a1", lab="AR y1", v="", d=0}, {k="a2", lab="AR y2", v="", d=0},
  {k="a3", lab="AR y3", v="", d=0}, {k="a4", lab="AR y4", v="", d=0},
  {k="a5", lab="AR y5", v="", d=0},
  {k="v1", lab="Inv y1", v="", d=0}, {k="v2", lab="Inv y2", v="", d=0},
  {k="v3", lab="Inv y3", v="", d=0}, {k="v4", lab="Inv y4", v="", d=0},
  {k="v5", lab="Inv y5", v="", d=0},
  {k="b1", lab="AP y1", v="", d=0}, {k="b2", lab="AP y2", v="", d=0},
  {k="b3", lab="AP y3", v="", d=0}, {k="b4", lab="AP y4", v="", d=0},
  {k="b5", lab="AP y5", v="", d=0},
  {k="r", lab="r  rate (decimal)", v=""},
}

local function calc(V)
  local nwc, dn = {}, {}
  local prev = 0
  local sN, sD = "", ""
  for i = 1, 5 do
    nwc[i] = V["a" .. i] + V["v" .. i] - V["b" .. i]
    dn[i] = nwc[i] - prev
    prev = nwc[i]
    sN = sN .. string.format("%g ", nwc[i])
    sD = sD .. string.format("%g ", dn[i])
  end
  local pv
  if V.r then
    pv = 0
    for i = 1, 5 do pv = pv - dn[i] / (1 + V.r) ^ i end
  end
  return {{"NWC:", sN}, {"chg:", sD}, {"PV of WC investment", fmt(pv)}}
end

--@include shared/form_standard.lua
