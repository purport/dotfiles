local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require 'paq' {
  'savq/paq-nvim';
  'folke/tokyonight.nvim';
  's1n7ax/nvim-terminal';
  'neovim/nvim-lspconfig';
  'tpope/vim-dispatch';
  'radenling/vim-dispatch-neovim';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/nvim-cmp';
}

vim.o.completeopt = 'menu,menuone,noselect'
local cmp = require'cmp'
cmp.setup({
  sources = cmp.config.sources({ {name = 'nvim_lsp'}, }),
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
  }
})

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
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.clangd.setup{
  cmd = { 'clangd', '--enable-config' },
  on_attach = on_attach,
  capabilities = capabilities
}

vim.cmd([[autocmd FileType c,cpp let &makeprg='ninja -C .build']])
vim.cmd([[autocmd BufEnter *.c compiler gcc]])

-- remove whitespace at end of lines
vim.cmd([[au BufWritePre * :%s/\s\+$//e]])
vim.cmd[[colorscheme tokyonight]]

vim.g.mapleader = ' '
vim.g.timeoutlen = 200
vim.o.lazyredraw = true
vim.o.scrolloff = 3
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.clipboard= 'unnamedplus'
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

require('nvim-terminal').setup({
	window = {
		position = 'botright'
	},
	disable_default_keymaps = true
})

local silent = { silent = true }
vim.api.nvim_set_keymap('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<cr>', silent)
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', silent)
