#!/usr/bin/env zsh
source $HOME/.config/sketchybar/vars.zsh

if [[ $1 == "setup" ]]; then
  NAME=front_app

  sketchybar                            \
    --add item $NAME $POSITION          \
    --set $NAME                         \
      script="$PLUGIN_DIR/front_app.zsh" \
      label.padding_left=$SPACE_2       \
      label.padding_right=$SPACE_2      \
      background.color=$BLACK_ALPHA     \
      background.padding_left=32        \
      label.color=$COLOR_ACTIVE         \
      label.drawing=on                  \
      icon.drawing=off                  \
    --subscribe front_app front_app_switched

fi

# UPDATE

sketchybar --set $NAME label="$INFO"