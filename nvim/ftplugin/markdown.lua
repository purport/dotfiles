vim.bo.keymap = 'unicode-math'

-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=false }

  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

end
