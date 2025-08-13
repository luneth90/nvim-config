return {
  { "williamboman/mason.nvim", config = function() require("mason").setup() end, opts = { ensure_installed = { "tree-sitter-cli" } } },
  { "williamboman/mason-lspconfig.nvim", config = function() require("mason-lspconfig").setup({ ensure_installed = { "rust_analyzer", "ts_ls"} }) end },
  -- lsp 默认插件配置
  { "neovim/nvim-lspconfig", config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("lspconfig").rust_analyzer.setup({ capabilities = capabilities,include_declaration = false })
    require("lspconfig").ts_ls.setup({ capabilities = capabilities,include_declaration = false })
  end },

  --lsp 功能优化
  {
      'nvimdev/lspsaga.nvim',
      config = function()
          require('lspsaga').setup({})
      end,
      keys = {
        { "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Error" },
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
}
