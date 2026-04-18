# Configs [![Analytics](https://ga-beacon.appspot.com/UA-2694988-7/configs/readme?pixel)](https://github.com/yaru22/configs)
This repository, configs, is a collection of startup script files such as .emacs, .vimrc, .bashrc, .profile, etc.

## Usage

This repository is organized to be used with [GNU Stow](https://www.gnu.org/software/stow/).

### Installation

1. Install GNU Stow:
   - macOS: `brew install stow`
   - Ubuntu: `sudo apt-get install stow`

2. Run the installation script:
   ```bash
   ./run
   ```
   This will automatically stow common packages and OS-specific packages (bash-macos/ubuntu, etc.).

### Manual Stowing

You can manually stow specific packages:
```bash
stow -t ~ nvim
```

For Emacs, choose one of the available flavors:
```bash
stow -t ~ emacs-doom
```
