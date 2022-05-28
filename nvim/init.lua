local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

require 'paq' {
  'savq/paq-nvim';
  'folke/tokyonight.nvim';
  's1n7ax/nvim-terminal';
  'equalsraf/neovim-gui-shim';
}

-- remove whitespace at end of lines
vim.cmd([[au BufWritePre * :%s/\s\+$//e]])
vim.cmd[[colorscheme tokyonight]]

vim.g.mapleader = ' '
vim.g.timeoutlen = 200

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
