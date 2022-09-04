local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false
vim.o.completeopt = 'menuone,noselect'

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
vim.o.textwidth = 80

local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><Left>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><Right>', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><Down>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><Up>', opts)

require('packer').startup(function(use)
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
  use {
    's1n7ax/nvim-terminal',
    config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup({
        window = {
          position = 'botright',
          split = 'sp',
          width = 50,
          height = 15,
        },

        disable_default_keymaps = false,
        toggle_keymap = '<leader>t',
        window_height_change_amount = 2,
        window_width_change_amount = 2,
        increase_width_keymap = '<leader><leader>+',
        decrease_width_keymap = '<leader><leader>-',
        increase_height_keymap = '<leader>+',
        decrease_height_keymap = '<leader>-',
        terminals = {
          -- keymaps to open nth terminal
          {keymap = '<leader>1'},
          {keymap = '<leader>2'},
          {keymap = '<leader>3'},
          {keymap = '<leader>4'},
          {keymap = '<leader>5'},
        },
      })
    end,
  }
  use 'ThePrimeagen/vim-be-good'
  -- latex
  use {
    'ntessore/unicode-math.vim',
    config = function()
      -- vim.o.keymap = 'unicode-math'
    end
  }
  -- programming language things
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          "c",
          "julia",
          "markdown_inline",
          "markdown",
          "typescript",
          "html",
          "css",
          "scss",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = {'html'},
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end
  }

  -- selectors
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter'},
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
      vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua require("telescope.builtin").git_files()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
    end
  }
  -- lsp completion
  use {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
      }
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use {
    'hrsh7th/nvim-cmp',
    requires = {'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp'},
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          -- Use a sharp border with `FloatBorder` highlights
          border = "rounded"
        })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded"
        })

      local cmp = require('cmp')
      cmp.setup({
        window = {
          completion = { -- rounded border; thin-style scrollbar
            border = 'single',
            scrollbar = '║',
          },
          documentation = { -- no border; native-style scrollbar
            border = 'rounded',
            scrollbar = '',
            -- other options
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- elseif luasnip.expand_or_jumpable() then
              --  luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
              -- elseif luasnip.jumpable(-1) then
              --  luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = "nvim_lsp_signature_help" },
        })
      })
      local lspconfig = require('lspconfig')
      lspconfig.util.default_config = vim.tbl_deep_extend('force',
        lspconfig.util.default_config, {
          capabilities = require('cmp_nvim_lsp').update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          ),
        })

      local on_attach_1 = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end
      local on_attach_2 = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        if client.server_capabilities.documentFormattingProvider then
          local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
              vim.lsp.buf.format()
            end,
            group = au_lsp,
          })
        end
      end
      lspconfig.tsserver.setup {
        on_attach = on_attach_1,
      }
      lspconfig.eslint.setup {
        on_attach = on_attach_2,
      }
      lspconfig.jsonls.setup {
        filetypes = {"json", "jsonc"},
        settings = {
          json = {
            -- Schemas https://www.schemastore.org
            schemas = {
              {
                fileMatch = {"package.json"},
                url = "https://json.schemastore.org/package.json"
              },
              {
                fileMatch = {"tsconfig*.json"},
                url = "https://json.schemastore.org/tsconfig.json"
              },
              {
                fileMatch = {
                  ".prettierrc",
                  ".prettierrc.json",
                  "prettier.config.json"
                },
                url = "https://json.schemastore.org/prettierrc.json"
              },
              {
                fileMatch = {".eslintrc", ".eslintrc.json"},
                url = "https://json.schemastore.org/eslintrc.json"
              }
            }
          }
        }
      }

      vim.fn.sign_define('DiagnosticSignError', { text = "✗", texthl = "DiagnosticSignError", numhl = "" })
      vim.fn.sign_define('DiagnosticSignWarn', { text = "❗", texthl = "DiagnosticSignWarn", numhl = "" })
      vim.fn.sign_define('DiagnosticSignInfo', { text = "❓", texthl = "DiagnosticSignInfo", numhl = "" })
      vim.fn.sign_define('DiagnosticSignHint', { text = "✿", texthl = "DiagnosticSignHint", numhl = "" })
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focus = false,
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
      local opts = { silent = true, noremap = true }
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

      local telescope = require('telescope.builtin');
      vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
      vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)

    end
  }
  -- zettlekasten
  use {
    "mickael-menu/zk-nvim",
    requires = { 'telescope.nvim', 'hrsh7th/nvim-cmp' },
    config = function()
      local zk = require("zk")
      zk.setup({
        picker = "telescope",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          }
        }
      })
      local opts = { noremap=true, silent=true }
      vim.api.nvim_set_keymap("n", "<leader>zd", "<cmd>ZkNew { dir='daily' }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zN", "<cmd>ZkNew { dir = vim.fn.input('Dir: ') }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zo", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zt", "<cmd>ZkTags<CR>", opts)
      vim.api.nvim_set_keymap("n", "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
      vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
      vim.api.nvim_set_keymap("v", "<leader>zl", ":ZkLinks", opts)
      vim.api.nvim_set_keymap("v", "<leader>zb", ":ZkBacklinks", opts)
    end
  }
  -- writing
  use {
    "Pocco81/TrueZen.nvim",
    config = function()
      local true_zen = require("true-zen")
      true_zen.setup({
        modes = { -- configurations per mode
          ataraxis = {
            shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
            backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
            minimum_writing_area = { -- minimum size of main window
              width = 84,
              height = 44,
            },
            quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
            padding = { -- padding windows
              left = 52,
              right = 52,
              top = 0,
              bottom = 0,
            },
            callbacks = { -- run functions when opening/closing Ataraxis mode
              open_pre = nil,
              open_pos = nil,
              close_pre = nil,
              close_pos = nil
            },
          },
        },
        integrations = {
          lualine = true,
        }
      })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
