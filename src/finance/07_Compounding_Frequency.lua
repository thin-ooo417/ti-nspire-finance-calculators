local TITLE = "Compounding frequency"
local FORMULA = "FV = C (1 + r/f)^(f t)"

local fields = {
  {k="c", lab="C  deposit", v=""},
  {k="r", lab="r  annual rate (decimal)", v=""},
  {k="f", lab="f  times per year", v=""},
  {k="t", lab="t  years", v=""},
}

local function calc(V)
  local fv, ear
  if V.c and V.r and V.f and V.t and V.f ~= 0 then
    fv = V.c * (1 + V.r / V.f)^(V.f * V.t)
    ear = (1 + V.r / V.f)^V.f - 1
  end
  return {{"FV after t years", fmt(fv)}, {"Effective annual rate", pct(ear)}}
end

--@include shared/form_standard.lua
