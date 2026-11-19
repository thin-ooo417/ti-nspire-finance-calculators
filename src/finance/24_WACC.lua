local TITLE = "MMII / WACC"
local FORMULA = "WACC = (D/A) rD + (E/A) rE"

local fields = {
  {k="d", lab="D  debt value", v=""},
  {k="e", lab="E  equity value", v=""},
  {k="rd", lab="rD  cost of debt (dec)", v=""},
  {k="re", lab="rE  cost of equity (dec)", v=""},
}

local function calc(V)
  local a, wd, we, w
  if V.d and V.e then
    a = V.d + V.e
    if a ~= 0 then
      wd = V.d / a
      we = V.e / a
      if V.rd and V.re then w = wd * V.rd + we * V.re end
    end
  end
  return {{"A = D + E", fmt(a)}, {"D/A", fmt(wd)}, {"E/A", fmt(we)},
          {"WACC", fmt(w)}, {"WACC  as %", pct(w)}}
end

--@include shared/form_standard.lua
