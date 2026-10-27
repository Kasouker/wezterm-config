# wezterm-config

Ma config WezTerm : couleurs sombres et dorées, un fond d'écran par onglet, une barre d'onglets
([tabline.wez](https://github.com/michaelbrusegard/tabline.wez)), des raccourcis pour les panneaux et le compteur
[logtime](https://github.com/Kasouker/logtime.wezterm).

Elle va avec ma config Neovim ([nvim-config](https://github.com/Kasouker/nvim-config)) : même police, mêmes couleurs.

## Installation sous Linux (sans sudo)

Tout va dans ton dossier personnel (`~/.local`).

### 1. WezTerm

```bash
mkdir -p ~/.local/bin ~/.local/opt && cd ~/.local/opt
curl -fsSL -o wezterm.AppImage https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
chmod +x wezterm.AppImage
./wezterm.AppImage --appimage-extract >/dev/null && rm wezterm.AppImage && mv squashfs-root wezterm
ln -sf ~/.local/opt/wezterm/usr/bin/wezterm ~/.local/bin/wezterm
ln -sf ~/.local/opt/wezterm/usr/bin/wezterm-gui ~/.local/bin/wezterm-gui
cd ~
```

> L'AppImage est « dépliée » (`--appimage-extract`) : comme ça, elle n'a pas besoin de FUSE, souvent absent sans sudo.

Si `~/.local/bin` n'est pas encore dans ton `PATH` :

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc   # ou ~/.bashrc si tu es sous bash
exec $SHELL
```

### 2. La police (IosevkaTerm Nerd Font)

```bash
mkdir -p ~/.local/share/fonts/IosevkaTerm && cd ~/.local/share/fonts/IosevkaTerm
curl -fsSLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip
unzip -oq IosevkaTerm.zip && rm IosevkaTerm.zip && fc-cache -f && cd ~
```

### 3. La config

Si tu as déjà une config WezTerm, mets-la de côté :

```bash
[ -d ~/.config/wezterm ] && mv ~/.config/wezterm ~/.config/wezterm.bak
[ -f ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.wezterm.lua.bak
```

Puis :

```bash
git clone https://github.com/Kasouker/wezterm-config.git ~/.config/wezterm
```

### 4. Lancer

```bash
wezterm-gui &
```

Au premier lancement, WezTerm télécharge tout seul ses plugins (tabline et logtime) : il lui faut internet.

## Installation sous Windows

1. Installe WezTerm **nightly** : <https://wezterm.org/install/windows.html>.
2. Installe la police IosevkaTerm Nerd Font : télécharge
   [IosevkaTerm.zip](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip), dézippe,
   sélectionne les fichiers `.ttf`, clic droit → **Installer**.
3. Dans PowerShell :
   ```powershell
   git clone https://github.com/Kasouker/wezterm-config.git $HOME\.config\wezterm
   ```

Sous Windows, WezTerm ouvre directement **WSL (Ubuntu)**. Change `default_domain` dans `appearance.lua` si ta
distribution porte un autre nom (`wsl -l` dans PowerShell pour le voir).

## Raccourcis

| Touche | Action |
|---|---|
| `Ctrl+Shift+d` | Couper le panneau en deux, côte à côte |
| `Ctrl+Shift+e` | Couper le panneau en deux, l'un sous l'autre |
| `Ctrl+Shift+h j k l` | Aller au panneau de gauche / du bas / du haut / de droite |
| `Ctrl+Shift+w` | Fermer le panneau |
| `Ctrl+Shift+t` | Nouvel onglet |
| `F2` | Calendrier logtime |
| `F4` | Réglages logtime |

## Les fichiers

| Fichier | Rôle |
|---|---|
| `wezterm.lua` | Charge tout le reste |
| `appearance.lua` | Couleurs, police, transparence, WSL sous Windows |
| `wallpaper.lua` | Un fond d'écran au hasard par onglet, pris dans `wallpapers/` |
| `tabline.lua` | La barre d'onglets, avec le compteur logtime à droite |
| `keys.lua` | Les raccourcis |
| `logtime_plugin.lua` | Charge logtime depuis `~/Projet_Perso/logtime.wezterm` s'il existe, sinon depuis GitHub |

Pour changer de fonds d'écran : mets tes images (`.jpg`, `.jpeg` ou `.png`) dans `wallpapers/`.

## Désinstaller (Linux)

```bash
rm -rf ~/.config/wezterm ~/.local/opt/wezterm ~/.local/bin/wezterm ~/.local/bin/wezterm-gui
rm -rf ~/.local/share/wezterm ~/.local/share/fonts/IosevkaTerm && fc-cache -f
```
