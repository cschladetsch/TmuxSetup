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
TPM_PATH="$HOME/.tmux/plugins"
BACKUP_DIR="$HOME/.tmux-backup"
RESURRECT_DIR="$HOME/.tmux/resurrect"

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

remove_tmux_config() {
    if [ -f "$TMUX_CONFIG" ]; then
        print_info "Removing tmux configuration..."
        rm -f "$TMUX_CONFIG"
        print_success "Tmux configuration removed"
    else
        print_info "No tmux configuration found at $TMUX_CONFIG"
    fi
}

remove_tpm_and_plugins() {
    if [ -d "$TPM_PATH" ]; then
        read -p "Remove Tmux Plugin Manager and all plugins? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Removing TPM and plugins..."
            rm -rf "$TPM_PATH"
            print_success "TPM and plugins removed"
        else
            print_info "Keeping TPM and plugins"
        fi
    fi
}

remove_resurrect_sessions() {
    if [ -d "$RESURRECT_DIR" ]; then
        read -p "Remove saved tmux sessions? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Removing saved sessions..."
            rm -rf "$RESURRECT_DIR"
            print_success "Saved sessions removed"
        else
            print_info "Keeping saved sessions"
        fi
    fi
}

restore_backup() {
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        print_info "Found backup configurations:"
        ls -la "$BACKUP_DIR"/*.conf* 2>/dev/null | nl -v 0
        echo
        read -p "Restore a backup? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            read -p "Enter the number of the backup to restore (or press Enter to skip): " backup_num
            if [ -n "$backup_num" ]; then
                backup_file=$(ls "$BACKUP_DIR"/*.conf* 2>/dev/null | sed -n "$((backup_num + 1))p")
                if [ -f "$backup_file" ]; then
                    cp "$backup_file" "$TMUX_CONFIG"
                    print_success "Restored backup from: $backup_file"
                else
                    print_error "Invalid selection"
                fi
            fi
        fi
    else
        print_info "No backups found in $BACKUP_DIR"
    fi
}

clean_backup_directory() {
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        read -p "Remove all backup files? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$BACKUP_DIR"
            print_success "Backup directory cleaned"
        fi
    fi
}

kill_tmux_sessions() {
    if tmux list-sessions &>/dev/null; then
        print_warning "Active tmux sessions detected:"
        tmux list-sessions
        echo
        read -p "Kill all tmux sessions? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            tmux kill-server
            print_success "All tmux sessions terminated"
        else
            print_info "Keeping tmux sessions active"
        fi
    fi
}

show_completion_message() {
    echo
    print_success "Tmux configuration uninstalled!"
    echo
    if [ -f "$TMUX_CONFIG" ]; then
        echo "Current configuration: $TMUX_CONFIG (restored from backup)"
    else
        echo "No tmux configuration present"
    fi
    echo
    echo "You can reinstall anytime by running:"
    echo "  ./scripts/install.sh"
}

# Main uninstall flow
main() {
    echo "======================================"
    echo "    Tmux Configuration Uninstaller    "
    echo "======================================"
    echo
    print_warning "This will remove the tmux configuration installed by this repository"
    echo
    read -p "Continue with uninstallation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Uninstallation cancelled"
        exit 0
    fi

    # Remove configuration
    remove_tmux_config

    # Remove TPM and plugins
    remove_tpm_and_plugins

    # Remove saved sessions
    remove_resurrect_sessions

    # Offer to restore backup
    restore_backup

    # Clean backup directory
    clean_backup_directory

    # Ask about killing sessions
    kill_tmux_sessions

    # Show completion message
    show_completion_message
}

# Run main function
main "$@"