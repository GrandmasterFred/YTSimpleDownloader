# YTSimpleDownloader
A quick and dirty downloader that uses yt-dlp and ffmpeg to download and convert youtube videos into a wanted format. Can also be used to wait for a scheduled stream to start, and download it as it goes, useful for unarchived streams.
 
To use this, just click on the .bat file and it will prompt you for stuff needed. 

Note that this utilizes [ffmpeg](https://www.ffmpeg.org/download.html) (for mixing the output format if needed) and [yt-dlp](https://github.com/yt-dlp/yt-dlp) (for the actual downloading part), [ytarchive](https://github.com/Kethsar/ytarchive) for downloading of currently running streams (currently still unimplemented). These are provided in the \dependencies folder. 

The .bat file will ask for a youtube link (compulsary) and a output format (if none is provided, it defaults to mp4). Once the downloads are done, it will be moved into the \downloads folder, stamped with the date and time downloaded. 

This works with playlists as well as far as i can tell, and also channel pages, where it will just download the whole channel if you so desire. 