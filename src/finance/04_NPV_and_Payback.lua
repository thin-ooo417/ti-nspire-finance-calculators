local TITLE = "NPV (+growth TV, payback)"
local FORMULA = "NPV = SUM CFt/(1+r)^t; last CF starts g-perp"

local fields = {
  {k="r", lab="r  rate (decimal)", v=""},
  {k="g", lab="g  growth after last CF", v=""},
  {k="c0", lab="CF0  cashflow t=0", v=""},
  {k="c1", lab="CF1", v=""},
  {k="c2", lab="CF2", v=""},
  {k="c3", lab="CF3", v=""},
  {k="c4", lab="CF4", v=""},
  {k="c5", lab="CF5", v=""},
  {k="c6", lab="CF6", v=""},
}

local function calc(V)
  local cfs = {V.c0, V.c1, V.c2, V.c3, V.c4, V.c5, V.c6}
  local T = 0
  for i = 1, 7 do if cfs[i] ~= nil then T = i end end
  local out = {}
  if T == 0 then return {{"!", "Enter cashflows."}} end
  -- undiscounted payback (blank CFs in the middle count as 0)
  local cum = cfs[1] or 0
  local pb = nil
  if cum >= 0 then pb = 0 end
  for i = 2, T do
    local c = cfs[i] or 0
    if pb == nil and cum + c >= 0 then
      if c ~= 0 then pb = (i - 2) + (-cum) / c else pb = i - 1 end
    end
    cum = cum + c
  end
  if V.r then
    local npv = 0
    for i = 1, T do npv = npv + (cfs[i] or 0) / (1 + V.r) ^ (i - 1) end
    out[#out + 1] = {"NPV (listed CFs)", fmt(npv)}
    if V.g and T >= 2 then
      -- convention: the LAST listed CF is the first payment of the
      -- growing perpetuity, so value it at the prior year and re-discount.
      local last = cfs[T] or 0
      local y = T - 1
      if V.r - V.g ~= 0 then
        local tv = (last / (V.r - V.g)) / (1 + V.r) ^ (y - 1)
        local plain = last / (1 + V.r) ^ y
        out[#out + 1] = {"NPV incl growth TV", fmt(npv - plain + tv)}
      end
      if V.g >= V.r then out[#out + 1] = {"!", "g >= r: TV invalid."} end
    end
  else
    out[#out + 1] = {"NPV", fmt(nil)}
  end
  out[#out + 1] = {"Payback (yrs)", pb and fmt(pb) or "> last yr"}
  return out
end

--@include shared/form_standard.lua
