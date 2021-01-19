local switcher = require 'switcher'
local hotkey = require "hs.hotkey"

local tronCyan = {["hex"]="#6FC3DF"}
local tronOrange = {["hex"]="#DF740C"}
local focusColor = {["hex"]="#6FC3DF", ["alpha"]=0.8}

hs.window.animationDuration = 0
hs.application.enableSpotlightForNameSearches(true)

function dump(o)
  if type(o) == 'table' then
     local s = '{ '
     for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
     end
     return s .. '} '
  else
     return tostring(o)
  end
end

-----------------------------------------------------------------------
-- Modules 
-----------------------------------------------------------------------

--[ Spoons ]-----------------------------------------------------------
hs.loadSpoon("MicMute")
hs.loadSpoon("HoldToQuit")

---- Auto-Reload
hs.alert.show('Config loaded!')
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

---- MouseCircle
hs.loadSpoon("MouseCircle")
spoon.MouseCircle.color = tronOrange
-- spoon.MouseCircle:bindHotkeys({
--   show = { { "ctrl" }, "4" }
-- })

---- Clipboard
hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.paste_on_select = true
spoon.ClipboardTool:start()


---- MoveSpaces
-- hs.loadSpoon("MoveSpaces")
-- spoon.MoveSpaces:bindHotkeys({
--   ["space_left"] = { { "ctrl", "shift" }, "w" },
--   ["space_right"] = { { "ctrl", "shift" }, "y" }
-- })

-- local spaces = require("hs._asm.undocumented.spaces")
-- -- move current window to the space sp
-- function MoveWindowToSpace(sp)
--     local win = hs.window.focusedWindow()      -- current window
--     local uuid = win:screen():spacesUUID()     -- uuid for current screen
--     local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
--     spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
--     spaces.changeToSpace(spaceID)              -- follow window to new space
-- end
-- hs.hotkey.bind({ "ctrl", "shift" }, "w", "MOVE", function() MoveWindowToSpace(1) end)


--[ Switcher ]---------------------------------------------------------
switcher_space = switcher.new(
  hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{},
  {
    showTitles=false, -- disable text label over thumbnail
    showThumbnails=true, -- show app preview in thumbnail
    showSelectedThumbnail=false, -- disable large preview
    thumbnailSize = 256, -- double size of thumbnails (may big too big for laptop-mode?)
    highlightColor = focusColor
  }
)

--[ Caffeine ]---------------------------------------------------------
caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("AWAKE")
    else
        caffeine:setTitle("SLEEPY")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

-- if caffeine then
--     caffeine:setClickCallback(caffeineClicked)
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end

--[ Window Focus ]-----------------------------------------------------
-- enable overlay (only) for focus border
-- hs.window.highlight.ui.overlay=true
-- hs.window.highlight.ui.overlayColor = {0,0,0,0.001} 
-- hs.window.highlight.ui.frameWidth = 10
-- hs.window.highlight.start()

-- redraw() from https://github.com/jwkvam/hammerspoon-config/blob/master/init.lua
global_border = nil
allwindows = nil
borderAlpha = 0.8
borderColor = focusColor

function redrawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
      top_left = win:topLeft()
      size = win:size()
      if global_border ~= nil then
          global_border:delete()
      end
      global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
      global_border:setStrokeColor(borderColor)
      global_border:setAlpha(borderAlpha)
      global_border:setFill(false)
      global_border:setStrokeWidth(8)
      global_border:show()
  end
end

redrawBorder()
allwindows = hs.window.filter.new(nil)
allwindows:subscribe({
  hs.window.filter.windowCreated,
  hs.window.filter.windowFocused,
  hs.window.filter.windowMoved,
  hs.window.filter.windowUnfocused
}, redrawBorder)

function enableFocusBorder()
  borderAlpha = 0.8
  borderColor = focusColor
  global_border:setAlpha(borderAlpha)
  global_border:setStrokeColor(borderColor)
  -- redrawBorder()
  -- allwindows = hs.window.filter.new(nil)
  -- allwindows:subscribe({
  --   hs.window.filter.windowCreated,
  --   hs.window.filter.windowFocused,
  --   hs.window.filter.windowMoved,
  --   hs.window.filter.windowUnfocused
  -- }, redrawBorder)
end
-- enableFocusBorder()

function disableFocusBorder()
  borderAlpha = 0.4
  borderColor = tronOrange
  global_border:setAlpha(borderAlpha)
  global_border:setStrokeColor(borderColor)

  -- if allwindows ~= nil then
  --   allwindows:unsubscribe({
  --     hs.window.filter.windowCreated,
  --     hs.window.filter.windowFocused,
  --     hs.window.filter.windowMoved,
  --     hs.window.filter.windowUnfocused
  --   }, redrawBorder)
  --   allwindows = nil
  -- end

  -- if global_border ~= nil then
  --   global_border:delete()
  --   global_border = nil
  -- end
