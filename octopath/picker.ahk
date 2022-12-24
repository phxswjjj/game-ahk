
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

    MouseMove(1224, 952)
    Loop 1000
    {
        color := PixelGetColor(1224, 952)
        OutputDebug(color)
        Sleep(200)
    }
}


^!z:: ; Control+Alt+Z hotkey.
{
    TraceLog("Stopped")
    ExitApp
}
