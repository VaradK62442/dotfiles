#!/bin/bash

current=$(hyprctl activeworkspace -j | jq '.id')
prev=$(hyprctl workspaces -j | jq -r --argjson cur "$current" '
  map(.id) | sort
  | (index($cur) // 0) as $i
  | if $i > 0 then .[$i-1] else .[-1] end
')
echo $prev
hyprctl dispatch workspace "$prev"
