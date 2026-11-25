local dap = require("dap")
-- C/C++/Rust via codelldb
dap.adapters.codelldb = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

require("dap-go").setup({
  dap_configurations = {
    { type = "go", name = "Attach remote", mode = "remote", request = "attach" },
  },
})
require("dapui").setup()

require("neotest").setup({
  adapters = {
    require("neotest-gtest").setup({})
  }
})
