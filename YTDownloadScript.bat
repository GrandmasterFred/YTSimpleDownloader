@echo off
:: this will ask for url, and then the output format (can just be none)
:: and will download to current directory, and them move it to a new file
:: so that it looks cleaner 

call:programIntro

:: setting current directory 
set oriCD=%cd%

:: asks for youtube link (currently does not check if it is valid or not, might want to make it check), checks whether link is 
:: entered, and then clears error level regardless (using call )
set /p link="Enter YT link: "
call:errorCheckLink %ERRORLEVEL%, "Link not entered", "Link accepted and set as: %link%"
call 

:: asks for output format, currently i have only tested this with mp4 (since i only use mp4), other format like webm would probably also work
set /p format="Enter format (if none defaults to mp4): "
if %ERRORLEVEL% == 1 (
	call:fancyText "set as mp4" & set format=mp4) else (
		call:fancyText "Output format set as: %format%")
call 

:: asks the user if it is a livestream that is not started yet or not 
set /p live="Is this a scheduled stream? (defaults to no)(y/n): "
if %ERRORLEVEL% == 1 (
	call:fancyText "set as non scheduled (assume vod)" & set live=n & goto skip)
:: man i hate batch file lack of else if, goddamn
if %live%==y (
	call:fancyText "set as scheduled")
if %live%==n (
	call:fancyText "set as non scheduled (assume vod)")
if NOT %live%==n if NOT %live%==y (
	call:fancyText "set as non scheduled (assume vod)" & set live=n)
:skip
call 

cd %cd%\dependencies
:: uses yt-dlp to download the files needed, i can probably also make this use yt-archive to make it so that it can catch streams after they started
if %live%==y (goto isLive) 
if %live%==n (goto isNotLive)

:isNotLive
call:fancyText "Using link: %link% And converting into format: %format%", "Starting download using: yt-dlp -f bestvideo+bestaudio --merge-output-format %format% %link%"
yt-dlp -f bestvideo+bestaudio --merge-output-format %format% %link%
goto afterLive

:isLive
call:fancyText "Using link: %link% And converting into format: %format%", "Starting download using: yt-dlp -f best --merge-output-format %format% --wait-for-video 1-10 %link%"
yt-dlp -f best --merge-output-format %format% --wait-for-video 1-10 %link%
goto afterLive

:afterLive


:: this section moves the made file into a downloads folder, checks if file is downloaded, and if folder exists or not 
if NOT exist "%cd%\*.%format%" (echo Download failed & goto a)
if exist "%oriCD%\YTAutoDownloads\" (echo Moving file to downloads) else (echo Creating downloads folder & md "%oriCD%\YTAutoDownloads")
move /Y "%cd%\*.%format%" "%oriCD%\YTAutoDownloads"
call:fancyText "Download completed and moved"

if %ERRORLEVEL% == 0 (echo Program is probably successeful) else (echo echo Error thrown somewhere, program exiting)
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
	call:fancyText "Program created by Fred to download yt vods", "This specific one is made to download single videos, but i havent checked yet so eh"
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