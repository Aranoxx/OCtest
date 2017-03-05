component = require("component")
require("dwg")
require("number")
 
package.loaded.number = nil
 
local colors = { blue = 0x4286F4, purple = 0xB673d6, red = 0xC14141, green = 0xDA841, black = 0x000000, white = 0xFFFFFF, grey = 0x47494C, lightGrey = 0xBBBBBB}
 
 
-- ======================== SETUP component addresses
 
mfsuBatTable = {}
function mfsuBatTable(ID, x, y)    
  n = {}  
  n.batID = ID  
  n.mfsuID1 = ID * 100 + 1
  n.mfsuID2 = ID * 100 + 2
  n.mfsuID3 = ID * 100 + 3
  n.mfsuID4 = ID * 100 + 4
  n.xPos =  x
  n.yPos =  y
  n.mfsuStatPID1 = 4
  n.mfsuStatPID2 = 4
  n.mfsuStatPID3 = 4
  n.mfsuStatPID4 = 4
  n.mfsuStatCID1 = 4
  n.mfsuStatCID2 = 4
  n.mfsuStatCID3 = 4
  n.mfsuStatCID4 = 4
  n.mfsuAddID1 = ""
  n.mfsuAddID2 = ""
  n.mfsuAddID3 = ""
  n.mfsuAddID4 = ""
  n.redsAddID1 = ""
  return n  
end    
 
-- =============================== DRAW SCREEN
function dwgMfsuBat(ID)
  if ID == 1 then
    m = mfsuBat1
  elseif ID == 2 then
    m = mfsuBat2
  elseif ID == 3 then
    m = mfsuBat3
  end
  dwg.square(m.xPos-19, m.yPos+5, 36, 1, "grey")
  dwg.square(m.xPos-1, m.yPos+1, 5, 1, "grey")
  dwg.square(m.xPos-1, m.yPos+9, 5, 1, "grey")
  dwg.square(m.xPos-2, m.yPos+1, 1, 9, "grey")
  dwg.square(m.xPos+4, m.yPos+1, 1, 9, "grey")
 
  dwg.square(m.xPos, m.yPos, 3, 3, "white")
  dwg.square(m.xPos, m.yPos+4, 3, 3, "red")
  dwg.square(m.xPos, m.yPos+8, 3, 3, "white")
  dwg.square(m.xPos+6, m.yPos+4, 3, 3, "white")
 
  dwg.text(m.xPos, m.yPos-1, "black", "white", m.batID..".1")
  dwg.text(m.xPos, m.yPos+3, "black", "white", m.batID..".2")
  dwg.text(m.xPos+6, m.yPos+3, "black", "white", m.batID..".4")
  dwg.text(m.xPos, m.yPos+7, "black", "white", m.batID..".3")
  dwg.text(m.xPos+21, m.yPos, "black", "white", "MFSU Battery "..ID)
 
  for a = 2,8,2 do
    b = 1
    dwg.square(m.xPos+25, m.yPos+a, 20, 1, "white")
    dwg.text(m.xPos+21, m.yPos+a, "black", "white", m.batID .."."..b..":")
    dwg.text(m.xPos+45, m.yPos+a, "black", "white", "Level:     MEU")
    b = b + 1
  end
end
 
function genBatAdd()
  mfsuBat1.mfsuAddID1 = component.get("dedf") -- mfsu 1.1
  mfsuBat1.mfsuAddID2 = component.get("cf23") -- mfsu 1.2
  mfsuBat1.mfsuAddID3 = component.get("61cb") -- mfsu 1.3
  mfsuBat1.mfsuAddID4 = component.get("0f2a") -- mfsu 1.4
  mfsuBat1.redsAddID1 = component.get("39b6") -- redstone IO
end
 
 
 
 
function getSignalInput(ID)
  if ID == 1 then
    m = mfsuBat1
  elseif ID == 2 then
    m = mfsuBat2
  elseif ID == 3 then
    m = mfsuBat3
  end
  e1 = tostring(number.round(component.proxy(m.mfsuAddID1).getEnergy()/1000000), -2)
--  e2 = component.proxy(component.get(mfsu12add)).getEnergy()
--  e3 = component.proxy(component.get(mfsu13add)).getEnergy()
--  e4 = component.proxy(component.get(mfsu14add)).getEnergy()
  dwg.text(m.xPos+52, m.yPos+2, "black", "white", e1)
 
end
 
function debug(ID)  
  m = mfsuBat1
  print("MFSU ID-"..(m.batID).." // ".. "Energy: ".. component.proxy(m.mfsuAddID2).getEnergy())
end
 
 
-- ================ Setup tables
mfsuBat1 = mfsuBatTable(1, 62, 2)
mfsuBat2 = mfsuBatTable(2, 62, 15)
mfsuBat3 = mfsuBatTable(3, 62, 28)
 
 
-- ================ Draw GUI
dwg.cls()
dwgMfsuBat(1)
dwgMfsuBat(2)
dwgMfsuBat(3)
 
genBatAdd()
getSignalInput(1)
 
while true do
  os.sleep(1)
--  debug(1)
end
 
 
 
 
--[[
for k,v in pairs(mfsuBat1) do print("mfsuBat1." .. k .. " ::: " .. v) end
print("=========")
for k,v in pairs(mfsuBat2) do print("mfsuBat2." .. k .. " ::: " .. v) end
print("=========")
for k,v in pairs(mfsuBat3) do print("mfsuBat3." .. k .. " ::: " .. v) end
--]]
