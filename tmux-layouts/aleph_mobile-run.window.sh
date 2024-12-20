# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/code/seven/aleph_mobile"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "run"

# Split window into panes.
#split_v 20
#split_h 50

# Run commands.
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1
send_keys "flutter run --dart-define=HOST_API=http://10.0.2.2:3000/api/v1 -d emulator-5554" 1

# Set active pane.
#select_pane 0
