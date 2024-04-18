require('dap-go').setup()
require('dapui').setup()
require("null-ls").setup()
require("dap-python").setup("~/.venv/neovim/bin/python")
-- require("dap-python").setup()
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

