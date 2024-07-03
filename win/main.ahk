#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode  Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
Process, Priority,, Realtime
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

; Define the home directory using A_AppData built-in variable
global homeDirectory := SubStr(A_AppData, 1, InStr(A_AppData, "\AppData")-1)

ActivateOrLaunchWinTerminal() {
    Process, Exist, WindowsTerminal.exe
    if ErrorLevel = 0
    {
        Run, %A_ProgramFiles%\WindowsApps\Microsoft.WindowsTerminal_1.14.1962.0_x64__8wekyb3d8bbwe\wt.exe
    } else {
        IfWinActive, ahk_exe WindowsTerminal.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe WindowsTerminal.exe
        }
    }
}

ActivateOrLaunchChrome() {
    Process, Exist, chrome.exe
    if ErrorLevel = 0
    {
        Run, %A_ProgramFiles%\Google\Chrome\Application\chrome.exe
    } Else {
        IfWinActive, ahk_exe chrome.exe
        {
            WinMinimize
        } Else {
            WinActivate, ahk_exe chrome.exe
        }
    }
}

ActivateOrLaunchFireFox() {
    IfWinExist, ahk_exe firefox.exe
    {
        IfWinActive, ahk_exe firefox.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe firefox.exe
        }
    } Else {
        Run, C:\Program Files\Mozilla Firefox\firefox.exe
    }
}

ActivateOrLaunchVivaldi() {
    Process, Exist, vivaldi.exe
    if ErrorLevel = 0
    {
        Run, %homeDirectory%\AppData\Local\Vivaldi\Application\vivaldi.exe
    } Else {
        IfWinActive, ahk_exe vivaldi.exe
        {
            WinMinimize
        } Else {
            WinActivate, ahk_exe vivaldi.exe
        }
    }
}

ActivateOrLaunchVSCodeInsider() {
    Process, Exist, Code - Insiders.exe
    if ErrorLevel = 0
    {
        Run, %homeDirectory%\AppData\Local\Programs\Microsoft VS Code Insiders\Code - Insiders.exe
    } Else {
        IfWinActive, ahk_exe Code - Insiders.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe Code - Insiders.exe
        }
    }
}

ActivateOrLaunchEdge() {
    Process, Exist, msedge.exe
    if ErrorLevel = 0
    {
        Run, C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
    } Else {
        IfWinActive, ahk_exe msedge.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe msedge.exe
        }
    }
}

ActivateOrLaunchVSCode() {
    Process, Exist, Code.exe
    if ErrorLevel = 0
    {
        Run, "%homeDirectory%\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    } Else {
        IfWinActive, ahk_exe Code.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe Code.exe
        }
    }
}

ActivateOrLaunchTeams() {
    Process, Exist, Teams.exe
    if ErrorLevel = 0
    {
        Run, %homeDirectory%\AppData\Local\Microsoft\Teams\Update.exe
    } Else {
        IfWinActive, ahk_exe Teams.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe Teams.exe
        }
    }
}

ActivateOrLaunchOutlook() {
    ; Process, Exist, olk.exe
    Process, Exist, OUTLOOK.EXE
    if ErrorLevel = 0
    {
        ; Run, C:\Users\hasegawa-f.ES-DOMAIN\AppData\Local\Microsoft\WindowsApps\olk.exe
        Run, C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE
    } Else {
        ; IfWinActive, ahk_exe olk.exe
        IfWinActive, ahk_exe OUTLOOK.EXE
        {
            WinMinimize
        } else {
            ; WinActivate, ahk_exe olk.exe
            WinActivate, ahk_exe OUTLOOK.EXE
        }
    }
}

ActivateOrLaunchObsidian() {
    Process, Exist, Obsidian.exe
    if ErrorLevel = 0
    {

        Run, %homeDirectory%\AppData\Local\Obsidian\Obsidian.exe
    } Else {
        IfWinActive, ahk_exe Obsidian.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe Obsidian.exe
        }
    }
}

ActivateOrLaunchSlack() {
    Process, Exist, slack.exe
    if ErrorLevel = 0
    {
        Run, %homeDirectory%\AppData\Local\slack\slack.exe
    } Else {
        IfWinActive, ahk_exe slack.exe
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe slack.exe
        }
    }
}

