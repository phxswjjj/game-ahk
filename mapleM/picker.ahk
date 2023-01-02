#Include "../Utility/Common.ahk"

AppTitle := "mapleM"
global UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug("[" AppTitle "] not found")
    Return
}

^!x:: ; Control+Alt+X hotkey.
{
    WinActivate(UniqueID)

    pos := [473, 728]
    MouseMove(pos*)
    Loop 1000
    {
        color := PixelGetColor(pos*)
        OutputDebug(color)
        Sleep(200)
    }
}

^!z::  ; Control+Alt+Z hotkey.
{
    MouseGetPos(&MouseX, &MouseY)
    color := PixelGetColor(MouseX, MouseY)
    Title := WinGetTitle(, "A")
    OutputDebug(Title ": The color at the current cursor position (" MouseX ", " MouseY ") is " color)
}
