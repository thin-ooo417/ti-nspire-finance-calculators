local TITLE = "PV tax shield (perp/finite)"
local FORMULA = "perp: D T;  T-yr: T rD D x AF(rD,T)"

local fields = {
  {k="d", lab="D  debt value", v=""},
  {k="tau", lab="T  tax rate (decimal)", v=""},
  {k="rd", lab="rD (only if finite)", v=""},
  {k="t", lab="years (blank = perp)", v=""},
}

local function calc(V)
  local out = {}
  if V.d and V.tau then
    out[#out + 1] = {"Shield if perpetual", fmt(V.d * V.tau)}
    if V.t and V.rd then
      local af
      if V.rd == 0 then af = V.t
      else af = (1 - 1 / (1 + V.rd) ^ V.t) / V.rd end
      out[#out + 1] = {"Shield for T years", fmt(V.tau * V.rd * V.d * af)}
    elseif V.t and not V.rd then
      out[#out + 1] = {"!", "Finite case needs rD."}
    end
  end
  return out
end

--@include shared/form_standard.lua
