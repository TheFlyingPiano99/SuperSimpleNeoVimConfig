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
      config = function()
        require'nvim-treesitter.configs'.setup{
          ensure_installed = {
            "c", "cpp", "python", "lua", "vim", "vimdoc", "javascript", "html",
            "css", "markdown", "json", "xml", "yaml", "toml", "latex"
          },
          highlight = {enable=true}
        }

        local function install_tree_sitter_cli()
          local handle = io.popen("tree-sitter --version")
          local result = handle:read("*a")
          handle:close()

          if result == "" then
            print("tree-sitter-cli not found. Installing...")

            -- Define the installation command for your system
            -- For example, using npm:
            local install_cmd = "npm install -g tree-sitter-cli"

            -- Run the command
            os.execute(install_cmd)

            -- Verify installation
            handle = io.popen("tree-sitter --version")
            result = handle:read("*a")
            handle:close()

            if result == "" then
              print("Failed to install tree-sitter-cli.")
            else
              print("tree-sitter-cli installed successfully.")
            end
          else
            --print("tree-sitter-cli is already installed: " .. result)
          end
        end

        -- Call the function during startup
        install_tree_sitter_cli()
        vim.cmd.so()

      end
    },
    {
      "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
      lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
      config = function()
        local lsp = require('lspconfig')
        -- Python:
        -- IMPORTANT: Ruff v5.3 (or higher version) must be installed separately!
        lsp.ruff.setup{
          -- Ruff language server settings go here
          configurationPreference = "filesystemFirst"
        }

        -- C/C++:
        -- IMPORTANT: clangd must be installed separately!
        lsp.clangd.setup{}
      end,
    },
    { 
      "rose-pine/neovim",
      name = "rose-pine",
      config = function()
        vim.cmd("colorscheme rose-pine")
      end
    },
  },
  -- automatically check for plugin updates:
  checker = { enabled = true },
  -- Configure any other settings here. See the documentation for more details.
})

