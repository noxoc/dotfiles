#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.sh

if [[ $1 == "setup" ]]; then
  NAME=clock

  sketchybar                   \
    --add item $NAME $POSITION \
    --set $NAME                \
      update_freq=25           \
      script="$PLUGIN_DIR/clock.sh"

fi

# UPDATE

sketchybar --set $NAME label="$(date '+%d/%m %H:%M')"

