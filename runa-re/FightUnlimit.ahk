#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

AppTitle := "runa-re"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss
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

IsNoEnergy() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 685, 747
    if color != 0x5379AD
    {
        Return False
    }
    PixelGetColor, color, 836, 738
    if color != 0xD3E8FB
    {
        Return False
    }
    Return True
}

SetFightRepeat() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 538, 845
    If color = 0xCCFF92
    {
        Return True
    }
    else if color = 0x3E4030
    {
        TraceLog(Format("(538, 845) is {1}, Setup Repeat", color))
        Click, 649, 838
        Sleep, 500
        Click, 880, 342
        Sleep, 200
        Click, 952, 852
        
        Sleep, 3000
    }
    else
    {
        TakeScreenshot(538, 845)
        TraceLog(Format("(538, 845) is {1}, Unknown", color))
        Return False
    }

    ; 因有流光效果影響判斷
    Loop, 3
    {
        PixelGetColor, color, 538, 845
        If color = 0xCCFF92
        {
            Return True
        }
        Sleep, 100
    }
    TakeScreenshot(538, 845)
    TraceLog(Format("(538, 845) is {1}", color))
    Return False
}

StartFightUnlimit() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 872, 225
    if color != 0x88A76F
    {
        TraceLog(Format("(872, 225) is {1}", color))
        Return False
    }
    Click, 658 935
    Sleep, 500

    PixelGetColor, color, 1024, 734
    if color != 0x4D5065
    {
        TraceLog(Format("(1024, 734) is {1}", color))
        Return False
    }
    Click, 1024, 734
    Return True
}

IsDesktop() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 1392, 184
    if color != 0x251DFF
    {
        Return False
    }
    PixelGetColor, color, 1394, 229
    if color != 0xE8A749
    {
        Return False
    }
    PixelGetColor, color, 1101, 224
    if color != 0x60E3FE
    {
        Return False
    }
    Return True
}

IsGameStart() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 983, 906
    if (color == 0x000000 or color == 0xB6A310)
    {
        ; is loading
        Return False
    }
    PixelGetColor, color, 797, 132
    if color != 0x65897D
    {
        Return False
    }
    PixelGetColor, color, 1027, 124
    if color != 0x65897D
    {
        Return False
    }
    Return True
}

IsActivity() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 170, 449
    if color != 0xD3D3D6
    {
        Return False
    }
    PixelGetColor, color, 1463, 441
    if color != 0x869EB7
    {
        Return False
    }
    PixelGetColor, color, 1579, 497
    if color != 0x8EA375
    {
        Return False
    }
    Return True
}

IsMap() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 433, 66
    if color != 0x433CD3
    {
        Return False
    }
    PixelGetColor, color, 418, 184
    if color != 0x433CD3
    {
        Return False
    }
    Return True
}

IsMsgbox() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 841, 471
    if color != 0x595A49
    {
        Return False
    }
    PixelGetColor, color, 1053, 460
    if color != 0x595A49
    {
        Return False
    }
    PixelGetColor, color, 1017, 761
    if color != 0x615C4D
    {
        Return False
    }
    PixelGetColor, color, 831, 786
    if color != 0x555140
    {
        Return False
    }
    Return True
}

^!x:: ; Control+Alt+X hotkey.
    TraceLog("Start")
    
    IfWinNotActive, ahk_id %UniqueID%
    {
        WinActivate, ahk_id %UniqueID%
    }
    If Not SetFightRepeat()
    {
        TraceLog("設置重複戰鬥失敗")
        Return
    }
    If Not StartFightUnlimit()
    {
        TraceLog("進入戰鬥失敗")
        Return
    }

    While True
    {
        FormatTime, CurrentDateTime,, HH:mm:ss
        IfWinNotActive, ahk_id %UniqueID%
        {
            WinActivate, ahk_id %UniqueID%
            ; OutputDebug, [%CurrentDateTime%] [%AppTitle%] not Active
            Sleep, 1000
            Continue
        }

        ; 行動力耗盡
        If IsNoEnergy()
        {
            ; 等行動力恢復、關閉行動力視窗
            TraceLog("等行動力恢復")
            Sleep, 180 * 60 * 1000

            If IsDesktop()
            {
                TraceLog("App is Crash, Try Again")
                Continue
            }

            ; 有 msgbox 要按掉
            Loop, 10
            {
                If IsMsgbox()
                {
                    TraceLog("Skip Msgbox")
                    Click, 831, 786
                    Sleep, 200
                    Continue
                }
                Break
            }

            WinActivate, ahk_id %UniqueID%
            Click, 1553, 395

            Sleep, 1000
            ; 設置重複戰鬥
            If Not SetFightRepeat()
            {
                TraceLog("設置重複戰鬥失敗")
                Break
            }
            If Not StartFightUnlimit()
            {
                TraceLog("進入戰鬥失敗")
                Break
            }
            TraceLog("進入戰鬥")
            Continue
        }
        ; app crash
        Else If IsDesktop()
        {
            TraceLog("App is Crash")
            Click, 1651, 200
            Loop, 1000
            {
                Sleep, 100
                If IsGameStart()
                    Break
            }
            ; 點擊開始
            Click, 935, 868
            
            ; 等待讀取(全黑)
            Loop, 10
            {
                Sleep, 1000
                PixelGetColor, color, 383, 496
                if color != 0x000000
                    Break
            }

            ; 關閉多個活動視窗
            Loop, 1000
            {
                Sleep, 1000
                If IsActivity()
                {
                    TraceLog("close Activity")
                    Click, 1726, 97
                    Continue
                }
                Break
            }

            Click, 944, 537
            If Not IsMap()
            {
                TraceLog("is not map")
                Break
            }
            Click, 944, 537
            Sleep, 3000
            
            If Not SetFightRepeat()
            {
                TraceLog("設置重複戰鬥失敗")
                Break
            }
            If Not StartFightUnlimit()
            {
                TraceLog("進入戰鬥失敗")
                Break
            }
            Continue
        }

        Sleep, 60 * 1000
    }
    TakeScreenshot(0, 0)
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp