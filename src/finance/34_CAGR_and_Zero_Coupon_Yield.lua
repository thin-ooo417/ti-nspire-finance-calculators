local TITLE = "CAGR / zero-coupon YTM"
local FORMULA = "F = P(1+r)^T  (solve any one)"

local fields = {
  {k="p", lab="P  value today", v=""},
  {k="f", lab="F  future value", v=""},
  {k="t", lab="T  periods", v=""},
  {k="r", lab="r  rate (or blank)", v=""},
}

local function calc(V)
  local p, f, t, r = V.p, V.f, V.t, V.r
  if r == nil and p and f and t and t ~= 0 and p ~= 0 and f / p > 0 then
    r = (f / p) ^ (1 / t) - 1
  elseif f == nil and p and r and t then
    f = p * (1 + r) ^ t
  elseif p == nil and f and r and t then
    p = f / (1 + r) ^ t
  elseif t == nil and p and f and r and p ~= 0 and f / p > 0
         and 1 + r > 0 and r ~= 0 then
    t = math.log(f / p) / math.log(1 + r)
  end
  local out = {{"r per period", pct(r)}, {"P", fmt(p)},
               {"F", fmt(f)}, {"T", fmt(t)}}
  if r and p then out[#out + 1] = {"Value in 1 period", fmt(p * (1 + r))} end
  return out
end

--@include shared/form_standard.lua
