-- dwg.frame()            : draw a frame
-- dwg.square()           : draw a square
-- dwg.cls()              : clear screen
-- dwg.setCol()           : set background and foreground color
-- dwg.text()
-- dwg.button()
-- dwg.debug1()
-- dwg.line()
 
dwg = {}
local component = require("component")
local gpu = component.gpu
local colors = { blue = 0x4286F4, purple = 0xB673d6, red = 0xC14141, green = 0xDA841, black = 0x000000, white = 0xFFFFFF, grey = 0x47494C, lightGrey = 0xBBBBBB}
 
 
 
-- ==============================================
function dwg.frame(xs, ys, w, h, col)
  storeBckCol = gpu.getBackground()
  gpu.setBackground(colors[col])
  gpu.fill(xs, ys, w, 1, " ")
  gpu.fill(xs, ys+h, w, 1, " ")
  gpu.fill(xs, ys, 1, h, " ")
  gpu.fill(xs + w, ys, 1, h+1, " ")
  gpu.setBackground(storeBckCol)
end
 
-- ===============================================
function dwg.square(xs, ys, w, h, col)
  storeBckCol = gpu.getBackground()
  gpu.setBackground(colors[col])
  gpu.fill(xs, ys, w, h, " ")
  gpu.setBackground(storeBckCol)
end
 
-- ==============================================
function dwg.setCol(bCol, fCol)
  gpu.setBackground(colors[bCol])
  gpu.setForeground(colors[fCol])
end
 
 
-- ==============================================
function dwg.cls()
  gpu.fill(1,1,160,50, " ")
end
 
-- ==============================================
function dwg.button(x, y, x2, y2, bColor, fColor, bText)
  gpu.setBackground(bColor)
  gpu.setForeground(fColor)
  gpu.fill(x, y, x2, y2, " ")
  gpu.set(x, y, bText)
end
 
 
-- ===============================================
function dwg.text(x, y, bColor, fColor, text)
  gpu.setBackground(colors[bColor])
  gpu.setForeground(colors[fColor])
  gpu.set(x, y, text)
end
 
 
dwg.debug1 = function(x, y)
  gpu.set(1, 50, ("Debug -- Coords = x: " .. x .. " y: " .. y .. " "))
end
