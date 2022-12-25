
TraceLog(msg) {
    CurrentDateTime := FormatTime(, "HH:mm:ss")
    OutputDebug("[" CurrentDateTime "] " msg)
}
Return

^!x:: ; Control+Alt+X hotkey.
{
    MouseMove(0, 0)
    color := PixelGetColor(538, 845)
    TraceLog(Format("(538, 845) is {1}", color))
}

^!z::  ; Control+Alt+Z hotkey.
{
    MouseGetPos(&MouseX, &MouseY)
    color := PixelGetColor(MouseX, MouseY)
    Title := WinGetTitle(, "A")
    OutputDebug(Title ": The color at the current cursor position (" MouseX ", " MouseY ") is " color)
}
