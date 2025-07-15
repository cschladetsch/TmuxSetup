# Tmux Configuration Setup

A comprehensive tmux configuration that enhances productivity with intuitive key bindings, improved visual styling, and powerful session management features.

This repository contains a ready-to-use `.tmux.conf` file with sensible defaults and productivity enhancements.

## Features

- **Enhanced Navigation**: Vim-like pane navigation and resizing
- **Improved Prefix**: Changed from `Ctrl-b` to `Ctrl-a` for easier access
- **Mouse Support**: Full mouse support for pane selection and scrolling
- **Visual Improvements**: Custom status bar with session info and time
- **Session Persistence**: Automatic session saving and restoration (with plugins)
- **Smart Splits**: Maintains current directory when splitting panes
- **Copy Mode**: Vi-style copy mode with intuitive selection

## Installation

### Quick Install

```bash
git clone https://github.com/cschladetsch/TmuxSetup.git
cd TmuxSetup
./scripts/install.sh
```

### Manual Install

1. Clone this repository:
   ```bash
   git clone https://github.com/cschladetsch/TmuxSetup.git
   cd TmuxSetup
   ```

2. The repository includes the `.tmux.conf` file. Copy it to your home directory:
   ```bash
   cp .tmux.conf ~/.tmux.conf
   ```

3. (Optional) Install Tmux Plugin Manager (TPM) for additional plugins:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

4. Start tmux and install plugins (if using TPM):
   - Start a new tmux session: `tmux`
   - Press `Ctrl-a` + `I` to install plugins

## Key Bindings

### Prefix Key
- **Prefix**: `Ctrl-a` (changed from default `Ctrl-b`)

### Session Management
- `Ctrl-a` + `s` - List sessions
- `Ctrl-a` + `$` - Rename current session
- `Ctrl-a` + `d` - Detach from session

### Window Management
- `Ctrl-a` + `c` - Create new window (maintains current directory)
- `Ctrl-a` + `,` - Rename current window
- `Ctrl-a` + `n` - Next window
- `Ctrl-a` + `p` - Previous window
- `Ctrl-a` + `[0-9]` - Switch to window by number
- `Ctrl-h` - Previous window (quick switch)
- `Ctrl-l` - Next window (quick switch)

### Pane Management
- `Ctrl-a` + `|` - Split pane vertically
- `Ctrl-a` + `-` - Split pane horizontally
- `Ctrl-a` + `h/j/k/l` - Navigate panes (vim-style)
- `Ctrl-a` + `H/J/K/L` - Resize panes (5 units, repeatable)
- `Ctrl-a` + `z` - Toggle pane zoom
- `Ctrl-a` + `x` - Close current pane
- `Ctrl-a` + `Space` - Toggle between pane layouts

### Copy Mode
- `Ctrl-a` + `Enter` - Enter copy mode
- In copy mode:
  - `v` - Begin selection
  - `y` - Copy selection and exit
  - `h/j/k/l` - Navigate (vim-style)
  - `/` - Search forward
  - `?` - Search backward
  - `q` - Exit copy mode

### Other Useful Commands
- `Ctrl-a` + `r` - Reload tmux configuration
- `Ctrl-a` + `S` - Toggle pane synchronization (type in all panes)
- `Ctrl-a` + `C-k` - Clear pane history
- `Ctrl-a` + `?` - Show all key bindings

## Configuration Details

### General Settings
- **Base Index**: Windows and panes start at 1 (not 0)
- **History Limit**: 10,000 lines of scrollback
- **Escape Time**: 0ms for faster key response
- **256 Colors**: Full color support enabled
- **Mouse**: Enabled for all operations

### Status Bar
- **Position**: Bottom
- **Left**: Session name in green
- **Right**: Current date and time in cyan
- **Active Window**: Highlighted with bold text

### Plugins (with TPM)
- **tmux-sensible**: Sensible tmux defaults
- **tmux-resurrect**: Save and restore tmux sessions
- **tmux-continuum**: Automatic session saving

## Tips and Tricks

1. **Quick Pane Switching**: Hold `Ctrl-a` and press `h/j/k/l` repeatedly
2. **Synchronized Panes**: Use `Ctrl-a` + `S` to type the same command in multiple panes
3. **Session Persistence**: With plugins installed, sessions automatically save every 15 minutes
4. **Copy to System Clipboard**: In copy mode, selections are automatically copied to system clipboard (if supported)

## Troubleshooting

- **Prefix key not working**: Make sure no other application is capturing `Ctrl-a`
- **Colors look wrong**: Ensure your terminal supports 256 colors
- **Plugins not loading**: Run `Ctrl-a` + `I` to install plugins after adding TPM

## Customization

Feel free to modify `~/.tmux.conf` to suit your needs. After making changes:
1. Save the file
2. Either restart tmux or press `Ctrl-a` + `r` to reload the configuration

### Themes

The repository includes pre-built themes in the `themes/` directory:
- **Dark theme**: Modern dark colors with high contrast
- **Light theme**: Clean light colors for bright environments

To use a theme, add this to your `~/.tmux.conf`:
```bash
# For dark theme
source-file ~/path/to/TmuxSetup/themes/dark.conf
```

## Uninstallation

To remove the tmux configuration and restore any backups:
```bash
./scripts/uninstall.sh
```

## Requirements

- tmux 2.1+ (recommended: 3.0+)
- Terminal with 256 color support
- (Optional) git for installing TPM

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.