local TITLE = "Firm value w/ debt shield"
local FORMULA = "VL = EBIT(1-T)/rU + D T; E = VL - D"

local fields = {
  {k="eb", lab="EBIT (perpetual)", v=""},
  {k="ru", lab="rU  unlevered r (dec)", v=""},
  {k="tau", lab="T  tax rate (decimal)", v=""},
  {k="vu", lab="or VU directly", v=""},
  {k="d", lab="D  perpetual debt", v=""},
  {k="int", lab="or interest paid", v=""},
  {k="rd", lab="rD (with interest)", v=""},
}

local function calc(V)
  local vu = V.vu
  if vu == nil and V.eb and V.ru and V.tau and V.ru ~= 0 then
    vu = V.eb * (1 - V.tau) / V.ru
  end
  local d = V.d
  if d == nil and V.int and V.rd and V.rd ~= 0 then d = V.int / V.rd end
  local sh, vl, eq
  if d and V.tau then sh = d * V.tau end
  if vu and sh then vl = vu + sh end
  if vl and d then eq = vl - d end
  return {{"VU unlevered", fmt(vu)}, {"D used", fmt(d)},
          {"PV tax shield", fmt(sh)}, {"VL total value", fmt(vl)},
          {"E = VL - D", fmt(eq)}}
end

--@include shared/form_standard.lua
