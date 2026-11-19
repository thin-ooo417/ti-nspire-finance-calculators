local TITLE = "CAPM chain: b, E(r), P1, SR, a"
local FORMULA = "E(r) = rf + b(muM - rf)"

local fields = {
  {k="b", lab="beta (blank = derive)", v=""},
  {k="si", lab="si  sd stock (opt)", v=""},
  {k="rho", lab="rho  corr (opt)", v=""},
  {k="sm", lab="sM  sd market (opt)", v=""},
  {k="rf", lab="rf  risk-free (dec)", v=""},
  {k="mm", lab="E(rM)  (or blank)", v=""},
  {k="mp", lab="MRP  (or blank)", v=""},
  {k="p0", lab="P0  price now (opt)", v=""},
  {k="ri", lab="own E(r) for alpha", v=""},
}

local function calc(V)
  local b = V.b
  if b == nil and V.si and V.rho and V.sm and V.sm ~= 0 then
    b = V.si * V.rho / V.sm
  end
  local mrp = V.mp or (V.mm and V.rf and V.mm - V.rf)
  local er
  if b and mrp and V.rf then er = V.rf + b * mrp end
  local out = {{"beta used", fmt(b)}, {"MRP used", pct(mrp)},
               {"E(r) CAPM", pct(er)}}
  if er and V.p0 then out[#out + 1] = {"E(P) in 1 yr", fmt(V.p0 * (1 + er))} end
  if er and V.si and V.si ~= 0 then
    out[#out + 1] = {"Sharpe (CAPM E(r))", fmt((er - V.rf) / V.si)}
  end
  if er and V.ri then out[#out + 1] = {"alpha = ri - E(r)", pct(V.ri - er)} end
  if V.rho and (V.rho > 1 or V.rho < -1) then
    out[#out + 1] = {"!", "rho outside [-1, 1]."}
  end
  return out
end

--@include shared/form_standard.lua
