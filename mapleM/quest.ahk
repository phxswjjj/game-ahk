#Include "../Utility/Common.ahk"

global AppTitle := "mapleM"
global UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug("[" AppTitle "] not found")
    Return
}

global WaitQuestStart_color := 0
global WaitQuestStart_time := 0

ClearQuestCompleted()
{
    pos := [1076, 932]
    color := PixelGetColor(pos*)
    If color = 0xEE7046 {
        TraceLog("ClearQuestCompleted")
        Sleep(500)
        Click(pos*)
        Sleep(500)
        Return True
    }
    Return False
}
QuestTalkContinue()
{
    pos := [1781, 739]
    color := PixelGetColor(pos*)

    pos2 := [1738, 736]
    color2 := PixelGetColor(pos2*)
    
    pos3 := [1682, 75]
    color3 := PixelGetColor(pos3*)

    pos4 := [1810, 1014]
    color4 := PixelGetColor(pos4*)
    If ((color & 0x202020) = 0x202020
        and (color2 & 0xE0E0E0) = 0xE0E0E0
        and color3 != 0xFFFFFF
        and color4 != 0xF2F2F2) {
        TraceLog("QuestTalkContinue")
        Click(pos*)
        Sleep(300)
        Return True
    }
    Return False
}
QuestTalkAccept()
{
    pos := [1737, 638]
    color := PixelGetColor(pos*)
    If (color = 0xEE7046) {
        TraceLog("QuestTalkAccept")
        Click(pos*)
        Sleep(300)
        Return True
    }
    Return False
}
WaitQuestStart()
{
    global WaitQuestStart_color
    global WaitQuestStart_times
    pos := [182, 317]
    color := PixelGetColor(pos*)

    If color = 0x09AE64 {
        pos2 := [556, 334]
        color2 := PixelGetColor(pos2*)
        If color2 = 0xFFFFFF {
            TraceLog("WaitQuestStart")
            Click(pos*)
            Sleep(300)
            Return True
        }
        
        ; 同一個位置顏色維持幾秒沒改變，接新任務
        pos2 := [637, 911]
        color2 := PixelGetColor(pos2*)
        If WaitQuestStart_color != color2 {
            WaitQuestStart_color := color2
            WaitQuestStart_times := 0
            Sleep(1000)
        } else {
            WaitQuestStart_times := WaitQuestStart_times + 1
            If WaitQuestStart_times > 3 {
                TraceLog("WaitQuestStart(2)")
                pos2 := [734, 318]
                color2 := PixelGetColor(pos2*)
                If color2 = 0x617A95 {
                    Click(pos2*)
                    Sleep(2000)
                } Else {
                    Click(pos*)
                }
                Sleep(2000)
                Return True
            }
        }
    }
    Return False
}

QuestSelect() {
    pos := [539, 689]
    color := PixelGetColor(pos*)

    pos2 := [693, 941]
    color2 := PixelGetColor(pos2*)
    If (color = 0x212121 
        and color2 = 0xEE7046) {
        TraceLog("QuestSelect")
        Click(694, 839)
        Sleep(300)
        Return True
    }
    Return False
}

ExexuteBuff() {
    pos := [1342, 928]
    color := PixelGetColor(pos*)
    If color = 0xEEDD00 {
        TraceLog("ExexuteBuff")
        Click(pos*)
        Sleep(300)
        Click(pos*)
        Sleep(3000)
        Return True
    }
    Return False
}

^!x:: ; Control+Alt+X hotkey.
{
    global UniqueID
    TraceLog("Start")

    While True
    {
        WinActivate(UniqueID)

        If ClearQuestCompleted() {
            Sleep(2000)
            ExexuteBuff()
            Continue
        }

        If WaitQuestStart()
            Continue
        If QuestTalkContinue()
            Continue
        If QuestTalkAccept()
            Continue
            
        If QuestSelect()
            Continue

        Sleep(1000)
    }
}

^!z:: ; Control+Alt+Z hotkey.
{
    TraceLog("Stopped")
    ExitApp
}