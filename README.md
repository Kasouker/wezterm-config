# wezterm-config

Ma config WezTerm : couleurs sombres et dorées, un fond d'écran par onglet, une barre d'onglets
([tabline.wez](https://github.com/michaelbrusegard/tabline.wez)), des raccourcis pour les panneaux et le compteur
[logtime](https://github.com/Kasouker/logtime.wezterm).

Elle va avec ma config Neovim ([nvim-config](https://github.com/Kasouker/nvim-config)) : même police, mêmes couleurs.

## Installation sous Linux (sans sudo)

Une seule ligne à copier (elle marche aussi pour mettre à jour : relance-la quand tu veux) :

```bash
{ [ -f ~/.config/wezterm/install.sh ] || git clone https://github.com/Kasouker/wezterm-config.git ~/.config/wezterm; } && git -C ~/.config/wezterm pull -q && bash ~/.config/wezterm/install.sh
```

Le script `install.sh` met tout dans ton dossier personnel (`~/.local`) et saute ce qui est déjà là :

- **WezTerm** (version nightly), s'il n'est pas déjà installé ;
- la police **IosevkaTerm Nerd Font**, si elle n'est pas déjà installée ;
- `~/.local/bin` dans ton `PATH` (dans `~/.zshrc` et `~/.bashrc`, si besoin).

Ensuite :

- **Déjà dans WezTerm ?** Pas besoin de le relancer : `Ctrl+Shift+R` recharge la config.
- **Dans un autre terminal ?** Lance WezTerm avec `wezterm-gui &` (ou depuis le menu des applications).

Au premier lancement, WezTerm télécharge tout seul ses plugins (tabline et logtime) : il lui faut internet.

> Tu as déjà une config dans `~/.config/wezterm` ? Le `git clone` refusera de l'écraser : mets-la d'abord de côté
> avec `mv ~/.config/wezterm ~/.config/wezterm.bak`.

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
rm -rf ~/.local/share/wezterm ~/.local/share/fonts/IosevkaTerm ~/.local/share/applications/wezterm.desktop && fc-cache -f
```
