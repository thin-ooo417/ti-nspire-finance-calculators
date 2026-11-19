local TITLE = "Mix market + risk-free"
local FORMULA = "E(r) = rf + x(muM - rf); sd = x sdM"

local fields = {
  {k="rf", lab="rf  (decimal)", v=""},
  {k="mm", lab="E(rM)  (decimal)", v=""},
  {k="sm", lab="sdM  (or blank)", v=""},
  {k="sh", lab="Sharpe mkt (or blank)", v=""},
  {k="xm", lab="x  weight in mkt", v=""},
  {k="mt", lab="or target E(r)", v=""},
}

local function calc(V)
  local sm = V.sm
  if sm == nil and V.sh and V.mm and V.rf and V.sh ~= 0 then
    sm = (V.mm - V.rf) / V.sh
  end
  local x, er = V.xm, nil
  if x == nil and V.mt and V.mm and V.rf and V.mm - V.rf ~= 0 then
    x = (V.mt - V.rf) / (V.mm - V.rf)
  end
  if x and V.mm and V.rf then er = V.rf + x * (V.mm - V.rf) end
  local sd = x and sm and math.abs(x) * sm
  return {{"x in market used", fmt(x)}, {"sdM used", pct(sm)},
          {"E(r) portfolio", pct(er)}, {"sd portfolio", pct(sd)}}
end

--@include shared/form_standard.lua
