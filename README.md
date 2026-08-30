# Setup

Install `stow` with:

```bash
brew install stow
```

Clone the project

Then use `stow` to make the proper symlinks...

```bash
cd ~/dotfiles
stow nvim p10k tmux karabiner
```

>[!NOTE]
> stow will not be able to overwrite existing directories, rename them to ex. nvim.bak to save a backup

For ghostty config use:

```bash
stow --target="$HOME/Library/Application Support/com.mitchellh.ghostty" ghostty
```

