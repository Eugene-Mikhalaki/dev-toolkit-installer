#!/bin/bash
# Прерывать выполнение скрипта при любой ошибке
set -e

echo "Установка Zsh, Oh My Zsh, Powerlevel10k и полезных плагинов..."

# 1. Установка необходимых пакетов
echo "Установка базовых пакетов (zsh, git, curl, wget, fonts-powerline)..."
sudo apt update # Минимальное обновление списка пакетов нужно перед установкой
sudo apt install -y zsh git curl wget fonts-powerline

# 2. Установка шрифтов Nerd Fonts (MesloLGS NF - рекомендован для Powerlevel10k)
echo "Установка шрифтов MesloLGS Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd - > /dev/null # Возвращаемся в предыдущую директорию молча
fc-cache -f -v # Обновляем кэш шрифтов

# 3. Установка Oh My Zsh
echo "Попытка установки/обновления Oh My Zsh..."
# Добавляем '|| true', чтобы команда не прерывала скрипт из-за 'set -e',
# если Oh My Zsh уже установлен (в этом случае его установщик выходит с ошибкой).
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# 4. Установка темы Powerlevel10k для Oh My Zsh
ZSH_CUSTOM_THEMES_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes
if [ -d "$ZSH_CUSTOM_THEMES_DIR/powerlevel10k" ]; then
    echo "Тема Powerlevel10k уже скачана. Пропускаем."
else
    echo "Установка темы Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_THEMES_DIR/powerlevel10k"
fi

# 5. Установка полезных плагинов для zsh
ZSH_CUSTOM_PLUGINS_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins

if [ -d "$ZSH_CUSTOM_PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "Плагин zsh-autosuggestions уже скачан. Пропускаем."
else
    echo "Установка плагина zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_PLUGINS_DIR/zsh-autosuggestions"
fi

if [ -d "$ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "Плагин zsh-syntax-highlighting уже скачан. Пропускаем."
else
    echo "Установка плагина zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_PLUGINS_DIR/zsh-syntax-highlighting"
fi

# 6. Конфигурация ~/.zshrc
echo "Конфигурация ~/.zshrc..."
cat > ~/.zshrc << 'EOL'
# Включение Powerlevel10k instant prompt для быстрой загрузки
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Путь к установке Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Настройка темы Powerlevel10k.
# Для кастомизации промпта выполните `p10k configure` или отредактируйте ~/.p10k.zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Список плагинов Oh My Zsh.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Загрузка Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Пользовательская конфигурация Powerlevel10k (создается после `p10k configure`)
# или если вы хотите, чтобы ~/.p10k.zsh создавался автоматически с дефолтными настройками
# для неинтерактивной установки, можно добавить 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet' перед source ~/.p10k.zsh
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

# Добавляем $HOME/.local/bin в PATH, если он существует, для пользовательских скриптов/бинарников
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
EOL

# 7. Установка zsh как оболочки по умолчанию
if [ "$(basename "$SHELL")" != "zsh" ]; then
  echo "Установка zsh как оболочки по умолчанию..."
  # Это может потребовать ввода пароля пользователя
  chsh -s $(which zsh)
  echo "Оболочка по умолчанию изменена на zsh. Изменения вступят в силу после перезапуска сессии."
else
  echo "zsh уже является оболочкой по умолчанию."
fi

echo ""
echo "--------------------------------------------------------------------"
echo "Установка Zsh, Oh My Zsh и Powerlevel10k завершена!"
echo "Installation of Zsh, Oh My Zsh, and Powerlevel10k completed!"
echo ""
echo "Что дальше:"
echo "What's next:"
echo "1. Перезапустите ваш терминал или выполните 'exec zsh', чтобы изменения вступили в силу."
echo "   (Restart your terminal or run 'exec zsh' for the changes to take effect.)"
echo "2. При первом запуске zsh с Powerlevel10k, возможно, запустится конфигуратор 'p10k configure'."
echo "   (On the first Zsh launch with Powerlevel10k, the 'p10k configure' wizard might start.)"
echo "   Если нет, вы можете запустить его вручную командой: p10k configure"
echo "   (If not, you can run it manually with the command: p10k configure)"
echo "3. Убедитесь, что в настройках вашего терминала выбран шрифт 'MesloLGS NF' для корректного отображения."
echo "   (Ensure that 'MesloLGS NF' font is selected in your terminal settings for correct display.)"
echo "--------------------------------------------------------------------" 