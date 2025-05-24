# Dev Toolkit Installer for Ubuntu

This script automates the setup of a comprehensive toolkit for backend developers and DevOps engineers on an Ubuntu host.

Этот скрипт автоматизирует установку полного набора инструментов для бэкенд-разработчиков и DevOps-инженеров на хост под управлением Ubuntu.

## Возможности / Features

Этот скрипт устанавливает и настраивает:
(This script installs and configures:)

*   **Zsh + Oh My Zsh + Powerlevel10k**: Современная и мощная оболочка с фреймворком для управления конфигурацией и красивой темой.
    *   (Modern and powerful shell with a configuration management framework and a beautiful theme.)
*   **Полезные плагины Zsh / Useful Zsh plugins**:
    *   `zsh-autosuggestions`: Предлагает команды во время набора. (Suggests commands as you type.)
    *   `zsh-syntax-highlighting`: Подсвечивает синтаксис команд. (Highlights command syntax.)
*   **Основные утилиты командной строки / Essential command-line utilities**:
    *   `bat`: Улучшенный `cat` с подсветкой синтаксиса. (An improved `cat` with syntax highlighting.) - [Документация](https://github.com/sharkdp/bat)
    *   `lazydocker`: Терминальный UI для Docker. (A terminal UI for Docker.) - [Документация](https://github.com/jesseduffield/lazydocker)
    *   `yazi`: Терминальный файловый менеджер. (A terminal file manager.) - [Документация](https://github.com/sxyazi/yazi)
    *   `htop`: Интерактивный просмотрщик процессов. (An interactive process viewer.) - [Документация](https://htop.dev/)
    *   `btop`: Современный просмотрщик ресурсов. (A modern resource monitor.) - [Документация](https://github.com/aristocratos/btop)
    *   `glances`: Обзорный монитор системы. (An overview system monitor.) - [Документация](https://nicolargo.github.io/glances/)
    *   `mtr-tiny`: Утилита для диагностики сети. (A network diagnostic tool.) - [Документация](https://www.bitwizard.nl/mtr/)
    *   `fzf`: Нечеткий поиск для командной строки. (A command-line fuzzy finder.) - [Документация](https://github.com/junegunn/fzf)
*   **Шрифты Nerd Fonts (MesloLGS NF)**: Для корректного отображения иконок в Powerlevel10k.
    *   (For correct icon display in Powerlevel10k.)
*   **Примеры использования / Usage Examples**: Подробные примеры для каждой утилиты можно найти в файле [`utility_examples.md`](./utility_examples.md).
    *   (Detailed examples for each utility can be found in [`utility_examples.md`](./utility_examples.md).)
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

## Установщик только для Zsh / Zsh-only Installer

Если вам нужен только Zsh со всеми настройками, плагинами и шрифтами, но без дополнительных утилит типа `bat`, `yazi`, `lazydocker` и т.д., вы можете использовать отдельный, более легкий скрипт.

(If you only need Zsh with all configurations, plugins, and fonts, but without additional utilities like `bat`, `yazi`, `lazydocker`, etc., you can use a separate, lighter script.)

**Что устанавливает / What it installs:**

*   Zsh
*   Oh My Zsh
*   Тему Powerlevel10k (и настраивает ее по умолчанию) / Powerlevel10k theme (and configures it by default)
*   Плагины / Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`
*   Шрифты Powerline и MesloLGS NF / Powerline fonts and MesloLGS NF
*   Настраивает `~/.zshrc` с плагинами и темой / Configures `~/.zshrc` with plugins and theme
*   Устанавливает Zsh как оболочку по умолчанию / Sets Zsh as the default shell
*   **Примеры использования / Usage Examples**: Примеры для Zsh и его плагинов также описаны в общем файле [`utility_examples.md`](./utility_examples.md).
    *   (Examples for Zsh and its plugins are also described in the general [`utility_examples.md`](./utility_examples.md) file.)

**Как запустить / How to run:**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Eugene-Mikhalaki/dev-toolkit-installer/main/zsh_config_installer.sh)"
```

Follow the on-screen prompts. After completion, restart your terminal or run `exec zsh`. 