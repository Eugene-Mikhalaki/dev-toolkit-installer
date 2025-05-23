# Dev Toolkit Installer for Ubuntu

This script automates the setup of a comprehensive toolkit for backend developers and DevOps engineers on an Ubuntu host.

## Features

*   Updates the system and installs essential packages.
*   Installs and configures Zsh with Oh My Zsh and the Powerlevel10k theme for an enhanced terminal experience.
*   Includes useful Zsh plugins:
    *   `zsh-autosuggestions`: Provides command suggestions as you type.
    *   `zsh-syntax-highlighting`: Enables syntax highlighting for commands in the terminal.
*   Installs Nerd Fonts (MesloLGS NF) for proper Powerlevel10k rendering.
*   Installs handy utilities:
    *   `bat`: A `cat` clone with syntax highlighting and Git integration.
    *   `lazydocker`: A terminal UI for Docker to manage containers and services.
    *   `yazi`: A fast terminal file manager with prefetching and preview capabilities.

## Quick Start

To download and run the installer script, open your terminal and execute the following command:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/dev_toolkit_installer.sh)"
```

### How to use the command:

1.  **Open your terminal:** Access the command line interface on your Ubuntu system.
2.  **Copy the command:** Select and copy the entire command line provided above.
3.  **Paste and execute:** Paste the copied command into your terminal and press Enter.
4.  **Follow prompts:** The script will run automatically. It may ask for your user password at certain points (e.g., for `sudo` commands like installing packages or changing the default shell).
5.  **Post-installation:**
    *   Restart your terminal or run `exec zsh` for the changes to take effect.
    *   If `Powerlevel10k` configuration wizard (`p10k configure`) doesn't start automatically on the first Zsh launch, you can run it manually with the command: `p10k configure`.
    *   Ensure your terminal emulator is configured to use the "MesloLGS NF" font for correct icon and prompt display.

Enjoy your new development environment! 