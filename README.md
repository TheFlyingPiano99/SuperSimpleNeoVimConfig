# SuperSimpleNeoVimConfig
Super simple NeoVim configuration file focused on basic code development in Python or C/C++.


# Installation
Clone the content of this repository to `~/.config/nvim/` (on Linux or MacOS) or to `~/AppData/Local/nvim/` (on Windows)!

Install the Ruff LSP for Python development or install clangd for C/C++ development!

Download plug.vim:

On Linux:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

```

On Windows:
```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

Run NeoVim by `nvim`!

