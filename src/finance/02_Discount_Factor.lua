local TITLE = "Discount factor"
local FORMULA = "DF = 1/(1+r)^t"

local fields = {
  {k="r", lab="r  rate/period (decimal)", v=""},
  {k="t", lab="t  periods", v=""},
}

local function calc(V)
  local d
  if V.r and V.t then d = 1 / (1 + V.r)^V.t end
  return {{"DF", fmt(d)}}
end

--@include shared/form_standard.lua
