# Dotfiles
My dotfiles for tools such as ***zsh, tmux, nvim*** etc. These dotfiles are accompanied by their respective custom-built installers.

## Installation
There are 2 different methods you can use. You can manually install the dotfiles by cloning the repository and placing the contents in their respective destinations, or you can make use of the installers. **Using the installers is recommended** because it will install any dependencies, fonts and place everything where necessary.

### Custom installers
Before moving on, please do note that the installers have only been tested on the following systems:
- **Fedora** (36)
- **Debian** (Bullseye)
- **Manjaro**

The installes does support the following package managers from the get-go:
- **DNF**
- **Apt**
- **Pacman**
- **Brew**

#### Usage
##### 1. Zsh
To install my **zsh** config, run the following command;
```bash
curl -s https://bjvanbemmel.nl/zsh/installer | bash
```

### Manual Installation
##### 1. Zsh
Run the following sequence of commands:
```bash
# On RHEL / Fedora
sudo dnf install zsh git
# On CentOS
sudo yum install zsh git
# On Debian / Ubuntu
sudo apt install zsh git
# On Arch / Manjaro
sudo pacman -S zsh git
# On MacOS
sudo brew install zsh git
# lolcat and figlet are optional dependencies.

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-vi-mode
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
# catppuccin-zsh-syntax-highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
mkdir ~/.zsh
cp -v zsh-syntax-highlighting/catppuccin-zsh-syntax-highlighting.zsh ~/.zsh/
rm -rf ./zsh-syntax-highlighting

# Dotfiles
git clone https://github.com/bjvanbemmel/dotfiles.github
cp -r dotfiles/zsh/raws/* ~/
```
Install the recommended fonts here using these instructions: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k.
## Upcoming dotfiles + installers
- **Nvim** (dotfiles + installer)
- **Tmux** (dotfiles + installer)
