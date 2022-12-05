#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

AppTitle := "octopath"
IsPVPTime := False
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

Return

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}
TakeScreenshot(x, y) {
    MouseMove, x, y
    FormatTime, FileDate,, MMdd_HHmmss
    CaptureScreen(0, 1, "CaptureScreen_" FileDate ".png")
}

IsPick() {
    PixelGetColor, color, 1396, 156
    If color != 0x5E4827
    {
        Return False
    }
    PixelGetColor, color, 1428, 738
    If color != 0x5C6234
    {
        Return False
    }
    Return True
}
IsPickEffectMsg() {
    PixelGetColor, color, 853, 759
    If (color != 0x715A25)
    {
        Return False
    }
    PixelGetColor, color, 1028, 762
    If (color != 0x715925)
    {
        Return False
    }
    Return True
}

^!x:: ; Control+Alt+X hotkey.
    TraceLog("Start")
    
    While True
    {
        WinActivate, ahk_id %UniqueID%
        If IsPick()
        {
            OutputDebug, is pick
            Click, 1428, 738
            Sleep, 1000
            Click, 1212, 702
            Sleep, 3000
            
            ; wait loading
            Loop, 10
            {
                Sleep, 1000
                PixelGetColor, color, 968, 548
                If color != 0x000000
                    Break
            }
            Sleep, 2000
            
            WinActivate, ahk_id %UniqueID%
            ; Touch Screen
            Loop, 5
            {
                Sleep, 200
                Click, 939, 548
            }
        }

        If IsPickEffectMsg()
        {
            Click, 1028, 762
            Sleep, 500
            Click, 803, 712
        }
        
        Sleep, 1000
    }

    ; TakeScreenshot(0, 0)
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp