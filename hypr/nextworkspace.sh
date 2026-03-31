#!/bin/bash

current=$(hyprctl activeworkspace -j | jq '.id')
next=$(hyprctl workspaces -j | jq -r --argjson cur "$current" '
  map(.id) | sort
  | (index($cur) // 0) as $i
  | if $i + 1 < length then .[$i+1] else .[0] end
')
hyprctl dispatch workspace "$next"
