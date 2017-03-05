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
  n.mfsuEnergyID1 = 0
  n.mfsuEnergyID2 = 0
  n.mfsuEnergyID3 = 0
  n.mfsuEnergyID4 = 0
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
    dwg.text(m.xPos+46, m.yPos+a, "black", "white", "Level:     MEU")
    b = b + 1
  end
end
 
function genBatAdd()
  mfsuBat1.mfsuAddID1 = component.get("dedf") -- mfsu 1.1
  mfsuBat1.mfsuAddID2 = component.get("cf23") -- mfsu 1.2
  mfsuBat1.mfsuAddID3 = component.get("61cb") -- mfsu 1.3
  mfsuBat1.mfsuAddID4 = component.get("0f2a") -- mfsu 1.4
  mfsuBat1.redsAddID1 = component.get("39b6") -- redstone IO

  mfsuBat2.mfsuAddID1 = component.get("a519") -- mfsu 2.1
  mfsuBat2.mfsuAddID2 = component.get("87da") -- mfsu 2.2
  mfsuBat2.mfsuAddID3 = component.get("63ab") -- mfsu 2.3
  mfsuBat2.mfsuAddID4 = component.get("2e89") -- mfsu 2.4
  mfsuBat2.redsAddID1 = component.get("456a") -- redstone IO

  mfsuBat3.mfsuAddID1 = component.get("ff0c") -- mfsu 1.1
  mfsuBat3.mfsuAddID2 = component.get("a814") -- mfsu 1.2
  mfsuBat3.mfsuAddID3 = component.get("c9a8") -- mfsu 1.3
  mfsuBat3.mfsuAddID4 = component.get("4a56") -- mfsu 1.4
  mfsuBat3.redsAddID1 = component.get("f3aa") -- redstone IO
end
 
function getSignalInput(ID)
  if ID == 1 then
    m = mfsuBat1
  elseif ID == 2 then
    m = mfsuBat2
  elseif ID == 3 then
    m = mfsuBat3
  end
  e1 = tostring(number.round(component.proxy(m.mfsuAddID1).getEnergy()/1000000), 2)
  e2 = tostring(number.round(component.proxy(m.mfsuAddID2).getEnergy()/1000000), 2)
  e3 = tostring(number.round(component.proxy(m.mfsuAddID3).getEnergy()/1000000), 2)
  e4 = tostring(number.round(component.proxy(m.mfsuAddID4).getEnergy()/1000000), 2)
  dwg.text(m.xPos+52, m.yPos+2, "black", "white", e1)
  dwg.text(m.xPos+52, m.yPos+4, "black", "white", e2)
  dwg.text(m.xPos+52, m.yPos+6, "black", "white", e3)
  dwg.text(m.xPos+52, m.yPos+8, "black", "white", e4)
end


function updateMfsu(ID)
  if ID == 1 then
    m = mfsuBat1
  elseif ID == 2 then
    m = mfsuBat2
  elseif ID == 3 then
    m = mfsuBat3
  end
  e1last = m.mfsuEnergyID1
  e1pres = tostring(number.round(component.proxy(m.mfsuAddID1).getEnergy()/1000000), 2)
  e2last = m.mfsuEnergyID2
  e2pres = tostring(number.round(component.proxy(m.mfsuAddID2).getEnergy()/1000000), 2)
  e3last = m.mfsuEnergyID3
  e3pres = tostring(number.round(component.proxy(m.mfsuAddID3).getEnergy()/1000000), 2)
  e4last = m.mfsuEnergyID4
  e4pres = tostring(number.round(component.proxy(m.mfsuAddID4).getEnergy()/1000000), 2)

 

  e1diff = e1 - m.mfsuStatPID1
 if m.
--]] 

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
getSignalInput(2)
getSignalInput(3)
 
while true do
  os.sleep(1)
--  debug(1)
end
  
