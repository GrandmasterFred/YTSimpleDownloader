@echo off
:: this will ask for url, and then the output format (can just be none)
:: and will download to current directory, and them move it to a new file
:: so that it looks cleaner 

call:programIntro

:: asks for youtube link (currently does not check if it is valid or not, might want to make it check), checks whether link is 
:: entered, and then clears error level regardless (using call )
set /p link="Enter YT link: "
call:errorCheckLink %ERRORLEVEL%, "Link not entered", "Link accepted and set as: %link%"
call 

:: this section will copy all the dependencies into a file of its own, and do all the downloading in there 
:: checks for downloads folder and create or cd into it 
echo checking for downloads folder in %cd%
if NOT EXIST "%cd%\downloads" (echo Downloads folder does not exist, making it & md "%cd%\downloads")
:: copy stuff from dependencies into a dedicated folder, this is so that if there are multiple instances of this program running, it wont cause conflicts probably maybe hopefully, cause this was an issue when downloading a playlist and a standalone video before this commit 
set var1=%time::=_%
set var1=%var1:.=_%
set var2=%date:/=_%
set outputVar=downloadOutput%var2%__%var1%
md "%cd%\downloads\%outputVar%" 
xcopy /s "%cd%\dependencies" "%cd%\downloads\%outputVar%" 
cd %cd%\downloads\%outputVar%

:isLive
call:fancyText "Using link: %link%", "Starting download using: ytarchive --wait -r 30 %link% 1080p60/best/1080"
ytarchive --wait -r 30 %link% 1080p60/best/1080
goto afterLive

:: just something to skip to if not :isNotLive will run through :isLive
:afterLive

:: this section checks for whether the downloaded file exists or not, and removes the dependencies from the output folder 
call:fancyText "Removing dependencie files from downloaded folder"
del "*.exe"
if NOT exist "*.*" (echo Download failed & goto a)
call:fancyText "Download completed and moved"

if %ERRORLEVEL% == 0 (
	call:fancyText "Program is probably successeful") else (
		call:fancyText "Error thrown somewhere, program exiting")
pause
goto exit

:: note that apparently %~1 represents values passed over 
:fancyText 
	echo ============================================================
	echo %~1
	if NOT "%~2" == "" (echo %~2)
	if NOT "%~3" == "" (echo %~3)
	if NOT "%~3" == "" (echo %~3)
	echo ============================================================
	exit /b 0

:: fancy intro message 
:programIntro
	call:fancyText "Program created by Fred to download yt vods", "This specific one is made to download currently running streams, and will attempt to fetch the stream from before you start the recording via some magic from yt-archive.", "its like black magic" 
	exit /b 0

:: uses the error level to check for stuff, first param is errorlevel, second param is the error message, third is success message
:errorCheckLink
	if %~1 == 1 (
		call:fancyText "%~2" & pause & exit 1) else (
			call:fancyText "%~3")
	::echo Error level detected as %~1
	::echo %~2
	::echo %~3
	exit /b 0

:: for exiting 
:a
	echo Program kermited due to error 
	pause
	goto exit

:exit