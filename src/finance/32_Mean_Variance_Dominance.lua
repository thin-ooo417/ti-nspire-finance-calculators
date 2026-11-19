local TITLE = "Mean-variance criterion"
local FORMULA = "P beats A if E(rP)>=E(rA) and σP<=σA"

local fields = {
  {k="mp", lab="E(rP)  portfolio P", v=""},
  {k="sp", lab="σP  std dev of P", v=""},
  {k="ma", lab="E(rA)  portfolio A", v=""},
  {k="sa", lab="σA  std dev of A", v=""},
}

local function calc(V)
  local verdict
  if V.mp and V.sp and V.ma and V.sa then
    local pBeats = (V.mp >= V.ma) and (V.sp <= V.sa) and (V.mp > V.ma or V.sp < V.sa)
    local aBeats = (V.ma >= V.mp) and (V.sa <= V.sp) and (V.ma > V.mp or V.sa < V.sp)
    if pBeats then
      verdict = "P dominates A"
    elseif aBeats then
      verdict = "A dominates P"
    elseif V.mp == V.ma and V.sp == V.sa then
      verdict = "identical"
    else
      verdict = "neither dominates"
    end
  end
  local dmu, dsd
  if V.mp and V.ma then dmu = V.mp - V.ma end
  if V.sp and V.sa then dsd = V.sp - V.sa end
  local out = {{"E(rP) - E(rA)", fmt(dmu)}, {"σP - σA", fmt(dsd)}}
  if verdict then out[#out + 1] = {"!", verdict} end
  if verdict == "neither dominates" then
    out[#out + 1] = {"!", "higher return but higher risk"}
  end
  return out
end

--@include shared/form_standard.lua
