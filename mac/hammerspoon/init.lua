local switcher = require 'switcher'
local mouseJump = require 'mouseJump'
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
-- hs.loadSpoon("HoldToQuit")
-- hs.loadSpoon("CountDown")

---- Auto-Reload
hs.alert.show('Config loaded!')
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

---- MouseCircle
hs.loadSpoon("MouseCircle")
spoon.MouseCircle.color = tronOrange

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
    showThumbnails=false, -- show app preview in thumbnail
    showSelectedThumbnail=false, -- disable large preview
    thumbnailSize = 256, -- double size of thumbnails (may be too big for laptop-mode?)
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
menubarIndicators = {}

function drawMenubarIndicator()
  -- if menubarIndicator == nil then

  -- hs.drawing.color.x11.red
  screens = hs.screen.allScreens()
  for i,screen in ipairs(screens) do
    -- local screen = hs.screen.primaryScreen()
    local screeng = screen:fullFrame()
    local width = screeng.w
    height = (screen:frame().y - screeng.y)
    local menubarIndicator = hs.drawing.rectangle(hs.geometry.rect(screeng.x, screeng.y,
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
    -- print(dump(menubarIndicator))

    table.insert(menubarIndicators, menubarIndicator)
  end
-- end
end

function deleteMenubarIndicator()
  -- print("delete menubars")
  -- print(dump(menubarIndicators))

  for _, menubarIndicator in pairs(menubarIndicators) do
    -- print("delete menubar")
    -- print(menubarIndicator)

    menubarIndicator:delete()
    -- menubarIndicator = nil
  end

  menubarIndicators = {}
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
  -- print("enableMouse()")
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

  -- print("before")
  -- print(hs.eventtap.checkKeyboardModifiers().capslock)
  -- print("event")
  -- print(event:getKeyCode() == hs.keycodes.map["capslock"])

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
-- local pow = hs.caffeinate.watcher
-- pow.new(function(event)
--   if event == pow.screensDidSleep
--   or event == pow.systemWillSleep
--   or event == pow.systemWillPowerOff
--   or event == pow.sessionDidResignActive
--   or event == pow.screensDidLock 
--   then
--     -- hardware disable
--     hs.hid.capslock.set(false)

--     -- if hs.eventtap.checkKeyboardModifiers().capslock then
--     -- software disable (via key-up)
--     hs.eventtap.event.newKeyEvent(hs.keycodes.map.capslock, false):post();
--     -- end
--   end
-- end):start()

---- Update menubar after logging in
hs.caffeinate.watcher.new(function(event)
  print("caffeinate event: ")
  print(event)
    -- if event == hs.caffeinate.watcher.systemDidWake
    -- or event == hs.caffeinate.watcher.screensDidWake
    if event == hs.caffeinate.watcher.screensDidUnlock
    then
      deleteMenubarIndicator()
  
      if hs.eventtap.checkKeyboardModifiers().capslock then
        drawMenubarIndicator()
      end
    end
  end):start()

  ---- Update menubar after [dis]connecting monitors
-- local num_of_screens =  #hs.screen.allScreens()
-- hs.screen.watcher.new(function(e)
--   -- This function fires twice when a monitor is added/removed:
--   --   Once before the change (stored num_of_screens is different from current value)
--   --   Once after the change (stored num_of_screens is same as current value)
--   if num_of_screens == #hs.screen.allScreens() then
--     if hs.eventtap.checkKeyboardModifiers().capslock then
--       -- hs.timer.doAfter(0.5, function()
--         deleteMenubarIndicator()
--         drawMenubarIndicator()
--       -- end)
      
--     end
--   end
  
--   -- print("screens before:")
--   -- print(num_of_screens)
--   num_of_screens = #hs.screen.allScreens()
--   -- print("screens after:")
--   -- print(num_of_screens)
-- end):start()

---- Update menubar after logging in
-- wakeWatcher = hs.caffeinate.watcher
-- wakeWatcher.new(function(event)
--   if event == hs.caffeinate.watcher.systemDidWake
--   or event == hs.caffeinate.watcher.screensDidWake
--   then
--     -- isLocked = hs.eventtap.checkKeyboardModifiers().capslock
--     if (hs.eventtap.checkKeyboardModifiers().capslock) then
--       drawMenubarIndicator()
--     else
--       deleteMenubarIndicator()
--     end
--   end
-- end):start()

-----------------------------------------------------------------------
-- Bindings 
-----------------------------------------------------------------------
local DOUBLE_TAP_DELAY = 0.20

local f19Timer = 0
local f18Timer = 0
local f17Timer = 0
local f16Timer = 0
local f15Timer = 0

-- function bypassBind(binding, mods, keycode)
--   binding:disable()
--   hs.eventtap.keyStroke(mods, keycode)
--   hs.timer.doAfter(0.1, function()
--     binding:enable()
--   end)
-- end

-- Now using Witch instead, since Switch would miss newly created windows
hs.hotkey.bind('ctrl','t', function()
  switcher_space:next()
end)
hs.hotkey.bind('ctrl','h', function()
  switcher_space:previous()
end)

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
  mouseJump.toCenterOfWindow()
  spoon.MouseCircle:show()
  enableMouse()
end)

hs.hotkey.bind({}, "f16", function()
  -- Double Tap
  if f16Timer > 0 and hs.timer.secondsSinceEpoch() - f16Timer < DOUBLE_TAP_DELAY then
    f16Timer = 0
    mouseJump.toCenter()
    spoon.MouseCircle:show()
  -- Single Tap
  else
    f16Timer = hs.timer.secondsSinceEpoch()

    hs.timer.doAfter(DOUBLE_TAP_DELAY, function()
      if (f16Timer > 0) then  
        f16Timer = 0
        mouseJump.toCenterOfWindow()
        spoon.MouseCircle:show()
      end
    end)
  end
end)
hs.hotkey.bind({}, "f19", function()
  -- Double Tap
  if f19Timer > 0 and hs.timer.secondsSinceEpoch() - f19Timer < DOUBLE_TAP_DELAY then
    f19Timer = 0
    mouseJump.toTopLeft()
    spoon.MouseCircle:show()
  -- Single Tap
  else
    f19Timer = hs.timer.secondsSinceEpoch()

    hs.timer.doAfter(DOUBLE_TAP_DELAY, function()
      if (f19Timer > 0) then  
        f19Timer = 0
        mouseJump.toTopLeftOfWindow()
        spoon.MouseCircle:show()
      end
    end)
  end
end)
hs.hotkey.bind({}, "f18", function()
  -- Double Tap
  if f18Timer > 0 and hs.timer.secondsSinceEpoch() - f18Timer < DOUBLE_TAP_DELAY then
    f18Timer = 0
    mouseJump.toTopRight()
    spoon.MouseCircle:show()
  -- Single Tap
  else
    f18Timer = hs.timer.secondsSinceEpoch()

    hs.timer.doAfter(DOUBLE_TAP_DELAY, function()
      if (f18Timer > 0) then  
        f18Timer = 0
        mouseJump.toTopRightOfWindow()
        spoon.MouseCircle:show()
      end
    end)
  end
end)
hs.hotkey.bind({}, "f17", function()
  -- Double Tap
  if f17Timer > 0 and hs.timer.secondsSinceEpoch() - f17Timer < DOUBLE_TAP_DELAY then
    f17Timer = 0
    mouseJump.toBottomRight()
    spoon.MouseCircle:show()
  -- Single Tap
  else
    f17Timer = hs.timer.secondsSinceEpoch()

    hs.timer.doAfter(DOUBLE_TAP_DELAY, function()
      if (f17Timer > 0) then  
        f17Timer = 0
        mouseJump.toBottomRightOfWindow()
        spoon.MouseCircle:show()
      end
    end)
  end
end)
hs.hotkey.bind({}, "f15", function()
  -- Double Tap
  if f15Timer > 0 and hs.timer.secondsSinceEpoch() - f15Timer < DOUBLE_TAP_DELAY then
    f15Timer = 0
    mouseJump.toBottomLeft()
    spoon.MouseCircle:show()
  -- Single Tap
  else
    f15Timer = hs.timer.secondsSinceEpoch()

    hs.timer.doAfter(DOUBLE_TAP_DELAY, function()
      if (f15Timer > 0) then  
        f15Timer = 0
        mouseJump.toBottomLeftOfWindow()
        spoon.MouseCircle:show()
      end
    end)
  end
end)
spoon.MicMute:bindHotkeys({
  toggle = { { "ctrl" }, "5" }
})
-- spoon.HoldToQuit:bindHotkeys({
--   quit = { { "ctrl", "shift" }, "k" }
-- })
spoon.ClipboardTool:bindHotkeys({
  show_clipboard = { { "cmd", "shift" }, "8" }
})
-- hs.hotkey.bind({"ctrl"}, "g", function()
--   spoon.CountDown:startFor(1)
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
    -- Screenshot mode
    if keyCode == hs.keycodes.map["b"]
    then
      enableMouse()
    end

    if keyCode == hs.keycodes.map["i"]
    -- Action mode
    or keyCode == hs.keycodes.map["a"]
    then
      disableMouse()
    end

    if appname == "Safari" or appname == "Google Chrome" then
      if keyCode == hs.keycodes.map["c"]
      and not flag.shift
      then
          disableMouse()
      end
    end
    
    return false
  end

  if flag.cmd then  
    -- cmd+f
    if keyCode == hs.keycodes.map["f"] then
      if appname == "Safari"
      or appname == "Google Chrome"
      or appname == "Code"
      then
        disableMouse()
      end
    -- cmd+o
    elseif keyCode == hs.keycodes.map["o"] then
      if appname == "Safari"
      or appname == "Google Chrome"
      or appname == "Code"
      then
        disableMouse()
      end 
    -- cmd+a
    elseif keyCode == hs.keycodes.map["a"] then
      if appname == "Code"
      then
        disableMouse()
      end
    end
  end

  return false
end)
keyEvents:start()

-----------------------------------------------------------------------
-- App Bindings 
-----------------------------------------------------------------------
-- Helpful links for using Chooser:
--   http://xenodium.com/emacs-utilities-for-your-os/
--   https://aldur.github.io/articles/hammerspoon-emojis/

--[ Xcode ]------------------------------------------------------------
local handleXcodeActionChoice = function(choice)
  if not choice then return end

  if choice["hotkey"] then hs.eventtap.keyStroke(table.unpack(choice["hotkey"])) end

  if choice["action"] then
    local xcode = hs.appfinder.appFromName("Xcode")
    xcode:selectMenuItem(choice["action"])
  end
end

-- View
local xcodeViewChooser = hs.chooser.new(handleXcodeActionChoice)
xcodeViewChooser:choices({
  {
     ["text"] = "Explorer",
    --  ["action"] = {"View", "Navigators", "Project"},
     ["action"] = {"Navigate", "Reveal in Project Navigator"},

  },
  {
    ["text"] = "Tests",
    ["action"] = {"View", "Navigators", "Tests"},
 },
})
-- Inspector
local xcodeInspectorChooser = hs.chooser.new(handleXcodeActionChoice)
xcodeInspectorChooser:choices({
  {
     ["text"] = "Quick Help",
     ["action"] = {"View", "Inspectors", "Quick Help"},
  },
  {
    ["text"] = "File",
    ["action"] = {"View", "Inspectors", "File"},
  },
  {
    ["text"] = "History",
    ["action"] = {"View", "Inspectors", "History"},
  },
})
-- Go To
local xcodeGoToChooser = hs.chooser.new(handleXcodeActionChoice)
xcodeGoToChooser:choices({
  {
    ["text"] = "Line",
    ["hotkey"] = {{"alt"}, "l"},
    --  ["action"] = {"Navigate", "Jump to..."},
  },
  {
    ["text"] = "Definition",
    ["hotkey"] = {{"cmd"}, "f12"},
    -- ["action"] = {"Navigate", "Jump to Definition"},
  },
  {
    ["text"] = "Previous Edit",
    ["action"] = {"Navigate", "Jump to Previous Change"},
  },
  {
    ["text"] = "Back",
    ["action"] = {"Navigate", "Go Back"},
  },
  {
    ["text"] = "Forward",
    ["action"] = {"Navigate", "Go Forward"},
  },
})

local xcodeKeybinds = {
  hotkey.new({"cmd"}, "p", function() xcodeViewChooser:show() end),
  hotkey.new({"cmd"}, ".", function() xcodeInspectorChooser:show() end),
  hotkey.new({"cmd"}, "g", function() xcodeGoToChooser:show() end),
  -- hotkey.new({"cmd"}, "s", function() 
  --   local xcode = hs.appfinder.appFromName("Xcode")

  --   -- set mark
  --   hs.eventtap.keyStroke({"cmd"}, "u")
  --   -- select all
  --   hs.eventtap.keyStroke({"cmd", "shift"}, "e")
  --   hs.timer.doAfter(0.1, function()
 
  --   xcode:selectMenuItem({"Editor", "Structure", "Re-Indent"})
  --   -- Unselect all
  --   -- hs.eventtap.keyStroke({}, "Down")

  --     -- swap to mark
  --   hs.eventtap.keyStroke({"cmd", "shift"}, "u")
  --   -- center to selection
  --   hs.eventtap.keyStroke({"cmd"}, "/")

  --   xcode:selectMenuItem({"File", "Save"})
  -- end)

  --  end),
}

local xcodeWatcher = hs.application.watcher.new(function(name, eventType, app)
  -- print("eventType")
  -- print(eventType)
  -- print("hs.application.watcher.activated")  
  -- print(hs.application.watcher.activated)  
  if eventType ~= hs.application.watcher.activated then return end
  local fnName = name == "Xcode" and "enable" or "disable"
  -- print("fnNam")
  -- print(fnName)
  for i, keybind in ipairs(xcodeKeybinds) do
    keybind[fnName](keybind)
  end
end)
xcodeWatcher:start()

-- Note: I think having 2 watchers messed things up.
-- Commenting Slack for now...

--[ Slack ]------------------------------------------------------------
-- FROM https://github.com/STRML/init/blob/master/hammerspoon/init.lua
-- slackKeybinds = {
--   hotkey.new({"ctrl"}, "n", function()
--     hs.eventtap.keyStroke({"alt", "shift"}, "Down")
--   end),
--   hotkey.new({"ctrl"}, "o", function()
--     hs.eventtap.keyStroke({"alt", "shift"}, "Up")
--   end),
--   hotkey.new({"cmd", "shift"}, "[", function()
--     hs.eventtap.keyStroke({"alt"}, "Up")
--   end),
--   hotkey.new({"cmd", "shift"}, "]", function()
--     hs.eventtap.keyStroke({"alt"}, "Down")
--   end),
--   -- Disables cmd-w entirely, which is so annoying on slack
--   hotkey.new({"cmd"}, "w", function() return end)
-- }
-- local slackWatcher = hs.application.watcher.new(function(name, eventType, app)
--   if eventType ~= hs.application.watcher.activated then return end
--   local fnName = name == "Slack" and "enable" or "disable"
--   for i, keybind in ipairs(slackKeybinds) do
--     -- Remember that lua is weird, so this is the same as keybind.enable() in JS, `this` is first param
--     keybind[fnName](keybind)
--   end
-- end)
-- slackWatcher:start()