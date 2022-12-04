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
    If (color != 0x7ED5E2 and color != 0x74C2CE and color != 0x7DD4E1
        and color != 0x7ED4E1 and color != 0x72BFCB)
    {
        Return False
    }
    Return True
}
RunLeftRight() {
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
MapLv7() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 814, 567
    If (color == 0x909090)
    {
        Click, 814, 567
    }
    else
    {
        Click, 1183, 820
    }
    Sleep, 3000
}

^!x:: ; Control+Alt+X hotkey.
    TraceLog("Start")
    
    While True
    {
        WinActivate, ahk_id %UniqueID%
        If IsFighting()
        {
            OutputDebug, is fighting
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
            Loop, 3
            {
                Click, 1351, 783
                Sleep, 100
            }
        }
        If IsOutside()
        {
            OutputDebug, is outside
            ; 左右移動
            ; RunLeftRight()

            ; 冰雪之地區域-恩波格洛雪道
            MapLv7()
        }
        
        Sleep, 1000
    }

    ; TakeScreenshot(0, 0)
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp