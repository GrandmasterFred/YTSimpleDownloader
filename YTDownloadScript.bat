@echo off
:: this will ask for url, and then the output format (can just be none)
:: and will download to current directory, and them move it to a new file
:: so that it looks cleaner 

:: asks for youtube link (currently does not check if it is valid or not, might want to make it check), checks whether link is 
:: entered, and then clears error level regardless (using call )
set /p link="Enter YT link: "
if %ERRORLEVEL% == 1 (echo link not entered & goto a) else (echo Link accepted and set as: %link%)
call 


:: asks for output format, currently i have only tested this with mp4 (since i only use mp4), other format like webm would probably also work
set /p format="Enter format: "
if %ERRORLEVEL% == 1 (echo set as mp4 & set format=mp4) else (echo Output format set as: %format%)
call 


:: uses yt-dlp to download the files needed, i can probably also make this use yt-archive to make it so that it can catch streams after they started
echo Using link: %link% And converting into format: %format%
yt-dlp -f bestvideo+bestaudio --merge-output-format %format% %link%


:: this section moves the made file into a downloads folder 
if exist YTAutoDownloads\ (echo Moving file to downloads) else (echo Creating downloads folder & md "YTAutoDownloads")
move /Y *.%format% "%cd%\YTAutoDownloads"

if %ERRORLEVEL% == 0 (echo Program is probably successeful) else (echo Error thrown somewhere, program exiting)
pause

:a
echo Program kermited due to error 