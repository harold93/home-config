# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/code/seven/studio-server"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "server"

# Split window into panes.
#split_v 20
split_h 50

# Run commands.
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1
send_keys "rails s" 1
send_keys "./bin/dev -m worker=1,cable=1,node=1,postgres=1,redis=1" 2

# Set active pane.
#select_pane 0
