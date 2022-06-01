local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.o.guifont="Fira Code:h12"
vim.g.neovide_refresh_rate=120
vim.g.neovide_cursor_trail_length=0.05
vim.g.neovide_cursor_animation_length=0.08

vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false
vim.o.completeopt = 'menu,menuone,noselect'
vim.cmd([[autocmd FileType c,cpp let &makeprg='ninja -C .build']])
vim.cmd([[autocmd BufEnter *.c compiler gcc]])
vim.cmd([[au BufWritePre * :%s/\s\+$//e]])

vim.o.clipboard = 'unnamedplus'
vim.g.mapleader = ' '
vim.g.timeoutlen = 200
vim.o.lazyredraw = true
vim.o.scrolloff = 3
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.swapfile = false
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.modeline = true
vim.o.modelines = 1
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><Left>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><Right>', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><Down>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><Up>', opts)


require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nathom/filetype.nvim',
    config = function()
      require("filetype").setup({})
    end
  }
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end
  }
  use {
    's1n7ax/nvim-terminal',
    keys = { '<leader>t' },
    config = function()
      require('nvim-terminal').setup({
        window = {
          position = 'botright'
        },
        disable_default_keymaps = true
      })
      local opts = { silent = true, noremap = true }
      vim.api.nvim_set_keymap('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<cr>', opts)
    end
  }
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'},
    requires = {{'radenling/vim-dispatch-neovim', opt = true}},
  }
  use {'tpope/vim-fugitive', opt = true, cmd = {'Git'}}
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          {name = 'nvim_lsp'}
        }),
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }
      })
    end
  }
  use {
    'neovim/nvim-lspconfig',
    after='nvim-cmp',
    config = function()
      local lsp = require('lspconfig')
      local lsp_util = require('lspconfig.util')
      local signs = {
        { name = "DiagnosticSignError", text = "❌" },
        { name = "DiagnosticSignWarn", text = "⚠" },
        { name = "DiagnosticSignHint", text = "💡" },
        { name = "DiagnosticSignInfo", text = "ℹ"},
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          active = signs,
        },
      })
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Mappings.
        local opts = { noremap=true, silent=true }

        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('v', 'a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('i', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        buf_set_keymap('v', 'f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
      end

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      lsp.clangd.setup{
        cmd = { 'clangd', '--enable-config' },
        on_attach = on_attach,
        capabilities = capabilities
      }

    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    after='tokyonight.nvim',
    config = function()
      local util = require("tokyonight.util")
      local wombat = require'lualine.themes.tokyonight'
      wombat.normal.a.bg = util.darken("#7aa2f7", 0.5)
      wombat.normal.b.bg = util.darken("#3b4261", 0.3)
      wombat.insert.a.bg = util.darken("#9ece6a", 0.5)
      wombat.insert.b.bg = util.darken("#3b4261", 0.3)
      wombat.command.a.bg = util.darken("#e0af68", 0.6)
      wombat.command.b.bg = util.darken("#3b4261", 0.3)
      wombat.visual.a.bg = util.darken("#bb9af7", 0.5)
      wombat.visual.b.bg = util.darken("#3b4261", 0.3)
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = wombat,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'filename','diagnostics'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'location'},
        }
      }
    end
  }
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    opt = true,
    cmd = {'Telescope'},
    keys = {'<C-p>', '<C-g>', '<C-b>'},
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require("telescope.actions")
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<esc>"] = actions.close
            }
          }
        },
        pickers = {
        },
        extensions = {
        }
      }
      local opts = { silent = true, noremap = true }
      vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
    end
  }
  -- use 'dstein64/vim-startuptime'

  if packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  profile = {
    enable = false,
    threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  }
}})
