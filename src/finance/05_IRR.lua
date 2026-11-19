local TITLE = "Internal rate of return"
local FORMULA = "Σ CFt/(1+IRR)^t = 0   (t = 0..6)"

local fields = {
  {k="c0", lab="CF0  cashflow t=0", v="", d=0},
  {k="c1", lab="CF1  cashflow t=1", v="", d=0},
  {k="c2", lab="CF2  cashflow t=2", v="", d=0},
  {k="c3", lab="CF3  cashflow t=3", v="", d=0},
  {k="c4", lab="CF4  cashflow t=4", v="", d=0},
  {k="c5", lab="CF5  cashflow t=5", v="", d=0},
  {k="c6", lab="CF6  cashflow t=6", v="", d=0},
}

local function calc(V)
  -- fast precheck: an IRR can only exist if inflows and outflows both appear
  local pos, neg = false, false
  for i = 0, 6 do
    local c = V["c" .. i]
    if c > 0 then pos = true elseif c < 0 then neg = true end
  end
  if not (pos and neg) then
    return {{"IRR (decimal)", "-"}, {"IRR  as %", "-"},
            {"!", "Needs both + and - cashflows."}}
  end
  local function g(x)
    local s = 0
    for i = 0, 6 do s = s + V["c" .. i] / (1 + x)^i end
    return s
  end
  local roots = {}
  local x = -0.99
  local fx = g(x)
  while x < 10 and #roots < 3 do
    local step = 0.02
    if x >= 3 then step = 0.25 end
    local x2 = x + step
    local f2 = g(x2)
    if fx == 0 then
      roots[#roots + 1] = x
    elseif fx * f2 < 0 then
      local a, b, fa = x, x2, fx
      for i = 1, 60 do
        local m = (a + b) / 2
        local fm = g(m)
        if fa * fm <= 0 then b = m else a = m fa = fm end
      end
      roots[#roots + 1] = (a + b) / 2
    end
    x = x2
    fx = f2
  end
  local r = roots[1]
  local out = {{"IRR (decimal)", fmt(r)}, {"IRR  as %", pct(r)}}
  if #roots > 1 then
    out[#out + 1] = {"!", "Multiple IRRs exist (" .. #roots .. ") - NPV rule safer."}
  elseif r == nil then
    out[#out + 1] = {"!", "No IRR found in -99%..1000%."}
  end
  return out
end

--@include shared/form_standard.lua
