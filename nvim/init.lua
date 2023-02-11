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

-- vim.cmd [[source ~/.local/whitebox/whitebox_v0.99.0/editor_plugins/whitebox-vim/plugin/whitebox.vim]]

require("impatient")
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'
  use 'lewis6991/impatient.nvim'
  use {
    'nathom/filetype.nvim',
    config = function()
      require("filetype").setup({
        overrides = {
          extensions = {
            idr = "idris2"
          }
        }
      })
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
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
  use {
    'ntessore/unicode-math.vim',
    config = function()
      -- vim.o.keymap = 'unicode-math'
    end
  }
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
          enable = false,
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

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
    },
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
  use {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {}
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'stevearc/dressing.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after='nvim-cmp'},
    },
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
        completion = {
          keyword_length = 2,
          autocomplete = false,
        },
        preselect = false,
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
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
          capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          ),
        })

      lspconfig.tsserver.setup {
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.offsetEncoding = { "utf-16" }
      lspconfig.clangd.setup {
        capabilities = capabilities,
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

      lspconfig.gopls.setup {
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
    ft = {
      "cpp", "c", "markdown.mdx", "handlebars", "markdown", "typescript", "html",
      "css", "scss", "graphql", "json", "less", "jsonc", "javascriptreact", "javascript",
      "yaml", "vue", "typescriptreact", "go", "cs"
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.clang_format.with({filetypes = {"c", "cpp"}}),
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.formatting.gofmt,
          require("null-ls").builtins.formatting.csharpier,
          -- require("null-ls").builtins.formatting.goimports_reviser.with({
          --   args = {
          --     "-rm-unused", "-set-alias", "-format",
          --     "-output", "stdout", "$FILENAME"
          --   },
          -- }),
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
  use {
    "mickael-menu/zk-nvim",
    requires = { 'telescope.nvim' },
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
  -- use 'Issafalcon/neotest-dotnet'
  -- use {
  --   "nvim-neotest/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim",
  --     'Issafalcon/neotest-dotnet'
  --   },
  --   config = function()
  --     local lib = require("neotest.lib")
  --     local DotnetNeotestAdapter = require("neotest-dotnet")
  --     DotnetNeotestAdapter.root = lib.files.match_root_pattern("*.sln")
  --
  --     require("neotest").setup({
  --       adapters = {
  --         DotnetNeotestAdapter
  --       },
  --     })
  --     local function run_test_file() require("neotest").run.run(vim.fn.expand('%')) end
  --     local function run_test_suite() require("neotest").run.run({vim.fn.expand('%'), suite=true}) end
  --     local function toggle_summary() require("neotest").summary.toggle() end
  --     local function open_output() require("neotest").output.open() end
  --
  --     local opts = { silent = true, noremap = true }
  --     -- vim.keymap.set('n', '<C-;><C-r>', run_test_file, opts)
  --     vim.keymap.set('n', '<C-;><C-r>', run_test_file, opts)
  --     vim.keymap.set('n', '<C-;><C-t>', run_test_suite, opts)
  --     vim.keymap.set('n', '<C-;><C-s>', toggle_summary, opts)
  --     vim.keymap.set('n', '<C-;><C-o>', open_output, opts)
  --   end
  -- }
  --
  -- use {
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     local dap = require('dap')
  --     dap.adapters.lldb = {
  --       type = 'executable',
  --       command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  --       name = 'lldb'
  --     }
  --     dap.configurations.cpp = {
  --       {
  --         name = 'Launch',
  --         type = 'lldb',
  --         request = 'launch',
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --         cwd = '${workspaceFolder}',
  --         stopOnEntry = false,
  --         args = {},
  --
  --       },
  --     }
  --     dap.configurations.c = dap.configurations.cpp
  --     dap.configurations.rust = dap.configurations.cpp
  --   end
  -- }
  -- use {
  --   "rcarriga/nvim-dap-ui",
  --   requires = {"mfussenegger/nvim-dap"},
  --   config = function()
  --     require("dapui").setup({
  --       icons = { expanded = "", collapsed = "", current_frame = "" },
  --       mappings = {
  --         -- Use a table to apply multiple mappings
  --         expand = { "<CR>", "<2-LeftMouse>" },
  --         open = "o",
  --         remove = "d",
  --         edit = "e",
  --         repl = "r",
  --         toggle = "t",
  --       },
  --       -- Use this to override mappings for specific elements
  --       element_mappings = {
  --         -- Example:
  --         -- stacks = {
  --         --   open = "<CR>",
  --         --   expand = "o",
  --         -- }
  --       },
  --       -- Expand lines larger than the window
  --       -- Requires >= 0.7
  --       expand_lines = vim.fn.has("nvim-0.7") == 1,
  --       -- Layouts define sections of the screen to place windows.
  --       -- The position can be "left", "right", "top" or "bottom".
  --       -- The size specifies the height/width depending on position. It can be an Int
  --       -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  --       -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  --       -- Elements are the elements shown in the layout (in order).
  --       -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  --       layouts = {
  --         {
  --           elements = {
  --             -- Elements can be strings or table with id and size keys.
  --             { id = "scopes", size = 0.25 },
  --             "breakpoints",
  --             "stacks",
  --             "watches",
  --           },
  --           size = 40, -- 40 columns
  --           position = "left",
  --         },
  --         {
  --           elements = {
  --             "repl",
  --             "console",
  --           },
  --           size = 0.25, -- 25% of total lines
  --           position = "bottom",
  --         },
  --       },
  --       controls = {
  --         -- Requires Neovim nightly (or 0.8 when released)
  --         enabled = true,
  --         -- Display controls in this element
  --         element = "repl",
  --         icons = {
  --           pause = "",
  --           play = "",
  --           step_into = "",
  --           step_over = "",
  --           step_out = "",
  --           step_back = "",
  --           run_last = "",
  --           terminate = "",
  --         },
  --       },
  --       floating = {
  --         max_height = nil, -- These can be integers or a float between 0 and 1.
  --         max_width = nil, -- Floats will be treated as percentage of your screen.
  --         border = "single", -- Border style. Can be "single", "double" or "rounded"
  --         mappings = {
  --           close = { "q", "<Esc>" },
  --         },
  --       },
  --       windows = { indent = 1 },
  --       render = {
  --         max_type_length = nil, -- Can be integer or nil.
  --         max_value_lines = 100, -- Can be integer or nil.
  --       }
  --     })
  --     local dap, dapui = require("dap"), require("dapui")
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close()
  --     end
  --   end
  -- }
  -- use 'MunifTanjim/nui.nvim'
  -- use {
  --   "ShinKage/idris2-nvim",
  --   requires = {'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim'},
  --   config = function()
  --     require('idris2').setup {}
  --   end
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
