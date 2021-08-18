#include <WinAPIFiles.au3>
#include <File.au3>
#include <Inet.au3>
#include <MsgBoxConstants.au3>

#RequireAdmin

;yolol installer script, using autoIT
;created by github.com/kylebyte
;requires autoit install, https://www.autoitscript.com/site/autoit/downloads/
;use any raw yolol code found on the internet, I have put ISAN URL in by default
;I recommend enable zoom in on YOLOL chip in settings
;Settings > Gameplay > Camera > Zoom in on YOLOL chip when editing


$message = "UNLOCK YOLOL CHIP AND DO NOT LOOK AWAY OR MOVE" & @CRLF & @CRLF & "github.com/kylebyte/StarBase" & @CRLF & @CRLF & "ISAN is default script"
$isanraw = "https://pastebin.com/raw/bJR6D6dd"

Main()

Func Main()
    $rawyolol = GetSourceYolol()

    if $rawyolol Then
        Sleep(20)
        WinActivate("Starbase")
        WinWaitActive("Starbase")

        Sleep(20)
        if WinActive("Starbase") Then
            MouseClick("Left")
            Sleep(50)
            Credits()
            YololInstall($rawyolol)
            SoundPlay("C:\Windows\media\Alarm03.wav",1)
        Else
            MsgBox("", "Error", "Error with active window", 1)
            Exit(1)
        EndIf
    Else
        MsgBox("","Error", "Something went wrong?", 2)
    EndIf
EndFunc

Func GetSourceYolol()
    $inputsource = InputBox("Yolol Installer", $message ,$isanraw)

    if $inputsource Then
        $source = _INetGetSource($inputsource)  
    Else
        MsgBox('', "error", "error with the URL or data")
        Exit(1)
    EndIf

    If $source Then
        Return $source
    Else
        MsgBox("", "Error", "Source file error. Might be empty?", 3)
        Exit(1)
    EndIf
    
EndFunc

Func YololInstall($source)
    Sleep(50)

    $file = "temp.yolol"
     
    _FileCreate($file)
    FileOpen($file)
    FileWrite($file,$source)

    if $file Then
        For $i = 1 to _FileCountLines($file)
            if WinActive("Starbase") Then
                $line = FileReadLine($file, $i)
                Send($line,1)
                Sleep(50)
                Send("{DOWN}")
            Else
                MsgBox("", "Error", "Error with active window", 1)
                Exit(1)
            EndIf
        Next
        FileClose($file)
        FileDelete($file)
    Else
        MsgBox('','err','err', 1)
    EndIf

    
EndFunc

Func Up20Lines()
    for $j = 1 to 20
        Send("{UP}") 
    Next
EndFunc

Func ClearLines()
    Opt("SendKeyDownDelay", 20)
    Up20Lines()
    Sleep(50)
    for $j = 1 to 20
        if WinActive("Starbase") Then
            Send("^a")
            Send("{DELETE}")
            Send("{DOWN}")
        Else
            MsgBox("", "Error", "Error with active window", 1)
            Exit(1)
        EndIf
    Next

    Opt( "SendKeyDownDelay", 10)
EndFunc

Func Credits()
    Sleep(50)

    Sleep(20)
    ClearLines()
    Up20Lines()

    if WinActive("Starbase") Then
        Send("YOLOL INSTALLER by github.com/kylebyte/StarBase")
        Sleep(1000)
        Opt( "SendKeyDownDelay", 30)
        Send("^a")
        Opt( "SendKeyDownDelay", 10)
        Sleep(50)
        Send("{DELETE}")
        Up20Lines()
    Else
        MsgBox("", "Error", "Error with active window", 1)
        Exit(1)
    EndIf
EndFunc


Func IsStarbaseActive()
    If WinActive("Starbase") Then 
        Return 1 
    Else 
        Return 0
    EndIf
EndFunc