-- Simple NeoVim editor configuration
-- As a Python LSP we use Ruff
-- As a C/C++ LSP we use clangd
-- For code highlighting we use nvim-treesitter
-- Our colorsheme of choice is Catppuccin

---------------------------------------------

-- EDITOR SETTINGS


local set = vim.opt

set.hidden = true           -- Allows you to switch between buffers without needing to save the changes in the current buffer first 
set.swapfile = false        -- Swap file creation
set.backup = false          -- Backup file creation when saving
set.hlsearch = true         -- Highlight search results
set.wrap = false            -- Wrap long lines
set.mouse = 'a'             -- Enable mouse usage in all modes
set.termguicolors = true    -- Enable 24-bit RGB color
set.scrolloff = 2           -- the minimum number of screen lines to keep above and below the cursor when scrolling through a buffer 
set.number = true           -- Enable line numbering
set.relativenumber = false  -- Absolute line numbering

set.tabstop = 2             -- The number of spaces that a tab character represents. This setting affects how tabs are displayed in the editor 
set.shiftwidth = 2          -- The number of spaces to use for each step of indentation 
set.softtabstop = 2         -- The number of spaces that a tab character represents when editing text
set.expandtab = true        -- Whether the tab key inserts spaces instead of a tab character.
                            -- When expandtab is enabled, pressing the tab key will insert a number of spaces equivalent to the tabstop value 

vim.g.netrw_winsize = 20    -- This option controls the size of the window used by netrw when it opens 
vim.g.netrw_banner = 0      -- Set netrw banner (disable)

---------------------------------------------

-- LAZY
require("config.lazy")

