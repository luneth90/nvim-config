local dap, dapui = require("dap"), require("dapui")
--dap.adapters.codelldb = {
--  type = 'server',
--  host = '127.0.0.1',
--  port = 13000
--}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/Users/xiaowei/.local/share/nvim/mason/bin/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.rust = {
  {
    name = "run",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
	args = function()
      return {vim.fn.input('args: '),"--exact", "--nocapture"}
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}


dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
