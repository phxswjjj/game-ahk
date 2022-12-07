#Include, ../CaptureScreen.ahk ; assumes it's in the same folder as script

AppTitle := "octopath"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

global MapType := "unknown"

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

IsColorRoad(color) {
    If (color == 0x909090 or color == 0x7ED5E2)
        Return True
    Else
        Return False
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
DetectMap() {
    If (MapType != "unknown")
        Return

    Click, 1558, 223
    Sleep, 1000

    PixelGetColor, color, 966, 473
    PixelGetColor, color2, 730, 698
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv9"

    PixelGetColor, color, 1161, 594
    PixelGetColor, color2, 551, 459
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv1"

    PixelGetColor, color, 873, 441
    PixelGetColor, color2, 1059, 829
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv7"

    PixelGetColor, color, 1023, 386
    PixelGetColor, color2, 1029, 669
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv9L"

    PixelGetColor, color, 951, 507
    PixelGetColor, color2, 1148, 737
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv7L"

    PixelGetColor, color, 1224, 469
    PixelGetColor, color2, 668, 655
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv9L2"

    PixelGetColor, color, 953, 503
    PixelGetColor, color2, 755, 662
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapLv9L3"

    Click, 1777, 67
    Sleep, 1000

    If (MapType == "unknown")
        MapType := "NA"
    TraceLog(Format("MapType={1}", MapType))
}
MapLv9() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 966, 473
    If (color == 0x909090)
    {
        Click, 966, 473
    }
    else
    {
        Click, 730, 698
    }
    Sleep, 3000
}
MapLv1() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1161, 594
    If (color == 0x909090)
    {
        Click, 1161, 594
    }
    else
    {
        Click, 551, 459
    }
    Sleep, 3000
}
MapLv7() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 873, 441
    If (color == 0x909090)
    {
        Click, 873, 441
    }
    else
    {
        Click, 1059, 829
    }
    Sleep, 3000
}
MapLv9L() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1023, 386
    If (color == 0x909090)
    {
        Click, 1023, 386
    }
    else
    {
        Click, 1029, 669
    }
    Sleep, 3000
}
MapLv7L() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 951, 507
    If (color == 0x909090)
    {
        Click, 951, 507
    }
    else
    {
        Click, 1148, 737
    }
    Sleep, 3000
}
MapLv9L2() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1224, 469
    If (color == 0x909090)
    {
        Click, 1224, 469
    }
    else
    {
        Click, 668, 655
    }
    Sleep, 3000
}
MapLv9L3() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 953, 503
    If (color == 0x909090)
    {
        Click, 953, 503
    }
    else
    {
        Click, 755, 662
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
            Random, rand, 1, 10
            If rand > 7
            {
                Click, 1104, 933
                Sleep, 200
            }
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
            
            DetectMap()
            Switch (MapType) {
                Case "MapLv9":
                    ; 冰雪之地區域-恩波格洛研究所前
                    MapLv9()
                Case "MapLv1":
                    ; 冰雪之地區域-恩波格洛研究所
                    MapLv1()
                Case "MapLv7":
                    ; 冰雪之地區域-恩波格洛雪道
                    MapLv7()
                Case "MapLv9L":
                    ; 冰雪之地區域-西恩波格洛雪道
                    MapLv9L()
                Case "MapLv7L":
                    ; 森林之地區域-瓦格雷林道
                    MapLv7L()
                Case "MapLv9L2":
                    ; 森林之地區域-通往赫爾米尼亞府邸的小路
                    MapLv9L2()
                Case "MapLv9L3":
                    ; 森林之地區域-赫爾米尼亞府邸前
                    MapLv9L3()
            }
            
            ; 左右移動
            ; RunLeftRight()

            ; 冰雪之地區域-恩波格洛研究所前
            ; MapLv9()

            ; 冰雪之地區域-恩波格洛研究所
            ; MapLv1()

            ; 冰雪之地區域-恩波格洛雪道
            ; MapLv7()
        }
        
        Sleep, 1000
    }

    ; TakeScreenshot(0, 0)
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    TraceLog("Stopped")
ExitApp