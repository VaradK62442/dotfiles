#!/bin/bash

first=$(($1 * 2 - 1))
second=$(($1 * 2))
hyprctl dispatch workspace "$first"
sleep 0.05
hyprctl dispatch workspace "$second"
