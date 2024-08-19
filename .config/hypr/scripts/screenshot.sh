#!/bin/bash

# Prompt user to take screenshot using grimshot
# grimshot save area | read screenshot_path
#
# echo "$screenshot_path"
#
# # Check if screenshot was taken successfully
# if [ -f "$screenshot_path" ]; then
#     # Open the screenshot in gwenview
#     gwenview "$screenshot_path" &
# else
#     echo "Error: Screenshot not taken or saved."
# fi

grimshot save area ~/hyprscreenshots/shot$(date +%d_%m_%y-%s).png > temp_file;

sleep 0.5

screenshot=$(<temp_file)

echo "$screenshot"

hyprctl dispatch exec "[float; size 90% 90%]" gwenview $screenshot &

rm temp_file
