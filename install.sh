#!/usr/bin/env bash
# Установка конфигурации. Существующие конфиги бэкапятся.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
BK="$HOME/config-backup-$(date +%Y%m%d-%H%M%S)"

c(){ printf '\033[36m>>\033[0m %s\n' "$*"; }
warn(){ printf '\033[33m!!\033[0m %s\n' "$*"; }

# каталог обоев из XDG, с откатом на ~/Pictures
PICTURES="$(xdg-user-dir PICTURES 2>/dev/null || true)"
[ -z "$PICTURES" ] && PICTURES="$HOME/Pictures"
WALLPAPERS="$PICTURES/Wallpapers"

c "бэкап в $BK"
mkdir -p "$BK"
for d in hypr kitty noctalia nvim systemd/user; do
  [ -e "$CFG/$d" ] && { mkdir -p "$BK/$(dirname "$d")"; cp -a "$CFG/$d" "$BK/$d"; }
done

c "Hyprland"
mkdir -p "$CFG/hypr/config"
cp -a "$SRC/hypr/hyprland.lua" "$CFG/hypr/"
cp -a "$SRC/hypr/config/." "$CFG/hypr/config/"

c "Noctalia"
mkdir -p "$CFG/noctalia/palettes" "$WALLPAPERS"
# город для погоды: автоопределение по IP врёт при включённом VPN
read -r -p "Город для виджета погоды [Moscow, Russia]: " CITY
[ -z "$CITY" ] && CITY="Moscow, Russia"
sed -e "s|__HOME__|$HOME|g" -e "s|__WALLPAPERS__|$WALLPAPERS|g" -e "s|__CITY__|$CITY|g" \
    "$SRC/noctalia/config.toml" > "$CFG/noctalia/config.toml"
cp -a "$SRC/noctalia/palettes/." "$CFG/noctalia/palettes/"

c "kitty"
mkdir -p "$CFG/kitty"
cp -a "$SRC/kitty/kitty.conf" "$CFG/kitty/"

c "Neovim"
mkdir -p "$CFG/nvim/colors" "$CFG/nvim/lua/plugins"
cp -a "$SRC/nvim/init.lua" "$CFG/nvim/"
cp -a "$SRC/nvim/colors/." "$CFG/nvim/colors/"
cp -a "$SRC/nvim/lua/plugins/." "$CFG/nvim/lua/plugins/"

c "скрипт синхронизации RGB"
mkdir -p "$HOME/.local/bin"
cp -a "$SRC/bin/noctalia-rgb-sync" "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/noctalia-rgb-sync"

c "сервис OpenRGB"
mkdir -p "$CFG/systemd/user"
cp -a "$SRC/systemd/openrgb.service" "$CFG/systemd/user/"
if command -v openrgb >/dev/null 2>&1; then
  systemctl --user daemon-reload
  systemctl --user enable --now openrgb.service || warn "не удалось запустить openrgb.service"
else
  warn "openrgb не установлен — сервис не включён"
fi

c "применяем"
if command -v noctalia >/dev/null 2>&1; then
  noctalia config validate "$CFG/noctalia/config.toml" || warn "конфиг Noctalia не прошёл валидацию"
  noctalia msg config-reload >/dev/null 2>&1 || true
else
  warn "noctalia не установлена"
fi
command -v hyprctl >/dev/null 2>&1 && hyprctl reload >/dev/null 2>&1 || true

echo
c "ГОТОВО"
echo "  обои класть в: $WALLPAPERS"
echo "  бэкап прежних конфигов: $BK"
echo
echo "Дальше:"
echo "  1. положи обои в $WALLPAPERS и выбери их через Super+Shift+W"
echo "  2. цвета системы подстроятся автоматически"
