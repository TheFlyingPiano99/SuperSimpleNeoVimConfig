-- Simple NeoVim editor configuration
-- As a Python LSP we use Ruff
-- For code highlighting we use nvim-treesitter
-- Our colortheme of choice is Catppuccin

---------------------------------------------

-- EDITOR SETTINGS


local set = vim.opt

set.hidden = true           -- Allows you to switch between buffers without needing to save the changes in the current buffer first 
set.swapfile = false        -- Swap file creation
set.backup = false          -- Backup file creation when saving
set.hlsearch = false        -- Highlight search results
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
--
require("config.lazy")

----------------------------------------------------

-- LSP CONFIGURATION (For linting.)

-- Python:
-- IMPORTANT: Ruff v5.3 (or higher version) must be installed separately!
require('lspconfig').ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
      configurationPreference = "filesystemFirst"
    }
  }
})

-- C/C++:
-- IMPORTANT: clangd must be installed separately!
require'lspconfig'.clangd.setup{}

---------------------------------------------

-- NVIM-TREESITTER (For code parsing.)

require'nvim-treesitter.configs'.setup{
  ensure_installed = {
    "c", "cpp", "lua", "vim", "vimdoc", "javascript", "html",
    "python", "toml", "markdown", "json", "xml", "yaml"
  },
  highlight={enable=true}
}

--------------------------------------------

-- DEBUG ADAPTER PROTOCOL
-- IMPORTANT: nvim-dap must be cloned like: git clone https://github.com/mfussenegger/nvim-dap.git ~/.config/nvim/pack/nvim/start/nvim-dap
rezquire("dap")

-- DAP setup for Python:
-- IMPORTANT: nvim-dap-python must be cloned like: git clone https://github.com/mfussenegger/nvim-dap-python.git ~/.config/nvim/pack/nvim/start/nvim-dap-python
require("dap-python").setup("python")
--------------------------------------------

-- LUASNIP

local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require("luasnip.loaders.from_vscode").lazy_load()


--------------------------------------------

-- COLOR SCHEME
-- IMPORTANT: catppuccin theme must be cloned like: git clone https://github.com/catppuccin/nvim.git ~/.config/nvim/pack/nvim/start/nvim-catppuccin

require("catppuccin")
vim.cmd("colorscheme catppuccin")

