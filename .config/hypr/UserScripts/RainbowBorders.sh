#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for rainbow borders animation
#
# NOTE: `hyprctl keyword` was removed when the config moved to Lua. Gradients
# are now expressed as a table: { colors = {...}, angle = N }.

function random_hex() {
    echo "0xff$(openssl rand -hex 3)"
}

# Build a Lua list of 10 random colors
colors=""
for _ in $(seq 10); do
    colors+="\"$(random_hex)\", "
done

# rainbow colors only for active window
hyprctl eval "hl.config({ general = { col = { active_border = { colors = { ${colors} }, angle = 270 } } } })" >/dev/null

# rainbow colors for inactive window (uncomment to take effect)
# inactive=""
# for _ in $(seq 10); do inactive+="\"$(random_hex)\", "; done
# hyprctl eval "hl.config({ general = { col = { inactive_border = { colors = { ${inactive} }, angle = 270 } } } })" >/dev/null
