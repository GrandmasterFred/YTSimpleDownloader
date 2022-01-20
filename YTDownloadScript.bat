@echo off
:: this will ask for url, and then the output format (can just be none)
:: and will download to current directory, and them move it to a new file
:: so that it looks cleaner 



set /p link="Enter YT link: "

if %ERRORLEVEL% == 1 (echo link not entered & goto a) else (echo Link accepted and set as: %link%)

set /p format="Enter format: "
if %ERRORLEVEL% == 1 (echo set as mp4 & set format=mp4) else (echo Output format set as: %format%)

echo Using link: %link% And converting into format: %format%

yt-dlp -f bestvideo+bestaudio --merge-output-format %format% %link%

:: this section moves the made file into a downloads folder 
if exist YTAutoDownloads\ (echo Moving file to downloads) else (echo Creating downloads folder & md "YTAutoDownloads")
move /Y *.%format% "%cd%\YTAutoDownloads"

pause

:a
echo Program kermited due to error 