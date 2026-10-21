#!/usr/bin/env bash
# mint-sharp-fonts.sh — Apply a sharp font rendering profile for Fontconfig on Linux Mint 22.3.
# This sets hintfull, antialiasing, LCD filtering, and RGB subpixel rendering.
# Run as your normal user (not root). A backup of any existing config is created.

set -euo pipefail

CONFIG_DIR="${HOME}/.config/fontconfig"
CONFIG_FILE="${CONFIG_DIR}/fonts.conf"

# Ensure fontconfig is installed (usually present by default on Mint)
if ! command -v fc-cache &> /dev/null; then
    echo "fontconfig is not installed. Installing..."
    sudo apt update && sudo apt install -y fontconfig
fi

# Create the config directory if it doesn't exist
mkdir -p "${CONFIG_DIR}"

# Backup an existing fonts.conf once (with a timestamp)
if [[ -f "${CONFIG_FILE}" ]]; then
    cp -v "${CONFIG_FILE}" "${CONFIG_FILE}.bak.$(date +%Y%m%d%H%M%S)"
fi

# Write the sharp font configuration
cat > "${CONFIG_FILE}" <<'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <!-- Sharp fonts profile -->
  <match target="font">
    <!-- Enable antialiasing (keeps edges smooth at the subpixel level) -->
    <edit name="antialias" mode="assign"><bool>true</bool></edit>

    <!-- Disable embedded bitmaps to prefer scalable outline rendering -->
    <edit name="embeddedbitmap" mode="assign"><bool>false</bool></edit>

    <!-- Enable hinting -->
    <edit name="hinting" mode="assign"><bool>true</bool></edit>

    <!-- Full hinting: aligns glyphs to the pixel grid for maximum sharpness.
         If it looks too distorted, try "hintmedium" or "hintslight". -->
    <edit name="hintstyle" mode="assign"><const>hintfull</const></edit>

    <!-- Use the default LCD filter (works well on most LCD/OLED panels) -->
    <edit name="lcdfilter" mode="assign"><const>lcddefault</const></edit>

    <!-- Subpixel rendering order. Set to "rgb" for most monitors.
         For a BGR panel, change to "bgr". For grayscale, use "none". -->
    <edit name="rgba" mode="assign"><const>rgb</const></edit>
  </match>
</fontconfig>
EOF

echo "Wrote sharp font configuration to: ${CONFIG_FILE}"
echo "Refreshing font cache..."
fc-cache -fv

echo "Done. Restart your applications (or log out/in) to see the effect."

