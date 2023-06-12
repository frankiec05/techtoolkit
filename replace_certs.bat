@echo off
ECHO Updating Certificates.. please wait..
"c:\Program Files\Lightspeed Systems\Smart Agent\makeca.exe" -dir %temp%\ >NUL
move /y %temp%\*.pem "c:\Program Files\Lightspeed Systems\Smart Agent" >NUL
certutil.exe -addstore root "c:\Program Files\Lightspeed Systems\Smart Agent\ca.pem" >NUL
net stop lssasvc >NUL
net start lssasvc >NUL
(goto) 2>nul & del "%~f0" >Nul