vim.cmd([[let &makeprg='ninja -C .build -f ../build.ninja']])
vim.cmd([[compiler gcc]])
vim.cmd([[let &commentstring='//%s']])

