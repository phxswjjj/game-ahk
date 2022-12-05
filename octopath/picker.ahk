#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

#InstallKeybdHook

AppTitle := "octopath"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}
Return

^!x:: ; Control+Alt+X hotkey.
    WinActivate, ahk_id %UniqueID%

    Loop, 100
    {
        PixelGetColor, color, 853, 759
        OutputDebug, (853, 759) is %color%
        Sleep, 200
    }
    
Return


^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp


#KeyHistory
