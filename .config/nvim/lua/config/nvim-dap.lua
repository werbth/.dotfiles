require('dap.ext.vscode').load_launchjs()

local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = 'tabnew'

-- Python DAP configurations
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
table.insert(dap.configurations.python,
  {
    type = 'python',
    request = 'launch',
    name = "Launch file from workspace",
    program = "${file}",
    cwd = '${workspaceFolder}',
    pythonPath = 'python',
  }
)

-- DAP UI configuration
require("dapui").setup()
