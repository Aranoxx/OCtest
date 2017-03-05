-- number = {}
 
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
 
--print(round(1023.4345,0 ))
