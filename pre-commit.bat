@echo off
setlocal EnableDelayedExpansion
SET REPOS="%1"
SET REV=%2

SET maxbytes=2000000000

SET PATH=C:\Utils\svn;C:\Windows\System32

svnlook changed %REPOS% -t %REV% > C:\Utils\temp\svnlook%REV%.tmp

for /F delims^=^ eol^= %%i in (C:\Utils\temp\svnlook%REV%.tmp) do (
set "file=%%i"
set "file=!file:~4%!"
set "file=!file:\=/!"
>>C:\Utils\temp\svnfile%REV%.tmp echo !file!
)

for /F delims^=^ eol^= %%j in (C:\Utils\temp\svnfile%REV%.tmp) do (
set "line=%%j"
>>C:\Utils\temp\svnsize%REV%.tmp svnlook filesize -t %REV% %REPOS% "!line!"
)

for /F delims^=^ eol^= %%h in (C:\Utils\temp\svnsize%REV%.tmp) do (
set "size=%%h"
if !size! GEQ %maxbytes% (
 	echo One of the files you are trying to commit is larger than 2GB >&2
	echo To ensure SVN doesn't get bloated we limit max file sizes >&2
 	echo If you have any questions or need it pushed contact IT >&2
 	goto :error
	)
)

del C:\Utils\temp\svnlook%REV%.tmp
del C:\Utils\temp\svnfile%REV%.tmp
del C:\Utils\temp\svnsize%REV%.tmp
exit 0

:error
del C:\Utils\temp\svnlook%REV%.tmp
del C:\Utils\temp\svnfile%REV%.tmp
del C:\Utils\temp\svnsize%REV%.tmp
exit 1