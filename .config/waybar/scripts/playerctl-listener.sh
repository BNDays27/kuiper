#!/usr/bin/sh

echo $(playerctl metadata --format '{{artist}} - {{title}}') || echo "No music playing"
