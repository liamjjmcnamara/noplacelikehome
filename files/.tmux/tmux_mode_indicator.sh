#!/usr/bin/env bash

__print_tmux_mode_indicator() {
  # Get values set by user in .tmux.conf or fallback to defaults
  local copy_mode_text="$(__get_tmux_option "@tmux_mode_indicator_copy_mode_text" "COPY")"
  local prefix_pressed_text="$(__get_tmux_option "@tmux_mode_indicator_prefix_pressed_text" "PREFIX")"
  local left_edge_character="$(__get_tmux_option "@tmux_mode_indicator_left_edge_character" "")"

  NORMAL_COLOUR="$(__get_tmux_option "@tmux_mode_indicator_background" "colour6")"
  NORMAL_COLOUR="colour136"
  COPY_COLOUR="$(__get_tmux_option "@tmux_mode_indicator_copy_background" "colour196")"
  local background="#{?pane_in_mode,${COPY_COLOUR},${NORMAL_COLOUR}}"
  local prefix_pressed_fg="$(__get_tmux_option "@tmux_mode_indicator_prefix_pressed_fg" "colour255")"
  local normal_fg="$(__get_tmux_option "@tmux_mode_indicator_normal_fg" "#000000")"

  local left_edge_char="#[fg=${background}]${left_edge_character}#[bg=${background},fg=${normal_fg}]"
  local prefix_indicator="#[bg=${background}]#{?client_prefix,#[fg=${prefix_pressed_fg}] ${prefix_pressed_text} ,#[fg=${normal_fg}]}"
  local normal_or_copy_indicator="#{?pane_in_mode, ${copy_mode_text} ,}"

  echo -n $left_edge_char
  echo -n $prefix_indicator
  echo -n $normal_or_copy_indicator
}

# Get tmux option or default value
__get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z $option_value ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

# Set tmux internal option to given value
__set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

# Replaces interpolation in sent string with tmux_mode_indicator
__do_interpolation() {
  local string="$1"
  local interpolated="${string/$tmux_mode_indicator_interpolation_string/$tmux_mode_indicator}"
  echo "$interpolated"
}

# Update internal tmux option using interpolation
__udpate_tmux_option_with_interpolation() {
  local option="$1"
  local option_value="$(__get_tmux_option "$option")"
  local new_option_value="$(__do_interpolation "$option_value")"
  __set_tmux_option "$option" "$new_option_value"
}

tmux_mode_indicator="$(__print_tmux_mode_indicator)"
tmux_mode_indicator_interpolation_string="\#{tmux_mode_indicator}"

main() {
  __udpate_tmux_option_with_interpolation "status-right"
}

main
