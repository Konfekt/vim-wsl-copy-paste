# Vim-WSL-Copy-Paste

This Vim plug-in adds mappings in `WSL` (Windows Subsystem for Linux) to write and read on the Microsoft Windows clipboard (`c`):

- to copy (yank) to the Windows clipboard by

    - `cy` (followed by a text object), `cY` (yank from cursor to end of line) and `cyy` (yank the whole line) in normal mode
    - `Y` in visual mode

- to paste from the Windows clipboard by

    - `cp` and `cP` (copy to the line before or after the cursor line) in normal mode
    - `P` in visual mode

Because this implementation is currently rather simple, the text can only be pasted to the line, not character, right before or after the cursor position.
Pull requests are welcome!

# Related

The repository [xclip-xsel-WSL](https://github.com/Konfekt/xclip-xsel-WSL) contributes a small Shell script to make `xclip` and `xsel` in `WSL` (Windows Subsystem for Linux) read and write on the Microsoft Windows clipboard instead of the Linux clipboard.

