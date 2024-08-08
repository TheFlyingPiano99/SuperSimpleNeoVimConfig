-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      opts = {},
      config = function()
        require'nvim-treesitter.configs'.setup{
          ensure_installed = {
            "c", "cpp", "lua", "vim", "vimdoc", "javascript", "html",
            "python", "toml", "markdown", "json", "xml", "yaml"
          },
          highlight={enable=true}
        }
      end
    },
    {
      "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
      lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
      config = function()
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
      end,
    },
    {
      'catppuccin/nvim',
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme catppuccin]])
      end
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
