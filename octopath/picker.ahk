#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

#InstallKeybdHook

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}
Return

^!x:: ; Control+Alt+X hotkey.

    Loop, 100
    {
        PixelGetColor, color, 1558, 223
        OutputDebug, (1558, 223) is %color%
        Sleep, 200
    }
    
Return


^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp


#KeyHistory
