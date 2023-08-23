vim.keymap.set('n', '<leader>rc', require('dap-python').test_class, { desc = 'Run test class' })
vim.keymap.set('n', '<leader>rm', require('dap-python').test_method, { desc = 'Run test method' })