end

--[ Menubar Focus ]----------------------------------------------------
menubarIndicator = nil

function drawMenubarIndicator()
  if menubarIndicator == nil then

  -- hs.drawing.color.x11.red
  screens = hs.screen.allScreens()
  for i,screen in ipairs(screens) do
    local screeng = screen:fullFrame()
    local width = screeng.w
    height = (screen:frame().y - screeng.y)
    menubarIndicator = hs.drawing.rectangle(hs.geometry.rect(screeng.x+(width*(i-1)), screeng.y,
                                        width, height))
    -- c:setFillColor(hs.drawing.color.x11.orangeRed)
    -- menubarIndicator:setFillColor(tronOrange)
    menubarIndicator:setFillColor(focusColor)

    menubarIndicator:setFill(true)
    menubarIndicator:setAlpha(0.5)
    menubarIndicator:setLevel(hs.drawing.windowLevels.overlay)
    menubarIndicator:setStroke(false)
    menubarIndicator:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    menubarIndicator:show()
  end
end
end

function deleteMenubarIndicator()
  if menubarIndicator ~= nil then
    menubarIndicator:delete()
    menubarIndicator = nil
  end
end

--[ Mouse Mode ]------------------------------------------------------------
function disableMouse()  
  hs.hid.capslock.set(false)
  -- hs.hid.led.set("caps", false)
  -- disableMouseTimer = nil
  -- deleteMenubarIndicator()
  focusWindow()
  
  print("disableMouse()")

  -- local res = hs.hid.led.set("caps", false)
  -- print(res)

  -- if (hs.eventtap.checkKeyboardModifiers().capslock) then
  --   hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, true):post();
  --   hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, false):post();
  -- -- else
  -- --   drawMenubarIndicator()
  -- end
end

function enableMouse()
  hs.hid.capslock.set(true)
  print("enableMouse()")
  focusMouse()
 
  -- drawMenubarIndicator()
  -- hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, true):post();
  -- hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, false):post();
end

function focusMouse()
  drawMenubarIndicator()
  disableFocusBorder()  
end

function focusWindow()
  deleteMenubarIndicator()
  enableFocusBorder()
end

---- Enable/disable based on capslock
-- isLocked = hs.eventtap.checkKeyboardModifiers().capslock
capsEvent = hs.eventtap.new({
  hs.eventtap.event.types.flagsChanged
}, function(event)
  -- print("getFlags")
  -- print(dump(event:getFlags()))

  -- print("before")
  -- print(hs.eventtap.checkKeyboardModifiers().ctrl)
  

  -- print("getType")
  -- print(dump(event:getType()))

  local flags = event:getFlags()
  local modsBefore = hs.eventtap.checkKeyboardModifiers()

  if event:getKeyCode() == hs.keycodes.map["capslock"] then

  print("before")
  print(hs.eventtap.checkKeyboardModifiers().capslock)
  print("event")
  print(event:getKeyCode() == hs.keycodes.map["capslock"])

  -- print("getRawEventData")
  -- print(dump(event:getRawEventData()))
  
  if (modsBefore.capslock) then
    focusWindow()
  else
    focusMouse()
  end

    -- if not(isLocked) then
    -- -- spoon.MouseCircle:show()
    -- isLocked = true
    -- drawMenubarIndicator()
    -- else
    --   isLocked = false
    --   deleteMenubarIndicator()
      
    -- end
    -- isLocked = hs.hid.capslock.get()
    return false
  end

  -- show focussed window when CTRL held
  -- if flags.ctrl and modsBefore.ctrl == nil then
  --   focusWindow()
  --   print("CTRL focusWindow")
  --   return false
  -- elseif flags.ctrl == nil and modsBefore.ctrl then
  --   focusMouse()
  --   print("CTRL focusMouse")
  --   return false
  -- end

  -- -- show focussed window when CMD held
  -- if flags.cmd and modsBefore.cmd == nil then
  --   focusWindow()
  --   print("CMD focusWindow")
  --   return false
  -- elseif flags.cmd == nil and modsBefore.cmd then
  --   focusMouse()
  --   print("CMD focusMouse")
  --   return false
  -- end

  return false
end)
capsEvent:start()

---- Disable when entering lock screen
local pow = hs.caffeinate.watcher
pow.new(function(event)
  if event == pow.screensDidSleep
  or event == pow.systemWillSleep
  or event == pow.systemWillPowerOff
  or event == pow.sessionDidResignActive
  or event == pow.screensDidLock 
  then
    -- hardware disable
    hs.hid.capslock.set(false)

    -- if hs.eventtap.checkKeyboardModifiers().capslock then
    -- software disable (via key-up)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, false):post();
    -- end
  end
