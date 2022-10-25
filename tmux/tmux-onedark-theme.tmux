#!/bin/bash
onedark_black=default
onedark_blue="#7ba2f3"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#41b59b"
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

tmux set-option -g status-style bg=default

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$onedark_black,bg=$onedark_black] #(/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 blue blue) #[fg=$onedark_lightgreen,bg=$onedark_black,bold]${time_format} #[fg=$onedark_yellow, bg=$onedark_black]#[fg=$onedark_red,bg=$onedark_yellow]"
set "status-left" "#[fg=$onedark_blue,bg=$onedark_black,bold] #S "

set "window-status-format" "#[fg=$onedark_visual_grey,bg=$onedark_black] #I) #W "
set "window-status-current-format" "#[fg=$onedark_blue,bg=$onedark_black,bold] #I) #{?window_zoomed_flag,#[fg=red](,}#W#{?window_zoomed_flag,#[fg=red]),}"
