#!/bin/bash

target="$1"
current=$(hyprctl activeworkspace -j | jq '.id')

if [ "$current" -eq "$target" ]; then
	hyprctl dispatch workspace previous
else
	hyprctl dispatch workspace "$target"
fi
