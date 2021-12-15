# Vim-WSL-Copy-Paste

This Vim plug-in adds mappings in `WSL` (Windows Subsystem for Linux) to write and read on the Microsoft Windows clipboard (`c`):

- to copy (yank) to the Windows clipboard by

    - `cy` (followed by a text object), `cY` (yank from cursor to end of line) and `cyy` (yank the whole line) in normal mode
    - `Y` in visual mode

- to paste from the Windows clipboard by

    - `cp` and `cP` (copy to the line before or after the cursor line) in normal mode
    - `P` in visual mode

Relies on [vim-repeat](https://github.com/tpope/vim-repeat) for repeatability by the `.` command.

# Related

The repository [win-bash-xclip-xsel](https://github.com/Konfekt/win-bash-xclip-xsel) contributes a small Shell script to make `xclip` and `xsel` in `WSL` (or Git Bash) read and write on the Microsoft Windows clipboard instead of the Linux clipboard.

