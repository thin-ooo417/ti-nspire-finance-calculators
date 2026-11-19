local TITLE = "Portfolio (expected) return"
local FORMULA = "rP = x1 r1 + ... + x4 r4"

local fields = {
  {k="x1", lab="x1  weight", v="", d=0},
  {k="r1", lab="r1  return (decimal)", v="", d=0},
  {k="x2", lab="x2", v="", d=0},
  {k="r2", lab="r2", v="", d=0},
  {k="x3", lab="x3", v="", d=0},
  {k="r3", lab="r3", v="", d=0},
  {k="x4", lab="x4", v="", d=0},
  {k="r4", lab="r4", v="", d=0},
}

local function calc(V)
  local sx = V.x1 + V.x2 + V.x3 + V.x4
  local rp = V.x1*V.r1 + V.x2*V.r2 + V.x3*V.r3 + V.x4*V.r4
  local out = {{"Σ x (must be 1)", fmt(sx)}, {"rP", fmt(rp)}, {"rP  as %", pct(rp)}}
  if math.abs(sx - 1) > 1e-9 then
    out[#out + 1] = {"!", "Weights do not sum to 1."}
  end
  return out
end

--@include shared/form_standard.lua