end):start()

---- Update menubar after logging in
wakeWatcher = hs.caffeinate.watcher
wakeWatcher.new(function(event)
  if event == pow.systemDidWake
  then
    -- isLocked = hs.eventtap.checkKeyboardModifiers().capslock
    if (hs.eventtap.checkKeyboardModifiers().capslock) then
      drawMenubarIndicator()
    else
      deleteMenubarIndicator()
    end
  end
end):start()

--[ Mouse Jumps ]------------------------------------------------------------
local function centerMouseInFocus()
  local window = hs.window.focusedWindow()
  local rect = window:frame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end

local function moveMouseToCenter()
  local screen = hs.mouse.getCurrentScreen()
  -- local nextScreen = screen:next()
  local rect = screen:fullFrame()
  local center = hs.geometry.rectMidPoint(rect)
  -- hs.mouse.setAbsolutePosition(center)
  hs.mouse.setRelativePosition(center, screen)
end

local function moveMouseToTopLeft()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

local function moveMouseToTopRight()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.w
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

local function moveMouseToBottomRight()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.x = rect.w
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

local function moveMouseToBottomLeft()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:fullFrame()
  rect.w = rect.w / 2
  rect.h = rect.h / 2
  rect.y = rect.h
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setRelativePosition(center, screen)
end

-----------------------------------------------------------------------
-- Bindings 
-----------------------------------------------------------------------

function bypassBind(binding, mods, keycode)
  binding:disable()
  hs.eventtap.keyStroke(mods, keycode)
  hs.timer.doAfter(0.1, function()
    binding:enable()
  end)
end

-- Now using Witch instead, since Switch would miss newly created windows
-- hs.hotkey.bind('ctrl','c', function()
--   switcher_space:next()
-- end)
-- hs.hotkey.bind('ctrl','r', function()
--   switcher_space:previous()
-- end)

-- hs.hotkey.bind({'ctrl', 'shift'},'t', function()
--   local app = hs.application.frontmostApplication()
--   if app ~= nil then
--     --  Safari
--     app:selectMenuItem({"History", "Reopen Last Closed Tab"})
--     -- Chrome
--     app:selectMenuItem({"File", "Reopen Closed Tab"})
--   end
-- end)
-- hs.hotkey.bind({'ctrl', 'shift'},'n', function()
--   local app = hs.application.frontmostApplication()
--   if app ~= nil then
--     --  Safari
--     app:selectMenuItem({"File", "New Tab at End"})
--     end
-- end)
-- hs.hotkey.bind({'ctrl', 'shift'},'m', function()
--   local app = hs.application.frontmostApplication()
--   if app ~= nil then
--     --  Safari
--     app:selectMenuItem({"View", "Show Tab Overview"})
--     -- iTerm
--     app:selectMenuItem({"Window", "Exposé all Tabs"})
--   end
-- end)
hs.hotkey.bind({"ctrl"}, "s", function()
  centerMouseInFocus()
  -- spoon.MouseCircle:show()
  enableMouse()
end)

hs.hotkey.bind({}, "f16", function()
  moveMouseToCenter()
  -- spoon.MouseCircle:show()
end)
-- Consider: double and triple click to warp further
-- see https://stackoverflow.com/questions/44303244/binding-to-multiple-button-clicks
hs.hotkey.bind({}, "f19", function()
  moveMouseToTopLeft()
  -- spoon.MouseCircle:show()
end)
hs.hotkey.bind({}, "f18", function()
  moveMouseToTopRight()
  -- spoon.MouseCircle:show()
end)
hs.hotkey.bind({}, "f17", function()
  moveMouseToBottomRight()
  -- spoon.MouseCircle:show()
end)
hs.hotkey.bind({}, "f15", function()
  moveMouseToBottomLeft()
  -- spoon.MouseCircle:show()
end)
spoon.MicMute:bindHotkeys({
  toggle = { { "ctrl" }, "5" }
})
spoon.HoldToQuit:bindHotkeys({
  quit = { { "ctrl", "shift" }, "y" }
})
spoon.ClipboardTool:bindHotkeys({
  show_clipboard = { { "cmd", "shift" }, "/" }
})

-- Play/Pause
hotkey.bind({"ctrl", "shift"}, "u", function()
  hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
  hs.eventtap.event.newSystemKeyEvent("PLAY", false):post()
end)
-- Previous Song
hotkey.bind({"ctrl", "shift"}, "p", function()
  hs.eventtap.event.newSystemKeyEvent("PREVIOUS", true):post()
  hs.eventtap.event.newSystemKeyEvent("PREVIOUS", false):post()
end)
-- Next Song
hotkey.bind({"ctrl", "shift"}, "f", function()
  hs.eventtap.event.newSystemKeyEvent("NEXT", true):post()
  hs.eventtap.event.newSystemKeyEvent("NEXT", false):post()
end)

