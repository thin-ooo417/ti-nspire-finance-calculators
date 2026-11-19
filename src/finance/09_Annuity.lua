local TITLE = "Annuity (PV or payment)"
local FORMULA = "PV = (C/r)(1 - 1/(1+r)^T)"

local fields = {
  {k="r", lab="r  rate per period", v=""},
  {k="t", lab="T  periods", v=""},
  {k="c", lab="C  payment (or blank)", v=""},
  {k="pv", lab="PV  (or blank)", v=""},
}

local function calc(V)
  local af, p, c
  if V.r and V.t then
    if V.r == 0 then af = V.t
    else af = (1 - 1 / (1 + V.r) ^ V.t) / V.r end
    if V.c then p = V.c * af end
    if V.pv and af ~= 0 then c = V.pv / af end
  end
  local out = {{"Annuity factor AF", fmt(af)}}
  if V.c then out[#out + 1] = {"PV = C x AF", fmt(p)} end
  if V.pv then out[#out + 1] = {"C = PV / AF", fmt(c)} end
  if V.c == nil and V.pv == nil then out[#out + 1] = {"!", "Enter C or PV."} end
  return out
end

--@include shared/form_standard.lua
