local TITLE = "Risk decomp (solve blank)"
local FORMULA = "si^2 = b^2 sM^2 + idio var"

local fields = {
  {k="si", lab="si  sd of stock", v=""},
  {k="b", lab="beta", v=""},
  {k="sm", lab="sM  sd of market", v=""},
  {k="iv", lab="idio VARIANCE (opt)", v=""},
  {k="isd", lab="idio SD (opt)", v=""},
}

local function calc(V)
  local si, b, sm = V.si, V.b, V.sm
  local id = V.iv or (V.isd and V.isd ^ 2)
  if id == nil and si and b and sm then id = si ^ 2 - b ^ 2 * sm ^ 2 end
  if si == nil and b and sm and id then
    local v = b ^ 2 * sm ^ 2 + id
    if v >= 0 then si = math.sqrt(v) end
  end
  if b == nil and si and sm and id and sm ~= 0 then
    local v = (si ^ 2 - id) / sm ^ 2
    if v >= 0 then b = math.sqrt(v) end
  end
  if sm == nil and si and b and id and b ~= 0 then
    local v = (si ^ 2 - id) / b ^ 2
    if v >= 0 then sm = math.sqrt(v) end
  end
  local out = {{"si  total sd", fmt(si)}, {"beta (+/-)", fmt(b)},
               {"sM", fmt(sm)}, {"idio var", fmt(id)},
               {"idio sd", fmt(id and id >= 0 and math.sqrt(id) or nil)}}
  if id and id < 0 then out[#out + 1] = {"!", "idio var < 0: check inputs."} end
  if b and V.b == nil then out[#out + 1] = {"!", "beta from sqrt: sign unknown."} end
  return out
end

--@include shared/form_standard.lua
