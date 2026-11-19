local TITLE = "Option strategy (3 legs)"
local FORMULA = "leg: 1=call 2=put 3=stock; q<0 short"

local fields = {
  {k="st", lab="ST  price at expiry", v=""},
  {k="t1", lab="L1 type 1c 2p 3stk", v=""},
  {k="q1", lab="L1 qty (- = short)", v="", d=1},
  {k="k1", lab="L1 K / entry price", v=""},
  {k="c1", lab="L1 premium", v="", d=0},
  {k="t2", lab="L2 type (blank off)", v=""},
  {k="q2", lab="L2 qty", v="", d=1},
  {k="k2", lab="L2 K / entry", v=""},
  {k="c2", lab="L2 premium", v="", d=0},
  {k="t3", lab="L3 type (blank off)", v=""},
  {k="q3", lab="L3 qty", v="", d=1},
  {k="k3", lab="L3 K / entry", v=""},
  {k="c3", lab="L3 premium", v="", d=0},
}

local function calc(V)
  local legs, ks, slope = {}, {}, 0
  local out = {}
  for j = 1, 3 do
    local t, q, k, c = V["t" .. j], V["q" .. j], V["k" .. j], V["c" .. j]
    if t then
      if t ~= 1 and t ~= 2 and t ~= 3 then
        -- any other number used to be priced as stock without saying so
        out[#out + 1] = {"!", "Leg " .. j .. " type must be 1, 2 or 3."}
      elseif k == nil then
        out[#out + 1] = {"!", "Leg " .. j .. " needs K/entry."}
      else
        legs[#legs + 1] = {t = t, q = q, k = k, c = c}
        if t == 1 or t == 2 then ks[#ks + 1] = k end
        if t == 1 or t == 3 then slope = slope + q end
      end
    end
  end
  if #legs == 0 then
    if #out > 0 then return out end          -- say what is wrong with the leg entered
    return {{"!", "Set leg 1 type, K."}}
  end
  local function prof(S)
    local p = 0
    for j = 1, #legs do
      local L = legs[j]
      if L.t == 1 then p = p + L.q * (math.max(S - L.k, 0) - L.c)
      elseif L.t == 2 then p = p + L.q * (math.max(L.k - S, 0) - L.c)
      else p = p + L.q * (S - L.k) end
    end
    return p
  end
  if V.st then out[#out + 1] = {"Profit at ST", fmt(prof(V.st))} end
  out[#out + 1] = {"Profit at S=0", fmt(prof(0))}
  table.sort(ks)
  local last
  for j = 1, #ks do
    if ks[j] ~= last then
      out[#out + 1] = {"at S=" .. string.format("%g", ks[j]), fmt(prof(ks[j]))}
      last = ks[j]
    end
  end
  out[#out + 1] = {"Slope for big S", fmt(slope)}
  return out
end

--@include shared/form_standard.lua
