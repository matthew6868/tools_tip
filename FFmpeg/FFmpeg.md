# FFmpeg tips

## 推送RTMP流

```shell
#!/bin/bash

for((;;)); do \
        ./ffmpeg.exe -re -i ./source.200kbps.768x320.flv \
        -vcodec copy -acodec copy \
        -f flv -y rtmp://192.168.105.99/ffmpeg/livestream; \
        sleep 1; \
done
```

## 转码AVC和MP3

```shell
$: ./ffmpeg.exe -re -i ./画江湖之不良人.mp4 -vcodec libx264 -r 29.97 -b:v 3000k -profile:v main -acodec libmp3lame -ac 2 -ar 44100 -ab 128000 -f flv -y rtmp://192.168.105.164/ffmpeg/livestream
```

## 推送RTSP流
```shell
#!/bin/bash

for((;;)); do \
        ./ffmpeg.exe -re -i ./source.200kbps.768x320.flv \
        -vcodec libx264 -r 29.97 -b:v 3000k -profile:v main -acodec libmp3lame -ac 2 -ar 44100 -ab 128000 \
        -f rtsp rtsp://172.18.34.123:1935/live/ffmpeg.sdp; \
        sleep 1; \
done
```


