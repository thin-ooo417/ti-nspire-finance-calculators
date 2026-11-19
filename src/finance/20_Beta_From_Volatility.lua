local TITLE = "Beta via vol (solve blank)"
local FORMULA = "b = (si/sM) rho = cov/sM^2"

local fields = {
  {k="b", lab="beta  (or blank)", v=""},
  {k="si", lab="si  sd of stock", v=""},
  {k="rho", lab="rho  correlation", v=""},
  {k="sp", lab="sM  sd mkt/portfolio", v=""},
  {k="cov", lab="cov (optional route)", v=""},
}

local function calc(V)
  local b, si, rho, sp = V.b, V.si, V.rho, V.sp
  if b == nil then
    if si and rho and sp and sp ~= 0 then b = si * rho / sp
    elseif V.cov and sp and sp ~= 0 then b = V.cov / sp ^ 2 end
  elseif sp == nil and si and rho and b ~= 0 then sp = si * rho / b
  elseif si == nil and sp and rho and rho ~= 0 then si = b * sp / rho
  elseif rho == nil and si and sp and si ~= 0 then rho = b * sp / si
  end
  local out = {{"beta", fmt(b)}, {"si", fmt(si)},
               {"rho", fmt(rho)}, {"sM", fmt(sp)}}
  if rho and (rho > 1 or rho < -1) then out[#out + 1] = {"!", "rho outside [-1, 1]."} end
  return out
end

--@include shared/form_standard.lua
