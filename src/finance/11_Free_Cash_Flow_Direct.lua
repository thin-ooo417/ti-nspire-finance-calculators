local TITLE = "Free cash flow (direct)"
local FORMULA = "FCF = TO-FC-LC-RM-CapEx-Tax-ChWC"

local fields = {
  {k="to", lab="TO  turnover", v="", d=0},
  {k="fc", lab="FC  fixed costs", v="", d=0},
  {k="lc", lab="LC  labour costs", v="", d=0},
  {k="rm", lab="RM  raw materials", v="", d=0},
  {k="cx", lab="CapEx", v="", d=0},
  {k="tax", lab="Tax paid", v="", d=0},
  {k="wc", lab="ChWC  chg working cap", v="", d=0},
}

local function calc(V)
  local f = V.to - V.fc - V.lc - V.rm - V.cx - V.tax - V.wc
  return {{"FCF", fmt(f)}}
end

--@include shared/form_standard.lua
