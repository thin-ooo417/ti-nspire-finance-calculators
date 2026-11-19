local TITLE = "FCF accounting (solve blank)"
local FORMULA = "FCF = EBIT - Tax + Depr - CapEx - ChWC"

local fields = {
  {k="eb", lab="EBIT", v=""},
  {k="tx", lab="Tax paid", v="", d=0},
  {k="dep", lab="Depreciation", v="", d=0},
  {k="cx", lab="CapEx", v="", d=0},
  {k="wc", lab="ChWC  net WC invest", v=""},
  {k="fcf", lab="FCF  (blank to solve)", v=""},
}

local function calc(V)
  -- EBIT and either ChWC or FCF may be the single unknown
  local eb, wc, f = V.eb, V.wc, V.fcf
  local out = {}
  if f == nil and eb and wc then
    f = eb - V.tx + V.dep - V.cx - wc
  elseif wc == nil and eb and f then
    wc = eb - V.tx + V.dep - V.cx - f
  elseif eb == nil and wc and f then
    eb = f + V.tx - V.dep + V.cx + wc
  end
  out[1] = {"FCF", fmt(f)}
  out[2] = {"ChWC", fmt(wc)}
  out[3] = {"EBIT", fmt(eb)}
  if f == nil and wc == nil then out[#out + 1] = {"!", "Leave one blank to solve."} end
  return out
end

--@include shared/form_standard.lua
