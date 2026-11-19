local TITLE = "Real vs nominal (solve blank)"
local FORMULA = "1 + rnom = (1 + rreal)(1 + I)"

local fields = {
  {k="rn", lab="rnom  nominal (decimal)", v=""},
  {k="rr", lab="rreal  real (decimal)", v=""},
  {k="inf", lab="I  inflation (decimal)", v=""},
}

local function calc(V)
  local n, re, i = V.rn, V.rr, V.inf
  local cnt = (n and 1 or 0) + (re and 1 or 0) + (i and 1 or 0)
  if cnt < 2 then return {{"!", "Enter any two."}} end
  if n == nil and re and i then n = (1 + re) * (1 + i) - 1 end
  if re == nil and n and i and 1 + i ~= 0 then re = (1 + n) / (1 + i) - 1 end
  if i == nil and n and re and 1 + re ~= 0 then i = (1 + n) / (1 + re) - 1 end
  return {{"rnom", pct(n)}, {"rreal", pct(re)}, {"I  inflation", pct(i)}}
end

--@include shared/form_standard.lua
