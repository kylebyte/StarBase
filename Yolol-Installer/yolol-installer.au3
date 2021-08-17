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


$isanraw = "https://pastebin.com/raw/bJR6D6dd"

Main()

Func Main()
    YololInstall(GetSourceYolol())
EndFunc

Func GetSourceYolol()
    $inputsource = InputBox("YololFromInet", "Put in the URL of raw yolol",$isanraw)

    if $inputsource Then
        $source = _INetGetSource($inputsource)  
    Else
        MsgBox('', "error", "error with the URL or data")
    EndIf

    Return $source
EndFunc

Func YololInstall($source)
    WinActivate("Starbase")
    Send(MouseClick)
    ClearLines()

    $filename = "temp.yolol"
     
    _FileCreate($filename)
    FileWrite($filename,$source)

    $file = $filename
    FileOpen($file)

    if $file Then
        WinActivate("Starbase")
        Send(MouseClick)
        Up20Lines()

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
    Opt( "SendKeyDownDelay", 20)
    Up20Lines()
    Sleep(50)
    for $j = 1 to 20
        ;Sleep(50)
        Send("^a")
        ;Sleep(50)
        Send("{DELETE}")
        ;Sleep(50)
        Send("{DOWN}")
    Next

    Opt( "SendKeyDownDelay", 10)
EndFunc