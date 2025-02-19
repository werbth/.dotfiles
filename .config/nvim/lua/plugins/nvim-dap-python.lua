return {
  "mfussenegger/nvim-dap-python",
  opts = function(_, opts)
    local dap = require("dap")
    dap.configurations.python = dap.configurations.python or {}
    vim.list_extend(dap.configurations.python, {
      {
        type = "python",
        request = "launch",
        name = "Launch file from workspace",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pythonPath = "python",
      },
    })
  end,
}
