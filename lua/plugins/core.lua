return {
  -- 基础库
  { "nvim-lua/plenary.nvim" },
  -- 图标icon
  { "nvim-tree/nvim-web-devicons" },
  -- 彩虹括号
  { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
  -- 快捷键提示
  { "folke/which-key.nvim", event = "VeryLazy", init = function() vim.o.timeout = true; vim.o.timeoutlen = 1000 end, opts = {},
    config = function()
      require('which-key').setup({
        delay = 2000,
      })
    end,
  },
  -- 根据文件动态tab和shift 缩进
  { "tpope/vim-sleuth", event = "BufReadPost" },
  -- 括号自动补全
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  -- MD 实时预览，支持服务器nvim打开本地浏览器
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "~/.deno/bin/deno task --quiet build:fast",
    config = function()
        require("peek").setup({
          app = 'browser',          -- 'webview', 'browser', string or a table of strings
          filetype = { 'markdown','codecompanion' },
        })
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- MD nvim简单预览，不支持Latex
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    priority = 49,
    ft = { "markdown", "codecompanion"}
  },

  -- 书签管理
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      -- or if using `mini.icons`
      -- { "echasnovski/mini.icons" },
    },
    opts = {
      show_icons = true,
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
  },

  -- 自动保存会话状态
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>wr", "<cmd>SessionSearch<CR>", desc = "Session search" },
      { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
    },
    opts = {
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      bypass_save_filetypes = { "alpha"},
    },
  },

  -- nvim 首页美化
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      -- Set header
      dashboard.section.header.val = {
        "                                                      ",
        "    ▄▄▄██▀▀▀▒█████ ▓██   ██▓ ▄▄▄▄    ▒█████ ▓██   ██▓ ",
        "      ▒██  ▒██▒  ██▒▒██  ██▒▓█████▄ ▒██▒  ██▒▒██  ██▒ ",
        "      ░██  ▒██░  ██▒ ▒██ ██░▒██▒ ▄██▒██░  ██▒ ▒██ ██░ ",
        "   ▓██▄██▓ ▒██   ██░ ░ ▐██▓░▒██░█▀  ▒██   ██░ ░ ▐██▓░ ",
        "    ▓███▒  ░ ████▓▒░ ░ ██▒▓░░▓█  ▀█▓░ ████▓▒░ ░ ██▒▓░ ",
        "    ▒▓▒▒░  ░ ▒░▒░▒░   ██▒▒▒ ░▒▓███▀▒░ ▒░▒░▒░   ██▒▒▒  ",
        "    ▒ ░▒░    ░ ▒ ▒░ ▓██ ░▒░ ▒░▒   ░   ░ ▒ ▒░ ▓██ ░▒░  ",
        "    ░ ░ ░  ░ ░ ░ ▒  ▒ ▒ ░░   ░    ░ ░ ░ ░ ▒  ▒ ▒ ░░   ",
        "    ░   ░      ░ ░  ░ ░      ░          ░ ░  ░ ░      ",
        "                    ░ ░           ░          ░ ░      ",
        "                                                      ",
      }
      
      -- Set menu
      dashboard.section.buttons.val = {
          dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
          dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
          dashboard.button("w", "  Find word", ":Telescope live_grep<CR>"),
          dashboard.button("r", "  Recent file"   , ":Telescope oldfiles<CR>"),
          dashboard.button("s", "  Open Session"   , ":SessionSearch<CR>"),
          dashboard.button("b", "  Open BookMarks", ":Telescope marks<CR>"),
          dashboard.button("c", "  Config", ":e ~/.config/nvim<CR>"),
          dashboard.button("l", "  Lazy", ":Lazy<CR>"),
          dashboard.button("m", "󰂖  Mason", ":Mason<CR>"),
          dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Set footer

      -- 获取 Neovim 版本
      local version = vim.version()
      local nvim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

      local lazy_stats = require("lazy").stats() -- Get Lazy.nvim stats
      dashboard.section.footer.val = {
        "If You Don't Take Risks, You Can't Create a Future.",
        " ",
        "                                  - Monkey D. Luffy",
        " ",
        "             Plugins loaded: " .. lazy_stats.loaded .. " / " .. lazy_stats.count,
        "             Neovim  Version: " .. nvim_version,
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
      ]])
    end,
  },
}
  

