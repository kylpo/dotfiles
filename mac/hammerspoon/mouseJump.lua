local mouseJump = {}

--[ Screen Jumps ]-----------------------------------------------------------
function mouseJump.toCenter()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

function mouseJump.toTopLeft()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

function mouseJump.toTopRight()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.w
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

function mouseJump.toBottomRight()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.w
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

function mouseJump.toBottomLeft()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

--[ Window Jumps ]------------------------------------------------------------
function mouseJump.toCenterOfWindow()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

function mouseJump.toTopLeftOfWindow()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

function mouseJump.toTopRightOfWindow()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.x + rect.w
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

function mouseJump.toBottomRightOfWindow()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.x + rect.w
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

function mouseJump.toBottomLeftOfWindow()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end


return mouseJump