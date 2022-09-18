#!/usr/bin/env bash 

script_version=1.1

check_command_exists() {
    which ${@} >/dev/null 2>&1 && return
}

install_package() {
    status_desc "Installing ${@}..."
    if check_command_exists dnf; then
        sudo dnf install -yq ${@}
    elif check_command_exists apt; then
        sudo apt install -y ${@}
    elif check_command_exists pacman; then
        sudo pacman -S --no-confirm --quiet ${@}
    elif check_command_exists brew; then
        sudo brew install ${@} --force --quiet
    else
        status_error "No compatible package manager found."
        exit
    fi

}

check_and_install() {
    status_desc "Checking if ${1} is installed..."
    if ! check_command_exists ${1}; then
        status_warning "${1} not installed!"
        install_package ${1}
    fi

    if check_command_exists ${1}; then
        status_ok "${1} has been successfully installed."
    else
        status_error "Failed to install ${1}!"
        exit
    fi
}

show_intro() {
    clear
    if ! check_command_exists figlet || ! check_command_exists lolcat; then
        echo "$(tput setaf 6 && tput bold)Zsh config installer$(tput sgr0)"
        echo -e "Installer v${script_version}\n"
        echo -e "(c) Beau Jean van Bemmel, 2022 - $(date "+%Y")\n"
        return
    fi

    echo "Zsh config installer" | figlet | lolcat
    echo -e "Installer v${script_version}\n"
    echo -e "(c) Beau Jean van Bemmel, $(date "+%Y")\n"
} >&2

status_desc() {
    echo -e "$(tput setaf 244 && tput bold)${@}$(tput sgr0) \n"
} >&2

status_error() {
    echo -e "$(tput setab 1 && tput setaf 0 && tput bold) ERROR! $(tput sgr0) ${1}\n"
    if [[ $(echo ${2} | wc -l) -gt 0 ]]; then
        status_desc ${2}
    fi
    return 1
} >&2

status_warning() {
    echo -e "$(tput setab 11 && tput setaf 0 && tput bold) WARN! $(tput sgr0) ${1}\n"
    if [[ $(echo ${2} | wc -l) -gt 0 ]]; then
        status_desc ${2}
    fi
} >&2

status_ok() {
    echo -e "$(tput setab 2 && tput setaf 0 && tput bold) OK! $(tput sgr0) ${1}\n"
    if [[ $(${2} | wc -l) -gt 0 ]]; then
        status_desc ${1}
    fi
} >&2

check_root() {
    current_user=$(whoami)

    if [ ${current_user} != 'root' ]; then
        status_warning "User not root!" "Password authentication might be required."
    else
        status_ok "User is root!"
    fi
}

# Initialization.
# Check for dependencies and permissions.
show_intro
sleep 3s

check_root
check_and_install sudo
check_and_install tmux
