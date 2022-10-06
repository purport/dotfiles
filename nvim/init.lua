local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.o.autowrite = true
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
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><Left>', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><Right>', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><Down>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><Up>', opts)
vim.api.nvim_set_keymap('n', '<M-.>', '<C-w>>', opts)
vim.api.nvim_set_keymap('n', '<M-,>', '<C-w><', opts)
vim.api.nvim_set_keymap('n', '<leader>=', '<cmd>vert res 87<CR>', opts)
vim.api.nvim_set_keymap('n', '[q', '<cmd>cp<CR>', opts)
vim.api.nvim_set_keymap('n', ']q', '<cmd>cn<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>ccl<CR>', opts)

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'gerw/vim-HiLinkTrace'
  use {
    'nathom/filetype.nvim',
    config = function()
      require("filetype").setup({})
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      local theme = require('theme').setup()

      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = theme.lualine,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {{'filename',path=1},'diagnostics'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'location'},
        }
      }
    end
  }
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
  use 'nvim-treesitter/playground'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          "c",
          "c_sharp",
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
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-dispatch'
  use {
    'radenling/vim-dispatch-neovim',
    requires = { 'tpope/vim-dispatch' }
  }
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup {}
    end
  }

  -- selectors
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      local actions = require('telescope.actions')
      local telescope = require('telescope')
      telescope.setup{
        defaults = {
          theme = 'dropdown',
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
          file_browser = {
            theme = 'dropdown',
            hijack_netrw = true
          }
        }
      }
      telescope.load_extension('file_browser')

      local opts = { silent = true, noremap = true }
      vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>lua require("telescope.builtin").find_files({no_ignore = false, hidden = true})<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua require("telescope.builtin").git_files()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
      vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", hidden = true, previewer = false, initial_mode = "normal", layout_config = { height = 40 } })<cr>', opts)
    end
  }
  use {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup({})
      require('mini.surround').setup({})
    end
  }
  -- lsp completion
  use {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {}
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

      -- local format_doc = function(client, bufnr, g)
      --   if client.server_capabilities.documentFormattingProvider then
      --     local au_lsp = vim.api.nvim_create_augroup(g, { clear = true })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       pattern = "*",
      --       callback = function()
      --         vim.lsp.buf.format()
      --       end,
      --       group = au_lsp,
      --     })
      --   end
      -- end

      lspconfig.tsserver.setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
      lspconfig.eslint.setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
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

      lspconfig.clangd.setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }

      local pid = vim.fn.getpid()
      local omnisharp_bin = "/home/purport/.local/omnisharp/OmniSharp"

      lspconfig.omnisharp.setup {
        cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }

      vim.fn.sign_define('DiagnosticSignError', { text = "✗", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
      vim.fn.sign_define('DiagnosticSignWarn', { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
      vim.fn.sign_define('DiagnosticSignInfo', { text = "❓", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
      vim.fn.sign_define('DiagnosticSignHint', { text = "✿", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
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
      vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)

    end
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.csharpier
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
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
  use 'Issafalcon/neotest-dotnet'
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'Issafalcon/neotest-dotnet'
    },
    config = function()
      local lib = require("neotest.lib")
      local DotnetNeotestAdapter = require("neotest-dotnet")
      DotnetNeotestAdapter.root = lib.files.match_root_pattern("*.sln")

      require("neotest").setup({
        adapters = {
          DotnetNeotestAdapter
        },
      })
      local function run_test_file() require("neotest").run.run(vim.fn.expand('%')) end
      local function run_test_suite() require("neotest").run.run({vim.fn.expand('%'), suite=true}) end
      local function toggle_summary() require("neotest").summary.toggle() end
      local function open_output() require("neotest").output.open() end

      local opts = { silent = true, noremap = true }
      -- vim.keymap.set('n', '<C-;><C-r>', run_test_file, opts)
      vim.keymap.set('n', '<C-;><C-r>', run_test_file, opts)
      vim.keymap.set('n', '<C-;><C-t>', run_test_suite, opts)
      vim.keymap.set('n', '<C-;><C-s>', toggle_summary, opts)
      vim.keymap.set('n', '<C-;><C-o>', open_output, opts)
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
