#!/bin/bash
echo "Testing below"
IFS='
'
for f in *.mkv; do 
    echo $f
    tracks=$(LANG=en_US.utf8 LANGUAGE=en_US.utf8 mkvmerge -i "$f" | tail --lines=+2)
    for track in $tracks; do
        echo $track
        if [[ "$track" =~ Track\ ID\ ([0-9]+).*subtitles\ \(([^\)]+)\) ]]; then 
        track_ID=${BASH_REMATCH[1]}
        track_type=${BASH_REMATCH[2]}
        case $track_type in 
        SubStationAlpha) ext=".ass";;
        SubRip) ext=".srt";;
        esac
        mkvextract tracks "$f" $track_ID:"${f%.*}$ext"
        fi
    done
done