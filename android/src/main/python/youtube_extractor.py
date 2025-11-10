import os
import yt_dlp


def get_best_audio(video_id):
    url = f"https://www.youtube.com/watch?v={video_id}"
    ydl_opts = {
        "format": "bestaudio/best",
        "quiet": True,
        "noplaylist": True,
        "extractor_args": {"youtube": {"player_client": ["android"]}},  # key change
        "outtmpl": "/sdcard/Music/%(title)s.%(ext)s",
        "postprocessors": [{
            "key": "FFmpegExtractAudio",
            "preferredcodec": "m4a",
            "preferredquality": "192",
        }],
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(url, download=True)
        file_path = ydl.prepare_filename(info)
        # postprocessor changes extension
        base, ext = os.path.splitext(file_path)
        if os.path.exists(base + ".m4a"):
            file_path = base + ".m4a"
        return file_path
    
def get_best_audio_url(video_id):
    url = f"https://www.youtube.com/watch?v={video_id}"
    ydl_opts = {
        "format": "bestaudio[ext=m4a]/bestaudio",
        "noplaylist": True,
        "quiet": True,
        "extract_flat": True,  # no download
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(url, download=False)
        # best audio format
        best_audio = info.get("url")  # this is the direct stream URL
        return best_audio

def get_best_audio_stream(video_id):
    url = f"https://www.youtube.com/watch?v={video_id}"
    ydl_opts = {
        "format": "bestaudio[ext=m4a]/bestaudio",
        "quiet": True,
        "skip_download": True,
        "extract_flat": False,
        "force_generic_extractor": False,
        "extractor_args": {"youtube": {"player_client": ["web"]}},
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(url, download=False)
        formats = info.get("formats", [])

        # Filter valid audio streams only
        audio_streams = [
            f for f in formats
            if f.get("acodec") not in (None, "none")
            and f.get("url")
            and f.get("tbr") is not None
        ]

        if not audio_streams:
            raise Exception("No valid audio streams found")

        # Pick the best bitrate stream
        best = max(audio_streams, key=lambda f: f.get("tbr", 0))
        return best.get("url")


