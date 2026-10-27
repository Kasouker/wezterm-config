#!/usr/bin/env bash
# install.sh : installe ce qu'il faut à la config sous Linux, sans sudo (tout dans ~/.local) :
# WezTerm (nightly) s'il est absent, la police IosevkaTerm Nerd Font si elle est absente, ~/.local/bin dans le PATH.
# À lancer après le clone : bash ~/.config/wezterm/install.sh (peut être relancé sans risque).
set -euo pipefail

BIN="$HOME/.local/bin"
OPT="$HOME/.local/opt"
FONTS="$HOME/.local/share/fonts/IosevkaTerm"
mkdir -p "$BIN" "$OPT"
export PATH="$BIN:$PATH"

step() { printf '\n\033[1;33m==> %s\033[0m\n' "$*"; }

step "WezTerm"
if command -v wezterm >/dev/null; then
	echo "déjà installé : $(wezterm --version)"
else
	# AppImage dépliée : pas besoin de FUSE, souvent absent sans sudo
	tmp=$(mktemp -d)
	curl -fsSL -o "$tmp/wezterm.AppImage" \
		https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
	chmod +x "$tmp/wezterm.AppImage"
	(cd "$tmp" && ./wezterm.AppImage --appimage-extract >/dev/null)
	rm -rf "$OPT/wezterm" && mv "$tmp/squashfs-root" "$OPT/wezterm"
	ln -sfn "$OPT/wezterm/usr/bin/wezterm" "$BIN/wezterm"
	ln -sfn "$OPT/wezterm/usr/bin/wezterm-gui" "$BIN/wezterm-gui"
	rm -rf "$tmp"
	# Pour que WezTerm apparaisse dans le menu des applications
	mkdir -p "$HOME/.local/share/applications"
	cat > "$HOME/.local/share/applications/wezterm.desktop" <<-EOF
		[Desktop Entry]
		Name=WezTerm
		Exec=$BIN/wezterm-gui
		Icon=$OPT/wezterm/usr/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png
		Type=Application
		Categories=System;TerminalEmulator;
	EOF
	echo "installé dans $OPT/wezterm"
fi

step "Police IosevkaTerm Nerd Font"
if ls "$FONTS"/IosevkaTermNerdFont-*.ttf >/dev/null 2>&1 || fc-list 2>/dev/null | grep -qi "IosevkaTerm Nerd"; then
	echo "déjà installée"
else
	mkdir -p "$FONTS"
	curl -fsSL -o "$FONTS/IosevkaTerm.zip" \
		https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip
	unzip -oq "$FONTS/IosevkaTerm.zip" -d "$FONTS" && rm "$FONTS/IosevkaTerm.zip"
	command -v fc-cache >/dev/null && fc-cache -f "$FONTS"
	echo "installée dans $FONTS"
fi

step "~/.local/bin dans le PATH"
# Le fichier de démarrage du shell utilisé (~/.zshrc sous zsh) est créé s'il n'existe pas encore
touch "$HOME/.$(basename "${SHELL:-/bin/bash}")rc"
for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
	if [ -e "$rc" ] && ! grep -q '\.local/bin' "$rc"; then
		printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$rc"
		echo "ajouté à $rc"
	fi
done

step "Terminé"
echo "Déjà dans WezTerm : Ctrl+Shift+R pour recharger la config."
echo "Sinon, lance-le : wezterm-gui &"
