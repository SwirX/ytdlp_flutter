import yt_dlp

def get_best_audio_stream(video_id: str) -> str:
    ydl_opts = {"quiet": True, "format": "bestaudio/best"}
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(video_id, download=False)
        formats = info.get('formats', [])
        audios = [f for f in formats if f.get('acodec') != 'none' and 'url' in f]
        best = max(audios, key=lambda x: x.get('tbr', 0))
        return best['url']
