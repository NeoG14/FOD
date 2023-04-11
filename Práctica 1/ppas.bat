@echo off
SET THEFILE=c:\users\nicol\docume~1\facultad\fundam~1\prctic~1\ej1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o c:\users\nicol\docume~1\facultad\fundam~1\prctic~1\ej1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
