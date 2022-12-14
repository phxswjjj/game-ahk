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

    PixelGetColor, color, 1143, 582
    PixelGetColor, color2, 716, 587
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapForestLv9"
        
    PixelGetColor, color, 709, 526
    PixelGetColor, color2, 1201, 661
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapForestLv16"
        
    PixelGetColor, color, 1189, 508
    PixelGetColor, color2, 584, 798
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapForestLv16v2"
        
    PixelGetColor, color, 461, 697
    PixelGetColor, color2, 781, 499
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapForestLv16v3"
        
    PixelGetColor, color, 1300, 615
    PixelGetColor, color2, 606, 285
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapForestLv21"
        
    PixelGetColor, color, 1054, 801
    PixelGetColor, color2, 937, 419
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv12"
        
    PixelGetColor, color, 501, 272
    PixelGetColor, color2, 926, 658
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv14"
        
    PixelGetColor, color, 946, 355
    PixelGetColor, color2, 944, 825
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv14v2"
        
    PixelGetColor, color, 805, 710
    PixelGetColor, color2, 1089, 260
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv16"
        
    PixelGetColor, color, 758, 557
    PixelGetColor, color2, 662, 717
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv18"
        
    PixelGetColor, color, 1334, 600
    PixelGetColor, color2, 433, 600
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapIceLv18v2"
        
    PixelGetColor, color, 633, 649
    PixelGetColor, color2, 964, 431
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapPlainLv7"
        
    PixelGetColor, color, 614, 410
    PixelGetColor, color2, 1292, 662
    PixelGetColor, color3, 1038, 425
    PixelGetColor, color4, 733, 601
    If (IsColorRoad(color) and IsColorRoad(color2)
        and IsColorRoad(color3) and IsColorRoad(color4))
        MapType := "MapPlainLv9"
        
    PixelGetColor, color, 522, 867
    PixelGetColor, color2, 992, 303
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapPlainLv11"
        
    PixelGetColor, color, 1254, 607
    PixelGetColor, color2, 986, 596
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapPlainLv12"
        
    PixelGetColor, color, 725, 686
    PixelGetColor, color2, 770, 457
    If (IsColorRoad(color) and IsColorRoad(color2))
        MapType := "MapPlainLv20"

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
MapForestLv9() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1143, 582
    If (color == 0x909090)
    {
        Click, 1143, 582
    }
    else
    {
        Click, 716, 587
    }
    Sleep, 3000
}
MapForestLv16() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 709, 526
    If (color == 0x909090)
    {
        Click, 709, 526
    }
    else
    {
        Click, 1201, 661
    }
    Sleep, 3000
}
MapForestLv16v2() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1189, 508
    If (color == 0x909090)
    {
        Click, 1189, 508
    }
    else
    {
        Click, 584, 798
    }
    Sleep, 3000
}
MapForestLv16v3() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 461, 697
    If (color == 0x909090)
    {
        Click, 461, 697
    }
    else
    {
        Click, 781, 499
    }
    Sleep, 3000
}
MapForestLv21() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1300, 615
    If (color == 0x909090)
    {
        Click, 1300, 615
    }
    else
    {
        Click, 606, 285
    }
    Sleep, 3000
}
MapIceLv12() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1054, 801
    If (color == 0x909090)
    {
        Click, 1054, 801
    }
    else
    {
        Click, 937, 419
    }
    Sleep, 3000
}
MapIceLv14() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 501, 272
    If (color == 0x909090)
    {
        Click, 501, 272
    }
    else
    {
        Click, 926, 658
    }
    Sleep, 3000
}
MapIceLv14v2() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 946, 355
    If (color == 0x909090)
    {
        Click, 946, 355
    }
    else
    {
        Click, 944, 825
    }
    Sleep, 3000
}
MapIceLv16() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 805, 710
    If (color == 0x909090)
    {
        Click, 805, 710
    }
    else
    {
        Click, 1089, 260
    }
    Sleep, 3000
}
MapIceLv18() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 758, 557
    If (color == 0x909090)
    {
        Click, 758, 557
    }
    else
    {
        Click, 662, 717
    }
    Sleep, 3000
}
MapIceLv18v2() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1334, 600
    If (color == 0x909090)
    {
        Click, 1334, 600
    }
    else
    {
        Click, 433, 600
    }
    Sleep, 3000
}
MapPlainLv7() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 633, 649
    If (color == 0x909090)
    {
        Click, 633, 649
    }
    else
    {
        Click, 964, 431
    }
    Sleep, 3000
}
MapPlainLv9() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 614, 410
    If (color == 0x909090)
    {
        Click, 614, 410
    }
    else
    {
        Click, 1292, 662
    }
    Sleep, 3000
}
MapPlainLv11() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 522, 867
    If (color == 0x909090)
    {
        Click, 522, 867
    }
    else
    {
        Click, 992, 303
    }
    Sleep, 3000
}
MapPlainLv12() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 1254, 607
    If (color == 0x909090)
    {
        Click, 1254, 607
    }
    else
    {
        Click, 986, 596
    }
    Sleep, 3000
}
MapPlainLv20() {
    PixelGetColor, color, 373, 849
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click, 1558, 223
    Sleep, 1000
    PixelGetColor, color, 725, 686
    If (color == 0x909090)
    {
        Click, 725, 686
    }
    else
    {
        Click, 770, 457
    }
    Sleep, 3000
}

