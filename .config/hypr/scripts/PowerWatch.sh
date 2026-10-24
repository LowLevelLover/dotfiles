#!/usr/bin/env bash
# Re-applies PowerProfile.sh whenever AC is plugged or unplugged.
# udevadm blocks on a netlink socket, so this costs no wakeups while idle.

PROFILE="$HOME/.config/hypr/scripts/PowerProfile.sh"
hypr_socket="${XDG_RUNTIME_DIR:-/tmp}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket.sock"

# Single instance per Hyprland session
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/hypr-powerwatch-${HYPRLAND_INSTANCE_SIGNATURE:-none}.lock"
flock -n 9 || exit 0

"$PROFILE" auto

stdbuf -oL udevadm monitor --udev --subsystem-match=power_supply |
    while read -r line; do
        # Hyprland is gone (restart/logout): stop; udevadm exits on SIGPIPE
        [ -S "$hypr_socket" ] || exit 0
        case "$line" in
            *ADP0*|*ucsi-source*) "$PROFILE" auto ;;
        esac
    done
