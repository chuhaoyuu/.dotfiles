#!/bin/bash
onedark_black="#1a1b26"
onedark_blue="#7aa2f7"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_lightgreen="#38ff9c"
onedark_visual_grey="#202330"
onedark_comment_grey="#5c6370"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "150"
set "status-right-attr" "none"

set "message-fg" "$onedark_white"
set "message-bg" "$onedark_black"

set "message-command-fg" "$onedark_white"
set "message-command-bg" "$onedark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$onedark_black"
setw "window-status-bg" "$onedark_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$onedark_black"
setw "window-status-activity-fg" "$onedark_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$onedark_comment_grey"
set "window-active-style" "fg=$onedark_white"

set "pane-border-fg" "$onedark_white"
set "pane-border-bg" "$onedark_black"
set "pane-active-border-fg" "$onedark_green"
set "pane-active-border-bg" "$onedark_black"

set "display-panes-active-colour" "$onedark_yellow"
set "display-panes-colour" "$onedark_blue"

set "status-bg" "$onedark_black"
set "status-fg" "$onedark_white"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_green"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_green"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey] #(/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 blue blue)  #[fg=$onedark_lightgreen,bg=$onedark_visual_grey,bold]${time_format} #[fg=$onedark_yellow, bg=$onedark_visual_grey]#[fg=$onedark_red,bg=$onedark_yellow]"
# set "status-right" "#[fg=$onedark_black,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_green,bg=$onedark_visual_grey,bold] ${time_format} #[fg=$onedark_yellow, bg=$onedark_visual_grey]#[fg=$onedark_red,bg=$onedark_yellow]"
set "status-left" "#[fg=$onedark_blue,bg=$onedark_visual_grey,bold] #S #{prefix_highlight}#[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_comment_grey,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,bold,nounderscore,noitalics]#[fg=$onedark_blue,bg=$onedark_visual_grey,bold] #I  #{?window_zoomed_flag,#[fg=red](,}#W#{?window_zoomed_flag,#[fg=red]),} #[fg=$onedark_visual_grey,bg=$onedark_black,bold,nounderscore,noitalics]"
