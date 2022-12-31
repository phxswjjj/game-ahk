#Include "../Utility/MyMap.ahk"
#Include "./Map/Desert.ahk"
#Include "./Map/Cliff.ahk"
#Include "./Map/River.ahk"
#Include "./Map/Ocean.ahk"
#Include "./Map/Plain.ahk"
#Include "./Map/Ice.ahk"

global AppTitle := "octopath"
global UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug("[" AppTitle "] not found")
    Return
}

global MapType := "unknown"

global MapDefineds := MyMap()

MapDefineds.Extends(DesertMap.Maps)
MapDefineds.Extends(CliffMap.Maps)
MapDefineds.Extends(RiverMap.Maps)
MapDefineds.Extends(OceanMap.Maps)
MapDefineds.Extends(PlainMap.Maps)
MapDefineds.Extends(IceMap.Maps)

Return

TraceLog(msg) {
    CurrentDateTime := FormatTime(, "HH:mm:ss")
    OutputDebug("[" CurrentDateTime "] " msg)
}

IsColorRoad(color) {
    If (color == 0x909090 or color == 0x7ED5E2)
        Return True
    Else
        Return False
}
IsPosColorRoad(x, y) {
    color := PixelGetColor(x, y)
    Return IsColorRoad(color)
}
IsFighting() {
    color := PixelGetColor(1526, 181)
    If (color != 0x547986)
    {
        Return False
    }
    color := PixelGetColor(1224, 952)
    If ((color & 0xD0D0D0) != 0xD0D0D0
        and (color & 0x303030) != 0x303030)
    {
        Return False
    }
    Return True
}
IsFightingResult() {
    color := PixelGetColor(182, 110)
    If color != 0xF0EBE8
    {
        Return False
    }
    color := PixelGetColor(239, 114)
    If color != 0xF0EBE8
    {
        Return False
    }
    color := PixelGetColor(498, 141)
    If color != 0xF0EBE8
    {
        Return False
    }
    Return True
}
IsOutside() {
    color := PixelGetColor(1558, 223)
    If ((color & 0xE0D070) != 0xE0D070
        and (color & 0xC0C070) != 0xC0C070)
    {
        Return False
    }
    Return True
}
DetectMap() {
    global MapType
    global MapDefineds
    If (MapType != "unknown")
        Return

    Click(1558, 223)
    Sleep(1000)

    For mapKey, mapValue In MapDefineds {
        bAllRoad := True
        For pos In mapValue {
            If Not IsPosColorRoad(pos*) {
                bAllRoad := False
                Break
            }
        }
        If bAllRoad {
            MapType := mapKey
            TraceLog("MyMap Detected: " mapKey)
        }
    }

    If MapType != "unknown" {
        color := PixelGetColor(966, 473)
        color2 := PixelGetColor(730, 698)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv9"

        color := PixelGetColor(1161, 594)
        color2 := PixelGetColor(551, 459)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv1"

        color := PixelGetColor(873, 441)
        color2 := PixelGetColor(1059, 829)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv7"

        color := PixelGetColor(1023, 386)
        color2 := PixelGetColor(1029, 669)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv9L"

        color := PixelGetColor(951, 507)
        color2 := PixelGetColor(1148, 737)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv7L"

        color := PixelGetColor(1224, 469)
        color2 := PixelGetColor(668, 655)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv9L2"

        color := PixelGetColor(953, 503)
        color2 := PixelGetColor(755, 662)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapLv9L3"

        color := PixelGetColor(1143, 582)
        color2 := PixelGetColor(716, 587)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapForestLv9"
            
        color := PixelGetColor(709, 526)
        color2 := PixelGetColor(1201, 661)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapForestLv16"
            
        color := PixelGetColor(1189, 508)
        color2 := PixelGetColor(584, 798)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapForestLv16v2"
            
        color := PixelGetColor(461, 697)
        color2 := PixelGetColor(781, 499)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapForestLv16v3"
            
        color := PixelGetColor(1300, 615)
        color2 := PixelGetColor(606, 285)
        If (IsColorRoad(color) and IsColorRoad(color2))
            MapType := "MapForestLv21"
            
        color := PixelGetColor(1082, 438)
        color2 := PixelGetColor(749, 887)
        color3 := PixelGetColor(694, 653)
        color4 := PixelGetColor(1007, 759)
        If (IsColorRoad(color) and IsColorRoad(color2)
            and IsColorRoad(color3) and IsColorRoad(color4))
            MapType := "MapForestLv21v2"
            
    }

    ; close map
    Click(1777, 67)
    Sleep(1000)

    If (MapType == "unknown")
        MapType := "NA"
    TraceLog(Format("MapType={1}", MapType))
}
RandomRunMap(mapValue) {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)

    For pos In mapValue {
        If IsPosColorRoad(pos*) {
            Click(pos*)
        }
    }
    Sleep(3000)
}
MapLv9() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(966, 473)
    If (color == 0x909090)
    {
        Click(966, 473)
    }
    else
    {
        Click(730, 698)
    }
    Sleep(3000)
}
MapLv1() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1161, 594)
    If (color == 0x909090)
    {
        Click(1161, 594)
    }
    else
    {
        Click(551, 459)
    }
    Sleep(3000)
}
MapLv7() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(873, 441)
    If (color == 0x909090)
    {
        Click(873, 441)
    }
    else
    {
        Click(1059, 829)
    }
    Sleep(3000)
}
MapLv9L() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1023, 386)
    If (color == 0x909090)
    {
        Click(1023, 386)
    }
    else
    {
        Click(1029, 669)
    }
    Sleep(3000)
}
MapLv7L() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(951, 507)
    If (color == 0x909090)
    {
        Click(951, 507)
    }
    else
    {
        Click(1148, 737)
    }
    Sleep(3000)
}
MapLv9L2() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1224, 469)
    If (color == 0x909090)
    {
        Click(1224, 469)
    }
    else
    {
        Click(668, 655)
    }
    Sleep(3000)
}
MapLv9L3() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(953, 503)
    If (color == 0x909090)
    {
        Click(953, 503)
    }
    else
    {
        Click(755, 662)
    }
    Sleep(3000)
}
MapForestLv9() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1143, 582)
    If (color == 0x909090)
    {
        Click(1143, 582)
    }
    else
    {
        Click(716, 587)
    }
    Sleep(3000)
}
MapForestLv16() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(709, 526)
    If (color == 0x909090)
    {
        Click(709, 526)
    }
    else
    {
        Click(1201, 661)
    }
    Sleep(3000)
}
MapForestLv16v2() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1189, 508)
    If (color == 0x909090)
    {
        Click(1189, 508)
    }
    else
    {
        Click(584, 798)
    }
    Sleep(3000)
}
MapForestLv16v3() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(461, 697)
    If (color == 0x909090)
    {
        Click(461, 697)
    }
    else
    {
        Click(781, 499)
    }
    Sleep(3000)
}
MapForestLv21() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1300, 615)
    If (color == 0x909090)
    {
        Click(1300, 615)
    }
    else
    {
        Click(606, 285)
    }
    Sleep(3000)
}
MapForestLv21v2() {
    color := PixelGetColor(373, 849)
    If ((color & 0xF0F0F0) != 0xF0F0F0 )
        Return

    Click(1558, 223)
    Sleep(1000)
    color := PixelGetColor(1082, 438)
    If (color == 0x909090)
    {
        Click(1082, 438)
    }
    else
    {
        Click(749, 887)
    }
    Sleep(3000)
}

