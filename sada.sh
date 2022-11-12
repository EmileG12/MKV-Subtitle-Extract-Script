#!/bin/bash
file_name=$1
mkvmerge -i "$file_name"

echo "Testing below"
tracks=$(LANG=en_US.utf8 LANGUAGE=en_US.utf8 mkvmerge -i "$file_name" | tail --lines=+2)
IFS='
'

for track in $tracks; do
    #echo $track
    if [[ "$track" =~ Track\ ID\ ([0-9]+).*subtitles\ \(([^\)]+)\) ]]; then 
    echo ${BASH_REMATCH[1]} ${BASH_REMATCH[2]}
    fi
done