/*
 * explorerはwidnowsの中でもかなり特殊なアプリなので、単純にexplorer.exeを使っての判定は不可能。
 * ahk_class CabinetWClassを使うとうまくいく。
*/
ActivateOrLaunchExplorer() {
    IfWinExist, ahk_class CabinetWClass
    {
        IfWinActive, ahk_class CabinetWClass
        {
            WinMinimize
        } else {
            WinActivate, ahk_class CabinetWClass
            WinWait, ahk_class CabinetWClass
            ; windowsが表示された直後はキーボードによる操作が不可能な状態なので、
            ; 操作可能にするための工夫を入れる
            Sleep 500
            Send, ^l{Esc}
        }
    } Else {
        Run, explorer.exe
    }
}

ActivateOrLaunchExcel() {
    IfWinExist, ahk_exe EXCEL.EXE
    {
        IfWinActive, ahk_exe EXCEL.EXE
        {
            WinMinimize
        } else {
            WinActivate, ahk_exe EXCEL.EXE
        }
    } Else {
        Run, C:\Program Files\Microsoft Office\Root\Office16\EXCEL.EXE
    }
}

OpenRDP() {
    ; リモデを開く
    Run, C:\WINDOWS\system32\mstsc.exe
    WinWait, ahk_exe mstsc.exe, , 3
    Send, {Enter}
    ; パスワードを入力する画面が表示されるのを待つ。
    ; いい感じの方法を見つけるのが面倒だったので雑にsleepする。
    Sleep 3000
    EnvGet, rdPasswd, RD_PASSWD
    Send, %rdPasswd%{Tab}{Tab}{Enter}
}

+!t::
    ActivateOrLaunchWinTerminal()
Return

+!v::
    ActivateOrLaunchVSCode()
Return

+!d::
    ActivateOrLaunchEdge()
Return

+!c::
    ActivateOrLaunchVSCodeInsider()
Return

+!l::
    ActivateOrLaunchOutlook()
Return

+!o::
    ActivateOrLaunchObsidian()
Return

+!m::
    ActivateOrLaunchTeams()
Return

+!s::
    ActivateOrLaunchSlack()
Return

+!g::
    ActivateOrLaunchChrome()
Return

+!j::
    ActivateOrLaunchVivaldi()
Return

+!f::
    ActivateOrLaunchExplorer()
Return

+!f::
    ActivateOrLaunchFireFox()
Return

+!x::
    ActivateOrLaunchExcel()
Return

^!+p::
    OpenRDP()
Return

+!r::
    Run, C:\tools\rapture-2.4.1\rapture.exe
Return

/**
 * 高速スクロール
 *
 * @hotkey [Shift]+Wheel
 * @target デフォルト
*/
+WheelUp::
    Send, {WheelUp 7}
Return

+WheelDown::
    Send, {WheelDown 7}
Return

+WheelRight::
    Send, {WheelRight 10}
Return

+WheelLeft::
    Send, {WheelLeft 10}
Return

/*
 * デバッグ用
*/
^!d::
    ; WinGetActiveTitle, Title
    ; MsgBox, The active window is "%Title%".

    ; MsgBox, A_AppData -> %A_AppData%
    ; MsgBox, A_AppDataCommon -> %A_AppDataCommon%
    ; MsgBox, A_Desktop -> %A_Desktop%
    ; MsgBox, A_DesktopCommon -> %A_DesktopCommon%
    ; MsgBox, A_MyDocuments -> %A_MyDocuments%
    ; MsgBox, A_ProgramFiles -> %A_ProgramFiles%
    ; MsgBox, A_StartMenu -> %A_StartMenu%
    ; MsgBox, A_StartMenuCommon -> %A_StartMenuCommon%
    ; MsgBox, A_Startup -> %A_Startup%
    ; MsgBox, A_StartupCommon -> %A_StartupCommon%
Return

^!r::
    Reload
Return

$Esc::
    ; 無変換を送信。Google日本語入力で無変換をIMEオフに設定している。
    ; 無変換は多くのアプリでEscape程影響少ないから、色んなアプリで使いやすい。
    Send, {sc07B}
    sleep, 0.1
    Send, {Esc}
Return
