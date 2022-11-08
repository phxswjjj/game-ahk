#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

AppTitle := "klight"
IsPVPTime := False
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

If (A_Hour=12) or (A_Hour=21)
{
    IsPVPTime := True
}

SetTimer, CheckTimeJob, 1000

Return

CheckTimeJob:
    If (A_Hour=13) or (A_Hour=22)
    {
        IsPVPTime := False
        TraceLog("PVP time is over")
        ExitApp
    }
    Else If (A_Hour=12) or (A_Hour=21)
    {
        IsPVPTime := True
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

IsStartMatch() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 380, 68
    if color != 0x000000
    {
        Return False
    }
    PixelGetColor, color, 1663, 859
    if color != 0xEFE7EF
    {
        Return False
    }
    Return True
}

IsFighting() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 117, 101
    if color != 0xFFFFFF
    {
        Return False
    }
    PixelGetColor, color, 164, 731
    if color != 0x000000
    {
        Return False
    }
    PixelGetColor, color, 270, 744
    if color != 0x000000
    {
        Return False
    }
    PixelGetColor, color, 252, 732
    if color != 0xF7F3EF
    {
        Return False
    }
    Return True
}

IsPVPEnd() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 1438, 61
    if color != 0x000000
    {
        ; TakeScreenshot(1438, 61)
        ; TraceLog(Format("(1438, 61) is {1}", color))
        ; ExitApp
        Return False
    }
    PixelGetColor, color, 1410, 76
    if color != 0x000000
    {
        Return False
    }
    PixelGetColor, color, 1031, 467
    if color != 0xFFFFFF
    {
        Return False
    }
    Return True
}

^!x:: ; Control+Alt+X hotkey.
    TraceLog("Start")

    While True
    {
        If Not IsPVPTime
        {
            Sleep, 1000
            Continue
        }
        IfWinNotActive, ahk_id %UniqueID%
        {
            WinActivate, ahk_id %UniqueID%
            Sleep, 1000
            Continue
        }
        
        ; 開始配對
        If IsStartMatch()
        {
            Click, 1663, 859
            Sleep, 30000
        }

        ; 戰鬥中，投降
        If IsFighting()
        {
            Click, 117, 101
            Sleep, 500
            Click, 1161, 682
            Sleep, 3000
        }

        ; 戰鬥結束/結算
        If IsPVPEnd()
        {
            Click, 485, 556
            Sleep, 2000
        }
    }

Return

^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp