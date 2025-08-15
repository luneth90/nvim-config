return {
  { "williamboman/mason.nvim", config = function() require("mason").setup() end, opts = { ensure_installed = { "tree-sitter-cli" } } },
  { "williamboman/mason-lspconfig.nvim", config = function() require("mason-lspconfig").setup({ ensure_installed = { "rust_analyzer"}) end },

  -- rust lsp,debug 优化功能
  {
    "mrcjkb/rustaceanvim",
    version = '^6', -- Recommended by module.
    ft = "rust",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  -- lsp 进度浮窗提示
  { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
  
  -- 语法高亮，核心插件
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"c", "lua", "vim", "vimdoc", "rust", "python", "javascript", "html", "toml", "yaml", "css", "typescript","markdown","markdown_inline" },
      sync_install = true,
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      indent = { enable = true },
    })
    end 
  },

  -- 错误提示
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
}
