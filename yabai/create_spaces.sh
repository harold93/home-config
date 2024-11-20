#!/bin/sh

function setup_space {
  local idx="$1"
  local name="$2"
  local space=
  echo "setup space $idx : $name"

  space=$(yabai -m query --spaces --space "$idx")
  if [ -z "$space" ]; then
    yabai -m space --create
  fi

  yabai -m space "$idx" --label "$name"
}


setup_space 1 web
setup_space 2 notion
setup_space 3 figma
setup_space 4 messaging
setup_space 5 music
setup_space 6 code_rubymine
setup_space 7 code_android_studio
setup_space 8 terminal
setup_space 9 tmp_space

# Move spaces to the second display when it's connected
yabai -m space 6 --display 2
yabai -m space 7 --display 2
yabai -m space 8 --display 2
yabai -m space 9 --display 2
# Assign spaces to the second display
yabai -m display --add 2 --space 6
yabai -m display --add 2 --space 7
yabai -m display --add 2 --space 8
yabai -m display --add 2 --space 9
