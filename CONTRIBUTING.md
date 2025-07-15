# Contributing to TmuxSetup

Thank you for your interest in contributing to TmuxSetup! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to be respectful and constructive in all interactions.

## How to Contribute

### Reporting Issues

1. Check if the issue already exists in the [Issues](https://github.com/yourusername/TmuxSetup/issues) section
2. If not, create a new issue with:
   - Clear, descriptive title
   - Detailed description of the problem
   - Steps to reproduce
   - Expected behavior
   - Actual behavior
   - System information (OS, tmux version)

### Suggesting Enhancements

1. Check existing issues and pull requests first
2. Open a new issue with the "enhancement" label
3. Describe the enhancement and its benefits
4. Provide examples if applicable

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit with clear messages (`git commit -m 'Add amazing feature'`)
6. Push to your fork (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Guidelines

### Code Style

- Use consistent indentation (2 spaces for shell scripts)
- Follow existing patterns in the codebase
- Comment complex configurations
- Keep lines under 80 characters when possible

### Testing

Before submitting:
1. Test the installation script on a clean system
2. Verify all key bindings work as documented
3. Check compatibility with tmux 2.1+
4. Test on different operating systems if possible

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- First line should be 50 characters or less
- Reference issues and pull requests when relevant

### Documentation

- Update README.md if adding new features
- Add inline comments for complex configurations
- Update CHANGELOG.md with your changes
- Ensure all key bindings are documented

## Adding New Features

When adding new features:
1. Discuss major changes in an issue first
2. Keep the configuration lightweight and fast
3. Maintain backwards compatibility when possible
4. Add feature toggles for optional functionality
5. Document all new key bindings

## Theme Contributions

When contributing themes:
1. Place theme files in the `themes/` directory
2. Use descriptive names (e.g., `solarized-dark.conf`)
3. Include screenshots in your pull request
4. Test with different terminal emulators
5. Document any special requirements

## Questions?

Feel free to open an issue for any questions about contributing.