# dotfiles

Uses [GNU Stow](https://www.gnu.org/software/stow/)

Walkthrough: https://www.youtube.com/watch?v=y6XCebnB9gs

```shell
apt install stow
```

Clone into home folder.  Remove existing versions of tracked .dotfiles (.bashrc, .gitconfig, etc.).  In dotfiles folder run the below command. This will symlink all the files into their correct locations.
```
stow .
```

Other tools installed
- [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file) - Git TUI
- [Delta](https://github.com/dandavison/delta?tab=readme-ov-file) - Git diff pager
- [JQ](https://jqlang.github.io/jq/) - JSON processing
- [zoxide](https://github.com/ajeetdsouza/zoxide) - cd replacement
- [eza](https://github.com/eza-community/eza) - ls replacement
- [tmux](https://github.com/tmux/tmux/wiki) - Terminal Multiplexer
- [neovim](https://neovim.io/) - Text editor
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [homebrew](https://docs.brew.sh/Homebrew-on-Linux) - Package manager
- [meld](https://github.com/GNOME/meld) - Diff and merge tool