IsAppCrash() {
    PixelGetColor, color, 212, 204
    If (color != 0xF48542)
    {
        Return False
    }
    PixelGetColor, color, 256, 205
    If (color != 0x04BCFB)
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
                Case "MapForestLv9":
                    ; 森林之地區域-西瓦落雷林道
                    MapForestLv9()
                Case "MapForestLv16":
                    ; 森林之地區域-林洞遺跡
                    MapForestLv16()
                Case "MapForestLv16v2":
                    ; 森林之地區域-亞久斯特別墅前
                    MapForestLv16v2()
                Case "MapForestLv16v3":
                    ; 森林之地區域-亞久斯特別墅
                    MapForestLv16v3()
                Case "MapForestLv21":
                    ; 森林之地區域-赫爾米宣亞府邸
                    MapForestLv21()
                Case "MapIceLv12":
                    ; 冰雪之地區域-恩波格洛雪山
                    MapIceLv12()
                Case "MapIceLv14":
                    ; 冰雪之地區域-雪六花之館遺跡
                    MapIceLv14()
                Case "MapIceLv14v2":
                    ; 冰雪之地區域-雪洞地下遺跡
                    MapIceLv14v2()
                Case "MapIceLv16":
                    ; 冰雪之地區域-雪花晶洞穴
                    MapIceLv16()
                Case "MapIceLv18":
                    ; 冰雪之地區域-竣工典禮場所
                    MapIceLv18()
                Case "MapIceLv18v2":
                    ; 冰雪之地區域-泰塔斯大聖堂
                    MapIceLv18v2()
                Case "MapPlainLv7":
                    ; 平原之地區域-希亞特珀利斯平原
                    MapPlainLv7()
                Case "MapPlainLv9":
                    ; 平原之地區域-北希亞特珀利斯平原
                    MapPlainLv9()
                Case "MapPlainLv11":
                    ; 平原之地區域-大劇場-練習場
                    MapPlainLv11()
                Case "MapPlainLv12":
                    ; 平原之地區域-聖火騎士駐地
                    MapPlainLv12()
                Case "MapPlainLv20":
                    ; 平原之地區域-大劇場-後台
                    MapPlainLv20()
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

        If IsAppCrash()
        {
            TraceLog("app is crash")
            ; launch app
            Click, 1649, 197
            ; wait tap to start
            Loop, 180
            {
                PixelGetColor, color, 1605, 960
                If (color == 0x000000 or color == 0xFFFFFF)
                {
                    Sleep, 1000
                    Continue
                }
                If (color == 0x202A2C)
                {
                    Click, 959, 819
                    Sleep, 20000
                    Break
                }
                Sleep, 1000
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