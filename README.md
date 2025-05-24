# Dev Toolkit Installer for Ubuntu

This script automates the setup of a comprehensive toolkit for backend developers and DevOps engineers on an Ubuntu host.

Этот скрипт автоматизирует установку полного набора инструментов для бэкенд-разработчиков и DevOps-инженеров на хост под управлением Ubuntu.

## Features

*   Installs and configures Zsh with Oh My Zsh and the Powerlevel10k theme for an enhanced terminal experience.
*   Includes useful Zsh plugins:
    *   `zsh-autosuggestions`: Provides command suggestions as you type.
    *   `zsh-syntax-highlighting`: Enables syntax highlighting for commands in the terminal.
*   Installs Nerd Fonts (MesloLGS NF) for proper Powerlevel10k rendering.
*   Installs handy utilities:
    *   [`bat`](https://github.com/sharkdp/bat): A `cat` clone with syntax highlighting and Git integration.
    *   [`lazydocker`](https://github.com/jesseduffield/lazydocker): A terminal UI for Docker to manage containers and services.
    *   [`yazi`](https://github.com/sxyazi/yazi): A fast terminal file manager with prefetching and preview capabilities.
    *   [`htop`](https://htop.dev/): Interactive process viewer.
    *   [`btop`](https://github.com/aristocratos/btop): Modern and feature-rich system resource monitor.
    *   [`glances`](https://nicolargo.github.io/glances/): System-wide monitoring tool with a comprehensive overview.
    *   [`mtr`](https://www.bitwizard.nl/mtr/): Network diagnostic tool (script installs `mtr-tiny`).
    *   [`fzf`](https://github.com/junegunn/fzf): Command-line fuzzy finder for interactive filtering.
*   Optionally updates the system (`sudo apt update && sudo apt upgrade -y`) if the `-u` flag is provided.

## Quick Start & Usage

To download and run the installer script, open your terminal and use one of the following commands:

**Default (No System Update):**

This will run the script without performing a system-wide update (`apt update && apt upgrade`).

Эта команда запустит скрипт без выполнения общесистемного обновления (`apt update && apt upgrade`).

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/dev_toolkit_installer.sh)"
```

**With System Update (`-u` flag):**

This will first perform a system update and then proceed with the rest of the installation.

Эта команда сначала выполнит обновление системы, а затем приступит к остальной части установки.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/dev_toolkit_installer.sh)" "" -u
```

Alternatively, if you prefer to download the script first:

В качестве альтернативы, если вы предпочитаете сначала скачать скрипт:

1.  Download the script:
    ```bash
    curl -fsSLO https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/dev_toolkit_installer.sh
    ```
2.  Make it executable (optional, as you can run it with `bash script_name`):
    ```bash
    chmod +x dev_toolkit_installer.sh
    ```
3.  Run it:
    *   Without system update:
        ```bash
        ./dev_toolkit_installer.sh
        # or
        # bash dev_toolkit_installer.sh
        ```
    *   With system update:
        ```bash
        ./dev_toolkit_installer.sh -u
        # or
        # bash dev_toolkit_installer.sh -u
        ```

### How to use the commands:

1.  **Open your terminal:** Access the command line interface on your Ubuntu system.
2.  **Choose your command:** Select one of the commands above based on whether you want to perform a system update.
3.  **Copy the command:** Select and copy the entire command line.
4.  **Paste and execute:** Paste the copied command into your terminal and press Enter.
5.  **Follow prompts:** The script will run automatically. It may ask for your user password at certain points (e.g., for `sudo` commands like installing packages or changing the default shell).
6.  **Post-installation:**
    *   Restart your terminal or run `exec zsh` for the changes to take effect.
    *   If `Powerlevel10k` configuration wizard (`p10k configure`) doesn't start automatically on the first Zsh launch, you can run it manually with the command: `p10k configure`.
    *   Ensure your terminal emulator is configured to use the "MesloLGS NF" font for correct icon and prompt display.

Enjoy your new development environment!

## Zsh, Oh My Zsh & Powerlevel10k Setup Only

If you only want to set up an enhanced Zsh environment with Oh My Zsh, the Powerlevel10k theme, and useful plugins (autosuggestions, syntax highlighting) without installing all the other developer utilities, you can use a dedicated script.

Если вы хотите настроить только улучшенное окружение Zsh с Oh My Zsh, темой Powerlevel10k и полезными плагинами (автодополнения, подсветка синтаксиса) без установки всех остальных утилит для разработчиков, вы можете использовать специальный скрипт.

This script will install:
*   Zsh (and set it as the default shell)
*   Oh My Zsh
*   Powerlevel10k theme
*   MesloLGS NF fonts (recommended for Powerlevel10k)
*   `zsh-autosuggestions` plugin
*   `zsh-syntax-highlighting` plugin

**To run the Zsh configuration installer:**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/zsh_config_installer.sh)"
```

Follow the on-screen prompts. After completion, restart your terminal or run `exec zsh`. 