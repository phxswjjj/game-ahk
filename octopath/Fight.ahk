#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

AppTitle := "klight"
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

IsFighting() {
    PixelGetColor, color, 1526, 181
    If color != 0x867954
    {
        Return False
    }
    Return True
}
IsFightingResult() {
    PixelGetColor, color, 182, 110
    If color != 0xE8EBF0
    {
        Return False
    }
    PixelGetColor, color, 239, 114
    If color != 0xE8EBF0
    {
        Return False
    }
    PixelGetColor, color, 498, 141
    If color != 0xE8EBF0
    {
        Return False
    }
    Return True
}
IsOutside() {
    PixelGetColor, color, 1558, 223
    If (color != 0x7ED5E2 and color != 0x74C2CE and color != 0x7DD4E1)
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
        If IsFighting()
        {
            OutputDebug, is fighting
            ; detect fight and click
            Click, 1104, 933
            Sleep, 200
            Click, 1262, 921
            Sleep, 200
            Click, 1497, 924
            Sleep, 3000
        }
        If IsFightingResult()
        {
            OutputDebug, is fighting result
            ; click 2 times
            Loop, 3
            {
                Click, 1351, 783
                Sleep, 100
            }
        }
        If IsOutside()
        {
            OutputDebug, is outside
            ; run left and right
            Loop, 6
            {
                If not IsOutside()
                    Break
                
                If Mod(A_Index, 2) = 0
                    MouseClickDrag, left, 100, 200, 200, 200
                Else
                    MouseClickDrag, left, 200, 200, 100, 200
                Sleep, 4000
            }
        }
        
        Sleep, 1000
    }

    ; TakeScreenshot(0, 0)
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp