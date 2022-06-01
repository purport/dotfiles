-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\My\\Cache\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\My\\Cache\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\My\\Cache\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\My\\Cache\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\My\\Cache\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rfiletype\frequire\0" },
    loaded = true,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\start\\filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n¶\5\0\0\a\0!\3V6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0029\3\6\0'\5\a\0*\6\0\0B\3\3\2=\3\5\0029\2\3\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\n\0019\2\4\0029\3\6\0'\5\v\0*\6\0\0B\3\3\2=\3\5\0029\2\n\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\f\0019\2\4\0029\3\6\0'\5\r\0*\6\2\0B\3\3\2=\3\5\0029\2\f\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\14\0019\2\4\0029\3\6\0'\5\15\0*\6\0\0B\3\3\2=\3\5\0029\2\14\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0026\2\0\0'\4\16\0B\2\2\0029\2\17\0025\4\20\0005\5\18\0=\1\19\5=\5\21\0045\5\23\0005\6\22\0=\6\24\0055\6\25\0=\6\26\0054\6\0\0=\6\27\0054\6\0\0=\6\28\0054\6\0\0=\6\29\0055\6\30\0=\6\31\5=\5 \4B\2\2\1K\0\1\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\14lualine_x\14lualine_c\14lualine_b\1\3\0\0\rfilename\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\ntheme\1\0\1\18icons_enabled\1\nsetup\flualine\f#bb9af7\vvisual\f#e0af68\fcommand\f#9ece6a\vinsert\f#3b4261\6b\f#7aa2f7\vdarken\abg\6a\vnormal\30lualine.themes.tokyonight\20tokyonight.util\frequire\1ÄÄÄˇ\3ÁÃô≥\6≥ÊÃ˛\3ÁÃô≥\6≥Êåˇ\3\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    after = { "nvim-lspconfig" },
    config = { "\27LJ\2\nÆ\1\0\0\b\0\v\0\0206\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0009\4\3\0009\4\4\0044\6\3\0005\a\5\0>\a\1\6B\4\2\2=\4\4\0035\4\t\0009\5\a\0009\5\b\5B\5\1\2=\5\n\4=\4\a\3B\1\2\1K\0\1\0\n<Tab>\1\0\0\21select_next_item\fmapping\1\0\0\1\0\1\tname\rnvim_lsp\fsources\vconfig\nsetup\bcmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1¿\24nvim_buf_set_option\bapi\bvim√\5\1\2\v\0\25\0A3\2\0\0003\3\1\0005\4\2\0\18\5\2\0'\a\3\0'\b\4\0'\t\5\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\6\0'\t\a\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\b\0'\t\t\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\n\0'\t\v\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\f\0'\t\r\0\18\n\4\0B\5\5\1\18\5\2\0'\a\14\0'\b\15\0'\t\16\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\17\0'\t\18\0\18\n\4\0B\5\5\1\18\5\2\0'\a\19\0'\b\20\0'\t\18\0\18\n\4\0B\5\5\1\18\5\2\0'\a\3\0'\b\21\0'\t\22\0\18\n\4\0B\5\5\1\18\5\2\0'\a\14\0'\b\23\0'\t\24\0\18\n\4\0B\5\5\0012\0\0ÄK\0\1\0000<cmd>lua vim.lsp.buf.range_formatting()<CR>\6f*<cmd>lua vim.lsp.buf.formatting()<CR>\14<leader>f\n<C-K>\6i.<cmd>lua vim.lsp.buf.signature_help()<CR>\6K1<cmd>lua vim.lsp.buf.range_code_action()<CR>\6a\6v+<cmd>lua vim.lsp.buf.code_action()<CR>\14<leader>a&<cmd>lua vim.lsp.buf.rename()<CR>\15<leader>rn,<cmd>lua vim.diagnostic.goto_next()<CR>\a]d,<cmd>lua vim.diagnostic.goto_prev()<CR>\a[d*<cmd>lua vim.lsp.buf.definition()<CR>\agd\6n\1\0\2\vsilent\2\fnoremap\2\0\0ú\5\1\0\r\0\"\0;6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0024\2\5\0005\3\3\0>\3\1\0025\3\4\0>\3\2\0025\3\5\0>\3\3\0025\3\6\0>\3\4\0026\3\a\0\18\5\2\0B\3\2\4X\6\nÄ6\b\b\0009\b\t\b9\b\n\b9\n\v\a5\v\f\0009\f\v\a=\f\r\v9\f\14\a=\f\14\vB\b\3\1E\6\3\3R\6Ù6\3\b\0009\3\15\0039\3\16\0035\5\17\0005\6\18\0=\2\19\6=\6\20\5B\3\2\0013\3\21\0006\4\0\0'\6\22\0B\4\2\0029\4\23\0046\6\b\0009\6\24\0069\6\25\0069\6\26\6B\6\1\0A\4\0\0029\5\27\0009\5\28\0055\a\30\0005\b\29\0=\b\31\a=\3 \a=\4!\aB\5\2\1K\0\1\0\17capabilities\14on_attach\bcmd\1\0\0\1\3\0\0\vclangd\20--enable-config\nsetup\vclangd\29make_client_capabilities\rprotocol\blsp\24update_capabilities\17cmp_nvim_lsp\0\nsigns\vactive\1\0\0\1\0\1\17virtual_text\1\vconfig\15diagnostic\ttext\vtexthl\1\0\1\nnumhl\5\tname\16sign_define\afn\bvim\vipairs\1\0\2\ttext\b‚Ñπ\tname\23DiagnosticSignInfo\1\0\2\ttext\tüí°\tname\23DiagnosticSignHint\1\0\2\ttext\b‚ö†\tname\23DiagnosticSignWarn\1\0\2\ttext\b‚ùå\tname\24DiagnosticSignError\19lspconfig.util\14lspconfig\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-terminal"] = {
    config = { "\27LJ\2\nÇ\2\0\0\a\0\r\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0015\0\6\0006\1\a\0009\1\b\0019\1\t\1'\3\n\0'\4\v\0'\5\f\0\18\6\0\0B\1\5\1K\0\1\0+:lua NTGlobal[\"terminal\"]:toggle()<cr>\14<leader>t\6n\20nvim_set_keymap\bapi\bvim\1\0\2\vsilent\2\fnoremap\2\vwindow\1\0\1\28disable_default_keymaps\2\1\0\1\rposition\rbotright\nsetup\18nvim-terminal\frequire\0" },
    keys = { { "", "<leader>t" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\nvim-terminal",
    url = "https://github.com/s1n7ax/nvim-terminal"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\nù\4\0\0\b\0\26\0/6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\v\0005\4\t\0005\5\a\0005\6\4\0009\a\5\0=\a\6\6=\6\b\5=\5\n\4=\4\f\0034\4\0\0=\4\r\0034\4\0\0=\4\14\3B\1\2\0015\1\15\0006\2\16\0009\2\17\0029\2\18\2'\4\19\0'\5\20\0'\6\21\0\18\a\1\0B\2\5\0016\2\16\0009\2\17\0029\2\18\2'\4\19\0'\5\22\0'\6\23\0\18\a\1\0B\2\5\0016\2\16\0009\2\17\0029\2\18\2'\4\19\0'\5\24\0'\6\25\0\18\a\1\0B\2\5\1K\0\1\0008<cmd>lua require(\"telescope.builtin\").buffers()<cr>\n<C-b>:<cmd>lua require(\"telescope.builtin\").live_grep()<cr>\n<C-g>;<cmd>lua require(\"telescope.builtin\").find_files()<cr>\n<C-p>\6n\20nvim_set_keymap\bapi\bvim\1\0\2\vsilent\2\fnoremap\2\15extensions\fpickers\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<esc>\nclose\1\0\1\n<C-h>\14which_key\nsetup\14telescope\22telescope.actions\frequire\0" },
    keys = { { "", "<C-p>" }, { "", "<C-g>" }, { "", "<C-b>" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    after = { "lualine.nvim" },
    loaded = true,
    only_config = true
  },
  ["vim-dispatch"] = {
    after = { "vim-dispatch-neovim" },
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    load_after = {
      ["vim-dispatch"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\vim-dispatch-neovim",
    url = "https://github.com/radenling/vim-dispatch-neovim"
  },
  ["vim-fugitive"] = {
    commands = { "Git" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\My\\Share\\nvim-data\\site\\pack\\packer\\opt\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rfiletype\frequire\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n¶\5\0\0\a\0!\3V6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\2\4\0029\3\6\0'\5\a\0*\6\0\0B\3\3\2=\3\5\0029\2\3\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\n\0019\2\4\0029\3\6\0'\5\v\0*\6\0\0B\3\3\2=\3\5\0029\2\n\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\f\0019\2\4\0029\3\6\0'\5\r\0*\6\2\0B\3\3\2=\3\5\0029\2\f\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0029\2\14\0019\2\4\0029\3\6\0'\5\15\0*\6\0\0B\3\3\2=\3\5\0029\2\14\0019\2\b\0029\3\6\0'\5\t\0*\6\1\0B\3\3\2=\3\5\0026\2\0\0'\4\16\0B\2\2\0029\2\17\0025\4\20\0005\5\18\0=\1\19\5=\5\21\0045\5\23\0005\6\22\0=\6\24\0055\6\25\0=\6\26\0054\6\0\0=\6\27\0054\6\0\0=\6\28\0054\6\0\0=\6\29\0055\6\30\0=\6\31\5=\5 \4B\2\2\1K\0\1\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\14lualine_x\14lualine_c\14lualine_b\1\3\0\0\rfilename\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\ntheme\1\0\1\18icons_enabled\1\nsetup\flualine\f#bb9af7\vvisual\f#e0af68\fcommand\f#9ece6a\vinsert\f#3b4261\6b\f#7aa2f7\vdarken\abg\6a\vnormal\30lualine.themes.tokyonight\20tokyonight.util\frequire\1ÄÄÄˇ\3ÁÃô≥\6≥ÊÃ˛\3ÁÃô≥\6≥Êåˇ\3\0", "config", "lualine.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <C-g> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-g>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-p> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-p>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-b> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>C-b>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>t <cmd>lua require("packer.load")({'nvim-terminal'}, { keys = "<lt>leader>t", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(1) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
