#!/bin/bash

FFMPEG=ffmpeg
FFPROBE=ffprobe
CLIP_LENGTH=3
FPS=11

if [ -n "$1" ]
then
	echo "Video provided:" $1;
	# find out how long the video is
	duration_secs=$($FFPROBE -i "$1" -show_format 2>&1 | grep duration | awk -F "=" '{print $2}')
	# round to full seconds
	duration_secs=$( printf "%.0f" $duration_secs ) 
	# generate a random number between [0, duration_secs - 30)
	max_time=$(($duration_secs - $CLIP_LENGTH))
	start_time=$(( RANDOM % $max_time ))
	# ok now let that shit run
	# TODO: automatically determine narrowest bit of the image
	$FFMPEG -i "$1" -ss $start_time -t $CLIP_LENGTH -vf crop="234:234" clip.gif
fi
