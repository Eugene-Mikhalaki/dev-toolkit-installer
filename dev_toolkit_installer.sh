#!/bin/bash
# Прерывать выполнение скрипта при любой ошибке
set -e

# Обновление системы
echo "Обновление системы..."
sudo apt update && sudo apt upgrade -y

# Установка необходимых пакетов
echo "Установка базовых пакетов (zsh, git, curl, wget, fonts-powerline, unzip, snapd)..."
sudo apt install -y zsh git curl wget fonts-powerline unzip snapd

# Установка шрифтов Nerd Fonts (MesloLGS NF - рекомендован для Powerlevel10k)
echo "Установка шрифтов MesloLGS Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd - > /dev/null # Возвращаемся в предыдущую директорию молча
fc-cache -f -v # Обновляем кэш шрифтов

# Установка Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh уже установлен в $HOME/.oh-my-zsh. Пропускаем установку."
    # Можно добавить здесь `git -C $HOME/.oh-my-zsh pull` для обновления, если нужно
else
    echo "Установка Oh My Zsh..."
    # Устанавливаем без интерактивного запроса на смену оболочки, сделаем это позже явно
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Установка темы Powerlevel10k для Oh My Zsh
echo "Установка темы Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Установка полезных плагинов для zsh
echo "Установка плагинов zsh-autosuggestions и zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Конфигурация ~/.zshrc
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
# Добавляйте плагины с осторожностью, большое количество может замедлить запуск оболочки.
plugins=(
  git # Алиасы и функции для git
  zsh-autosuggestions # Предлагает команды во время набора (как в Fish)
  zsh-syntax-highlighting # Подсветка синтаксиса для командной строки
)

# Загрузка Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Пользовательская конфигурация Powerlevel10k (создается после `p10k configure`)
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

# Раскомментируйте, если нужно добавить ~/.local/bin в PATH и это не делается автоматически
# export PATH="$HOME/.local/bin:$PATH"
EOL

# Установка zsh как оболочки по умолчанию
echo "Установка zsh как оболочки по умолчанию..."
# Это может потребовать ввода пароля пользователя
chsh -s $(which zsh)

# Установка bat (улучшенный cat с подсветкой синтаксиса)
# Использование: bat <файл>
echo "Установка bat (улучшенный cat)..."
sudo apt install -y bat
# На некоторых системах (например, Ubuntu) bat устанавливается как batcat для избежания конфликта имен.
# Создаем симлинк для удобства.
mkdir -p ~/.local/bin
if [ -f /usr/bin/batcat ]; then
  ln -sf /usr/bin/batcat ~/.local/bin/bat
fi


# Установка lazydocker (терминальный UI для Docker)
# Использование: lazydocker
echo "Установка lazydocker..."
curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
    | grep "browser_download_url.*lazydocker_.*_Linux_x86_64.tar.gz" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi - -O lazydocker_latest_Linux_x86_64.tar.gz
tar xf lazydocker_latest_Linux_x86_64.tar.gz lazydocker
sudo mv lazydocker /usr/local/bin/
rm lazydocker_latest_Linux_x86_64.tar.gz

# Установка yazi (терминальный файловый менеджер)
# Использование: yazi
echo "Установка yazi (файловый менеджер)..."

# snapd должен был быть установлен на предыдущем шаге 'sudo apt install ... snapd'
if command -v snap &> /dev/null; then
    echo "Команда 'snap' доступна. Попытка установки yazi через snap..."
    # Иногда snap-демону нужно время или ядро должно быть обновлено для работы AppArmor/Seccomp.
    # Простая проверка, отвечает ли демон.
    if sudo snap list &> /dev/null; then
        sudo snap install yazi --classic
        if [ $? -ne 0 ]; then
            echo "Ошибка во время 'sudo snap install yazi --classic'."
            echo "Возможно, snapd требует дополнительной настройки или перезапуска системы/сервиса."
            echo "Вы можете попробовать выполнить 'sudo systemctl restart snapd' или перезагрузить систему."
        else
            echo "yazi успешно установлен через snap."
        fi
    else
        echo "Ошибка: команда 'snap' доступна, но 'snap list' не работает (демон snapd может быть не активен)."
        echo "Попробуйте активировать сервисы snapd (например, 'sudo systemctl start snapd.service snapd.socket') и запустить установку yazi вручную: sudo snap install yazi --classic"
        echo "Установка yazi через snap будет пропущена."
    fi
else
    echo "Ошибка: команда 'snap' не доступна даже после попытки установки snapd пакета."
    echo "Установка yazi через snap будет пропущена."
    echo "Проверьте логи установки snapd и убедитесь, что snapd корректно установлен и запущен."
fi


echo ""
echo "--------------------------------------------------------------------"
echo "Установка завершена!"
echo ""
echo "Что дальше:"
echo "1. Перезапустите ваш терминал или выполните 'exec zsh', чтобы изменения вступили в силу."
echo "2. При первом запуске zsh с Powerlevel10k, возможно, запустится конфигуратор 'p10k configure'."
echo "   Если нет, вы можете запустить его вручную командой: p10k configure"
echo "3. Убедитесь, что в настройках вашего терминала выбран шрифт 'MesloLGS NF' для корректного отображения."
echo ""
echo "Кратко об установленных утилитах:"
echo "  - zsh: Мощная оболочка, настроена с Oh My Zsh и темой Powerlevel10k."
echo "  - zsh-autosuggestions: Предлагает команды во время набора (нажмите → для автодополнения)."
echo "  - zsh-syntax-highlighting: Подсвечивает синтаксис команд в реальном времени."
echo "  - bat: Улучшенный 'cat'. Используйте: bat <файл>."
echo "  - lazydocker: Терминальный UI для Docker. Запуск: lazydocker."
echo "  - yazi: Терминальный файловый менеджер с предпросмотром. Запуск: yazi."
echo "--------------------------------------------------------------------"