# Linux-sty-pluging.nvim 
Yet another plugin for setting up the linux coding style but in neovim.

This is a plugin for setting up the linux coding style in neovim. It is based on the [linux kernel coding style](https://www.kernel.org/doc/html/v6.9/process/coding-style.html) and an its original implementation [linux-coding-style](https://github.com/vivien/vim-linux-coding-style/tree/master). This plugin extend the original implementation by adding support to lua to align with neovim. 

## Important Remarks
This plugin is an effort to extent the linux-coding-style to supported by neovim. Therefore, it is still in development and may have some bugs. Developers are welcome to contribute to this project by reporting bugs and suggesting improvements.

## Installation
This plugin can be installed using any plugin manager. For example, using [vim-plug](https://github.com/junegunn/vim-plug?tab=readme-ov-file) or manually by cloning and copying the content of this repository to the nvim directory as a following:

```bash
git clone https://github.com/Daparrag/Linux-sty-pluging.nvim.git ~/.config/nvim/pack/plugins/start/linux-sty-plugin.nvim
```
Once you install this pluging it will apply the linux coding style to all c, cpp, and h files. It can be also applied by typing `:LinuxCodingStyle` in the command mode.


