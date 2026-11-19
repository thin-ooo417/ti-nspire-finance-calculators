local TITLE = "Present value"
local FORMULA = "PV = CFt x 1/(1+r)^t"

local fields = {
  {k="cf", lab="CFt  cashflow at t", v=""},
  {k="r", lab="r  rate (decimal)", v=""},
  {k="t", lab="t  periods", v=""},
}

local function calc(V)
  local p
  if V.cf and V.r and V.t then p = V.cf / (1 + V.r)^V.t end
  return {{"PV", fmt(p)}}
end

--@include shared/form_standard.lua
