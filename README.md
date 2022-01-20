# YTSimpleDownloader
 A quick and dirty downloader that uses yt-dlp and ffmpeg to download and convert youtube videos into a wanted format.
 
 To use this, just click on the .bat file and it will prompt you for stuff needed. 

Note that this utilizes [ffmpeg](https://www.ffmpeg.org/download.html) (for mixing if needed) and [yt-dlp](https://github.com/yt-dlp/yt-dlp) (for the actual downloading part), and two of the files **must** be placed at the same level as the .bat file.

The .bat file will ask for a youtube link (compulsary) and a output format (if none is provided, it defaults to mp4). Once done, it will check for output directory at the same level called "YTAutoDownloads", if it does not exist, it creates one and moves the downloaded video(s) into it. 