-- overrides
-- hotkey.bind({"ctrl"}, "o", function()
--   hs.eventtap.keyStroke({"ctrl", "shift"}, "Tab")
-- end)
-- hotkey.bind({"ctrl"}, "n", function()
--   hs.eventtap.keyStroke({"ctrl"}, "Tab")
-- end)

-- Close
hotkey.bind({"ctrl", "shift"}, "o", function()
  bypassBind(cmdW, {"cmd"}, "w")
end)

-- Next Tab
hotkey.bind({"ctrl"}, "Space", function()
  hs.eventtap.keyStroke({"ctrl"}, "Tab")
end)
-- Previous Tab
hotkey.bind({"ctrl"}, "o", function()
  hs.eventtap.keyStroke({"ctrl", "shift"}, "Tab")
end)

-- Forward
cmdW = hotkey.bind({"cmd"}, "w", function()
  bypassBind(cmdH, {"cmd"}, "h")
end)

-- Copy
cmdH = hotkey.bind({"cmd"}, "h", function()
  hs.eventtap.keyStroke({"cmd"}, "c")
end)
-- Cut
cmdV = hotkey.bind({"cmd"}, "v", function()
  hs.eventtap.keyStroke({"cmd"}, "x")
end)
-- Paste
cmdP = hotkey.bind({"cmd"}, "p", function()
  bypassBind(cmdV, {"cmd"}, "v")
end)
hotkey.bind({"cmd", "shift"}, "p", function()
  hs.eventtap.keyStroke({"cmd", "shift"}, "v")
end)

-- disables
hotkey.bind({"cmd"}, "q", function() return end)


-- experimental
-- hs.hotkey.bind({"ctrl"}, "j", function()
--   hs.grid.toggleShow()
-- end)
-- hs.hotkey.bind({"ctrl"}, "2", function()
--   hs.hints.windowHints()
-- end)


--[ Side Effects ]-----------------------------------------------
keyEvents = hs.eventtap.new({
  hs.eventtap.event.types.keyDown,
  -- hs.eventtap.event.types.keyUp
}, function(event)
  -- print("flags")
  -- print(dump(event:getFlags()))

  -- print("code")
  -- print(event:getKeyCode())

  -- print("getRawEventData")
  -- print(dump(event:getRawEventData()))

  local flag = event:getFlags()
  local keyCode = event:getKeyCode()
  local app = hs.application.frontmostApplication()
  local appname = app ~= nil and app:name() or nil
  -- print(dump(appname))

  if flag.ctrl then
    if keyCode == hs.keycodes.map["i"]
    or keyCode == hs.keycodes.map["a"]
    then
      disableMouse()
    end

    if appname == "Safari" then
      if keyCode == hs.keycodes.map["t"]
      -- or keyCode == hs.keycodes.map["l"]
      and not flag.shift
      then
        -- hs.timer.doAfter(0.1, function()
          disableMouse()
        -- end)
      end
    end
    
    return false
  end

  if flag.cmd then  
    if appname == "Safari" then
      if keyCode == hs.keycodes.map["f"]
      or keyCode == hs.keycodes.map["o"]
      then
        -- hs.timer.doAfter(0.1, function()
          -- print("HERE")
          disableMouse()
        -- end)
      end
    end
  end

  return false
end)
keyEvents:start()

-----------------------------------------------------------------------
-- App Bindings 
-----------------------------------------------------------------------

--[ Slack ]------------------------------------------------------------
-- FROM https://github.com/STRML/init/blob/master/hammerspoon/init.lua
slackKeybinds = {
  hotkey.new({"ctrl"}, "n", function()
    hs.eventtap.keyStroke({"alt", "shift"}, "Down")
  end),
  hotkey.new({"ctrl"}, "o", function()
    hs.eventtap.keyStroke({"alt", "shift"}, "Up")
  end),
  hotkey.new({"cmd", "shift"}, "[", function()
    hs.eventtap.keyStroke({"alt"}, "Up")
  end),
  hotkey.new({"cmd", "shift"}, "]", function()
    hs.eventtap.keyStroke({"alt"}, "Down")
  end),
  -- Disables cmd-w entirely, which is so annoying on slack
  hotkey.new({"cmd"}, "w", function() return end)
}
local slackWatcher = hs.application.watcher.new(function(name, eventType, app)
  if eventType ~= hs.application.watcher.activated then return end
  local fnName = name == "Slack" and "enable" or "disable"
  for i, keybind in ipairs(slackKeybinds) do
    -- Remember that lua is weird, so this is the same as keybind.enable() in JS, `this` is first param
    keybind[fnName](keybind)
  end
end)
slackWatcher:start()