#include <WinAPIFiles.au3>
#include <File.au3>
#include <Inet.au3>
#include <MsgBoxConstants.au3>

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
        WinActivate("Starbase")
        MouseClick("Left")
        Sleep(50)
        Credits()
        YololInstall($rawyolol)
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

    Return $source
EndFunc

Func YololInstall($source)
    $filename = "temp.yolol"
     
    _FileCreate($filename)
    FileWrite($filename,$source)

    $file = $filename
    FileOpen($file)

    if $file Then
        For $i = 1 to _FileCountLines($file)
            $line = FileReadLine($file, $i)
            ;MsgBox("","", $line, 1)
            Send($line)
            Sleep(50)
            Send("{DOWN}")
        Next
        FileClose($file)
        FileDelete($filename)
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
        Send("^a")
        Send("{DELETE}")
        Send("{DOWN}")
    Next

    Opt( "SendKeyDownDelay", 10)
EndFunc

Func Credits()
    Sleep(20)
    ClearLines()
    Up20Lines()

    Send("YOLOL INSTALLER by github.com/kylebyte/StarBase")
    Sleep(1000)
    Opt( "SendKeyDownDelay", 30)
    Send("^a")
    Opt( "SendKeyDownDelay", 10)
    Sleep(50)
    Send("{DELETE}")
    Up20Lines()
EndFunc
