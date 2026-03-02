#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
global isRunning := false
global keybind := ""
global oldKeybind := ""
global delay := 10

Gui, Color, 111111
Gui, Font, s10, Consolas
Gui, Add, Text, c00ff00 Center,
(
 ________ ________  ___  ___  ________   ________  ________      
|\  _____\\   __  \|\  \|\  \|\   ___  \|\   ___ \|\   ____\     
\ \  \__/\ \  \|\  \ \  \\\  \ \  \\ \  \ \  \_|\ \ \  \___|_    
 \ \   __\\ \  \\\  \ \  \\\  \ \  \\ \  \ \  \ \\ \ \_____  \   
  \ \  \_| \ \  \\\  \ \  \\\  \ \  \\ \  \ \  \_\\ \|____|\  \  
   \ \__\   \ \_______\ \_______\ \__\\ \__\ \_______\____\_\  \ 
    \|__|    \|_______|\|_______|\|__| \|__|\|_______|\_________\
                                                     \|_________|
)

Gui, Font, s12, Consolas
Gui, Add, Text, cffffff, Current Keybind:
Gui, Add, Text, vKeybindDisplay cffffff w200 h20, NONE
Gui, Add, Button, gSetKeybind, Set Keybind

Gui, Add, Text, cffffff, Macro Delay (ms):
Gui, Add, Edit, vDelayEdit w60, %delay%
Gui, Add, Button, gSaveSettings, Save

Gui, Add, Text, vStatus c00ff00, Macro OFF
Gui, Show,, 0_FOUNDS Macro
return

SetKeybind:
if (oldKeybind != "")
    Hotkey, %oldKeybind%, ToggleMacro, Off
GuiControl,, KeybindDisplay, Press a key...
Input, keybind, L1 T5
if (ErrorLevel = "Timeout") {
    GuiControl,, KeybindDisplay, NONE
    return
}
StringUpper, keybind, keybind
GuiControl,, KeybindDisplay, %keybind%
Hotkey, ~*%keybind%, ToggleMacro
oldKeybind := keybind
return

SaveSettings:
GuiControlGet, keybind, , KeybindDisplay
GuiControlGet, delay, , DelayEdit
delay := (delay < 1) ? 1 : delay
return

ToggleMacro:
isRunning := !isRunning
GuiControl,, Status, % isRunning ? "Macro ON" : "Macro OFF"
if isRunning
    SetTimer, RunMacro, %delay%
else
    SetTimer, RunMacro, Off
return

RunMacro:
Send, {Blind}{WheelUp}
Sleep, %delay%
Send, {Blind}{WheelDown}
Sleep, %delay%
return

GuiClose:
ExitApp
