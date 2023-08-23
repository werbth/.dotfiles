-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { })
vim.keymap.set('n', '<C-j>', '<C-w>j', { })
vim.keymap.set('n', '<C-k>', '<C-w>k', { })
vim.keymap.set('n', '<C-l>', '<C-w>l', { })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sv', require('telescope.builtin').git_files, { desc = '[S]earch [V]CS (Git)' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
require('which-key').register({
  s = {
    name = 'Telescope',
  },
}, { prefix = '<leader>' })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Databases
vim.keymap.set('n', '<C-m>', '<cmd>DBUIToggle<CR>', { desc = 'DBUIToggle' })

-- nvim-dap
vim.keymap.set('n', '<leader>bb', require('dap').toggle_breakpoint, { desc = 'Set breakpoint' })
vim.keymap.set('n', '<leader>bc', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = 'Set conditional breakpoint' })
vim.keymap.set('n', '<leader>bl', "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = 'Set log point' })
vim.keymap.set('n', '<leader>br', require('dap').clear_breakpoints, { desc = 'Clear breakpoints' })
vim.keymap.set('n', '<leader>ba', "<cmd>Telescope dap list_breakpoints<cr>", { desc = 'List breakpoints' })
require('which-key').register({
  b = {
    name = 'breakpoints',
  },
}, { prefix = '<leader>' })

vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'Continue' })
vim.keymap.set('n', '<leader>dj', require('dap').step_over, { desc = 'Step over' })
vim.keymap.set('n', '<leader>dk', require('dap').step_into, { desc = 'Step into' })
vim.keymap.set('n', '<leader>do', require('dap').step_out, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dd', require('dap').disconnect, { desc = 'Disconnect' })
vim.keymap.set('n', '<leader>dt', require('dap').terminate, { desc = 'Terminate' })
vim.keymap.set('n', '<leader>dr', require('dap').repl.toggle, { desc = 'Open REPL' })
vim.keymap.set('n', '<leader>dl', require('dap').run_last, { desc = 'Run last' })
vim.keymap.set('n', '<leader>di', function() require('dap.ui.widgets').hover() end, { desc = 'Variables' })
vim.keymap.set('n', '<leader>d?', function() local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes) end, { desc = 'Scopes' })
require('which-key').register({
  d = {
    name = 'debug',
  },
}, { prefix = '<leader>' })

vim.keymap.set('n', "<C-n>", '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })
