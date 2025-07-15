#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TMUX_CONFIG="$HOME/.tmux.conf"
TPM_PATH="$HOME/.tmux/plugins/tpm"
BACKUP_DIR="$HOME/.tmux-backup"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_tmux_installed() {
    if ! command -v tmux &> /dev/null; then
        print_error "tmux is not installed. Please install tmux first."
        echo "Installation instructions:"
        echo "  Ubuntu/Debian: sudo apt-get install tmux"
        echo "  macOS: brew install tmux"
        echo "  Fedora: sudo dnf install tmux"
        exit 1
    fi
}

check_tmux_version() {
    local version=$(tmux -V | sed -E 's/tmux ([0-9]+\.[0-9]+).*/\1/')
    local required_version="2.1"
    
    if [ "$(printf '%s\n' "$required_version" "$version" | sort -V | head -n1)" != "$required_version" ]; then
        print_warning "tmux version $version is older than recommended version $required_version"
        echo "Some features might not work properly."
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        print_info "tmux version $version detected"
    fi
}

backup_existing_config() {
    if [ -f "$TMUX_CONFIG" ]; then
        print_info "Backing up existing tmux configuration..."
        mkdir -p "$BACKUP_DIR"
        local backup_file="$BACKUP_DIR/tmux.conf.$(date +%Y%m%d_%H%M%S)"
        cp "$TMUX_CONFIG" "$backup_file"
        print_success "Backup saved to: $backup_file"
    fi
}

install_tmux_config() {
    print_info "Installing tmux configuration..."
    cp "$REPO_DIR/.tmux.conf" "$TMUX_CONFIG"
    print_success "Tmux configuration installed to: $TMUX_CONFIG"
}

install_tpm() {
    if [ -d "$TPM_PATH" ]; then
        print_info "TPM already installed at $TPM_PATH"
    else
        print_info "Installing Tmux Plugin Manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
        print_success "TPM installed successfully"
    fi
}

install_plugins() {
    if [ -d "$TPM_PATH" ]; then
        print_info "Installing tmux plugins..."
        # Start tmux server if not running
        tmux start-server
        # Create a new session in detached mode
        tmux new-session -d -s temp_plugin_install
        # Install plugins
        tmux run-shell "$TPM_PATH/bindings/install_plugins"
        # Kill the temporary session
        tmux kill-session -t temp_plugin_install 2>/dev/null || true
        print_success "Plugins installed successfully"
    fi
}

show_post_install_message() {
    echo
    print_success "Tmux configuration installed successfully!"
    echo
    echo "Next steps:"
    echo "1. Start a new tmux session: tmux"
    echo "2. Press Ctrl-a + I to ensure all plugins are installed"
    echo "3. Press Ctrl-a + r to reload the configuration"
    echo
    echo "Key binding cheatsheet:"
    echo "  Prefix key: Ctrl-a (changed from default Ctrl-b)"
    echo "  Split vertical: Ctrl-a + |"
    echo "  Split horizontal: Ctrl-a + -"
    echo "  Navigate panes: Ctrl-a + h/j/k/l"
    echo "  Show all bindings: Ctrl-a + ?"
    echo
    echo "For more information, see the README.md file"
}

# Main installation flow
main() {
    echo "======================================"
    echo "    Tmux Configuration Installer      "
    echo "======================================"
    echo

    # Check prerequisites
    check_tmux_installed
    check_tmux_version

    # Backup existing configuration
    backup_existing_config

    # Install configuration
    install_tmux_config

    # Ask about TPM installation
    read -p "Install Tmux Plugin Manager (TPM) and plugins? (Y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        install_tpm
        install_plugins
    fi

    # Show success message
    show_post_install_message
}

# Run main function
main "$@"