local TITLE = "Expected return, var, SD"
local FORMULA = "μ = Σ pi ri;  σ² = Σ pi(ri-μ)²"

local fields = {
  {k="p1", lab="p1  probability", v="", d=0},
  {k="r1", lab="r1  return (decimal)", v="", d=0},
  {k="p2", lab="p2", v="", d=0},
  {k="r2", lab="r2", v="", d=0},
  {k="p3", lab="p3", v="", d=0},
  {k="r3", lab="r3", v="", d=0},
  {k="p4", lab="p4", v="", d=0},
  {k="r4", lab="r4", v="", d=0},
}

local function calc(V)
  local sp = V.p1 + V.p2 + V.p3 + V.p4
  local mu, var, sd
  if sp > 0 then
    mu = V.p1*V.r1 + V.p2*V.r2 + V.p3*V.r3 + V.p4*V.r4
    var = V.p1*(V.r1-mu)^2 + V.p2*(V.r2-mu)^2 + V.p3*(V.r3-mu)^2 + V.p4*(V.r4-mu)^2
    if var >= 0 then sd = math.sqrt(var) end
  end
  local out = {{"Σ p (must be 1)", fmt(sp)},
               {"E(r) = μ", fmt(mu)},
               {"Variance σ²", fmt(var)},
               {"Std dev σ", fmt(sd)}}
  if math.abs(sp - 1) > 1e-9 then
    out[#out + 1] = {"!", "Probabilities do not sum to 1."}
  end
  return out
end

--@include shared/form_standard.lua
