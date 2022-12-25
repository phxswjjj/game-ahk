
AppTitle := "octopath"
global UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug("[" AppTitle "] not found")
    Return
}

TraceLog(msg) {
    CurrentDateTime := FormatTime(, "HH:mm:ss")
    OutputDebug("[" CurrentDateTime "] " msg)
}
Return

^!x:: ; Control+Alt+X hotkey.
{
    WinActivate(UniqueID)

    pos := [1558, 223]
    MouseMove(pos*)
    Loop 1000
    {
        color := PixelGetColor(pos*)
        OutputDebug(color)
        Sleep(200)
    }
}


^!z:: ; Control+Alt+Z hotkey.
{
    TraceLog("Stopped")
    ExitApp
}
