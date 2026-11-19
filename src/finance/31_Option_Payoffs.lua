local TITLE = "Option payoff AND profit"
local FORMULA = "profit = payoff - premium"

local fields = {
  {k="s", lab="S  price at expiry", v=""},
  {k="k", lab="K  exercise price", v=""},
  {k="cp", lab="call premium", v="", d=0},
  {k="pp", lab="put premium", v="", d=0},
}

local function calc(V)
  local out = {}
  if V.s and V.k then
    local c = math.max(V.s - V.k, 0)
    local p = math.max(V.k - V.s, 0)
    out[1] = {"Call payoff", fmt(c)}
    out[2] = {"Call PROFIT", fmt(c - (V.cp or 0))}
    out[3] = {"Put payoff", fmt(p)}
    out[4] = {"Put PROFIT", fmt(p - (V.pp or 0))}
    out[5] = {"Straddle profit", fmt(c + p - (V.cp or 0) - (V.pp or 0))}
  end
  return out
end

--@include shared/form_standard.lua
