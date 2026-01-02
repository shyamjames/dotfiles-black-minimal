# dotfiles-black-minimal

A minimal, high-contrast, off-black Hyprland configuration designed for focus and aesthetic consistency.

## 🌑 Overview

![Desktop Preview](assets/fullscreen.png)

This setup is built around a "Minimal Off-Black" theme (#1a1a1a background and #e6e6e6 foreground). It uses **Hyprland** as the compositor, **Waybar** for the status bar, and **Kitty** as the terminal emulator.

### Core Components
- **Compositor:** [Hyprland](https://hyprland.org/)
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Status Bar:** [Waybar](https://github.com/Alexays/Waybar)
- **Application Launcher:** [Rofi](https://github.com/davatorium/rofi) (Wayland fork)
- **Logout Menu:** [wlogout](https://github.com/ArtsyWork/wlogout)
- **Notification Daemon:** [Dunst](https://dunst-project.org/)
- **Wallpaper Utility:** [Swaybg](https://github.com/swaywm/swaybg)
- **Idle/Lock:** [Hypridle](https://github.com/hyprwm/hypridle) & [Hyprlock](https://github.com/hyprwm/hyprlock)

## 🚀 Installation & Setup

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/dotfiles-black-minimal.git ~/dotfiles-black-minimal
```

### 2. Symlink the configuration
To use these configurations, you should symlink them to your `~/.config` directory. This allows you to keep the repository managed by git while the system uses the latest changes.

> [!IMPORTANT]
> Make sure to backup your existing configurations before running these commands.

```bash
# Create the config directory if it doesn't exist
mkdir -p ~/.config

# Symlink individual components
ln -s ~/dotfiles-black-minimal/hypr ~/.config/hypr
ln -s ~/dotfiles-black-minimal/kitty ~/.config/kitty
ln -s ~/dotfiles-black-minimal/waybar ~/.config/waybar
ln -s ~/dotfiles-black-minimal/rofi ~/.config/rofi
ln -s ~/dotfiles-black-minimal/wlogout ~/.config/wlogout
ln -s ~/dotfiles-black-minimal/dunst ~/.config/dunst
```

### 3. Dependencies
The following packages are required for this setup:

- `hyprland`
- `kitty`
- `waybar`
- `rofi-lbonn-wayland-git`
- `wlogout`
- `dunst`
- `swaybg`
- `hypridle`
- `hyprlock`
- `thunar`
- `ttf-cascadia-code-nerd`
- `brightnessctl`
- `playerctl`
- `hyprshot`
- `cliphist`

> [!NOTE]
> This setup uses **CaskaydiaCove Nerd Font Mono** for icons and text. Ensure it is installed for the UI to render correctly.

## ⌨️ Keybindings
| Key | Action |
| --- | --- |
| `Super + Return` | Open Kitty |
| `Super + Q` | Kill Active Window |
| `Super + E` | Open Thunar |
| `Super + A` | Open Rofi App Launcher |
| `Super + V` | Clipboard History (Rofi) |
| `Super + B` | Open Brave Browser |
| `Super + Backspace` | Power Menu (Rofi) |
| `Super + Shift + W` | Reload Waybar |
| `Print` | Screenshot Menu (Fullscreen/Window/Area) |
