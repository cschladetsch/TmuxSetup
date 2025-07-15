# Tmux Themes

This directory contains color themes for tmux. Each theme modifies the appearance of the status bar, pane borders, and other visual elements.

## Available Themes

- **dark.conf** - Modern dark theme with high contrast
- **light.conf** - Clean light theme with soft colors

## Using a Theme

To apply a theme, add this line to your `~/.tmux.conf`:

```bash
# For dark theme
source-file ~/path/to/TmuxSetup/themes/dark.conf

# For light theme
source-file ~/path/to/TmuxSetup/themes/light.conf
```

Or source it dynamically:
```bash
# Press prefix + : and type
source-file ~/path/to/TmuxSetup/themes/dark.conf
```

## Creating Custom Themes

To create a custom theme:

1. Copy an existing theme as a template
2. Modify the color values (use `colour0` to `colour255`)
3. Test your theme in tmux
4. Save with a descriptive name

### Color Reference

Tmux uses the 256 color palette. You can view all colors by running:
```bash
for i in {0..255}; do printf "\x1b[38;5;${i}mcolour%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done
```

### Theme Elements

Key elements you can customize:
- `status-style` - Main status bar
- `window-status-style` - Inactive windows
- `window-status-current-style` - Active window
- `pane-border-style` - Inactive pane borders
- `pane-active-border-style` - Active pane border
- `message-style` - Command/message line

## Contributing Themes

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on submitting new themes.