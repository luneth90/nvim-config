return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
      automatic_installation = true,
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  { 
    "mfussenegger/nvim-dap", 
    lazy = true,
    dependencies = { "nvim-neotest/nvim-nio" }, 
    keys = {
      { "<leader>dr", "<cmd>lua require('dap').continue()<CR>", desc = "DAP Continue" },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<CR>", desc = "DAP Step Over" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>", desc = "DAP Step Into" },
      { "<leader>do", "<cmd>lua require('dap').step_out()<CR>", desc = "DAP Step Out" },
      { "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>lua require('dap').clear_breakpoints()<CR>", desc = "Clear Breakpoints" },
      { "<leader>dd", "<cmd>lua require('dap').terminate()<CR>", desc = "Terminate DAP" },
    } 
  },
  { 
    "rcarriga/nvim-dap-ui", 
    dependencies = { "mfussenegger/nvim-dap" }, 
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI"
      },
    }, 
  },
}