IsAppCrash() {
    color := PixelGetColor(212, 204)
    If (color != 0x4285F4)
    {
        Return False
    }
    color := PixelGetColor(256, 205)
    If (color != 0xFBBC04)
    {
        Return False
    }
    Return True
}

^!x:: ; Control+Alt+X hotkey.
{
    global MapType
    global UniqueID
    TraceLog("Start")
    
    While True
    {
        WinActivate(UniqueID)
        If IsFighting()
        {
            OutputDebug("is fighting")
            color := PixelGetColor(1224, 952)
            If ((color & 0xD0D0D0) != 0xD0D0D0)
            {
                ; 前後衛調換
                Click(1104, 933)
                Sleep(200)
            }

            Click(1262, 921)
            Sleep(200)
            Click(1497, 924)
            Sleep(3000)
        }
        If IsFightingResult()
        {
            OutputDebug("is fighting result")
            Loop 3
            {
                ; click not work
                ; Click(1351, 783)
                MouseClick "WheelUp", 1351, 783
                Sleep(200)
            }
        }
        If IsOutside()
        {
            OutputDebug("is outside")
            
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
                Case "MapForestLv21v2":
                    ; 森林之地區域-赫爾米宣亞府邸地下
                    MapForestLv21v2()
            }

            If MapDefineds.Has(MapType) {
                RandomRunMap(MapDefineds.Get(MapType))
            }
        }

        If IsAppCrash()
        {
            TraceLog("app is crash")
            ; launch app
            Click(1649, 197)
            ; wait tap to start
            Loop 180
            {
                color := PixelGetColor(1605, 960)
                If (color == 0x000000 or color == 0xFFFFFF)
                {
                    Sleep(1000)
                    Continue
                }
                If (color == 0x2C2A20)
                {
                    Click(959, 819)
                    Sleep(20000)
                    Break
                }
                Sleep(1000)
            }
        }
        
        Sleep(1000)
    }

    ; TakeScreenshot(0, 0)
    TraceLog("Exit While")
}
^!z:: ; Control+Alt+Z hotkey.
{
    TraceLog("Stopped")
    ExitApp
}