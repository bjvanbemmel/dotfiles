#!/usr/bin/env bash 

script_version=1.0

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
        echo "$(tput setaf 6 && tput bold)Tmux config installer$(tput sgr0)"
        echo -e "Installer v${script_version}\n"
        echo -e "(c) Beau Jean van Bemmel, 2022 - $(date "+%Y")\n"
        return
    fi

    echo "Tmux config installer" | figlet | lolcat
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
check_and_install tar

status_desc "Checking for pre-existing files..."
if [ -f $HOME/.tmux.conf ]; then
    status_error "Found a pre-existing .tmux.conf file! Please remove this file before running the installer." "Exiting..."
    exit
fi

if [ -d $HOME/.tmux ]; then
    status_error "Found a pre-existing .tmux directory! Please remove this directory before running the intaller." "Exiting..."
    exit
fi

status_desc "Downloading tmux configuration files..."
if ! curl -O https://dotfiles.bjvanbemmel.nl/tmux/raws/.tmux.tar.gz; then
    status_error "Could not download the tmux configuration files!" "Exiting program..."
    exit
fi
status_ok "Successfully downloaded the tmux configuration files."

status_desc "Extracting tmux configuration files..."
if ! tar -xzf .tmux.tar.gz -C $HOME; then
    status_error "Could not extract the tmux configuration files!" "Exiting program..."
    exit
fi
status_ok "Successfully extracted the tmux configuration files."

status_desc "Removing remaining archive..."
if ! rm .tmux.tar.gz; then
    status_error "Could not remove remaining archive!" "Exiting program..."
    exit
fi
status_ok "Successfully removed the remaining archive."

status_desc "Checking for attached tmux session..."
if [[ $(echo $TMUX | wc -m) -gt 1 ]]; then
    status_warning "Attached tmux session detected." "Will source the new configs in-session..."

    if ! tmux source $HOME/.tmux.conf; then
        status_error "Could not source new tmux config!" "Proceeding..."
    else
        status_ok "Successfully sourced the config."
    fi
else
    status_ok "No attached tmux session found."
fi

status_ok "Finished installing!"
