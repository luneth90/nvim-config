return {

  -- 弹出式终端
  {'akinsho/toggleterm.nvim', version = "*", config=true, 
    opts= {
      direction="float",
      open_mapping = [[<c-t>]],
    }
  },

  -- 主题
  { "rebelot/kanagawa.nvim", 
    lazy = false, -- 确保主题立即加载
    priority = 1000, -- 优先级高，确保主题在其他插件之前加载
    config = function() 
      require("kanagawa").setup({
        compile = true,
      })
      require("kanagawa").load("wave")
    end,
  },
  -- 导航条跳转
  { "Bekaboo/dropbar.nvim", event = "BufReadPost", keys = { { "<leader>db", "<cmd>lua require('dropbar.api').pick()<CR>", desc = "Pick Dropbar" } } },

  -- 状态栏显示
  { "nvim-lualine/lualine.nvim", event = "VimEnter", config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "kanagawa",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = {}, winbar = {} },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end },
  -- Buffer 导航
  { "romgrk/barbar.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, event = "BufRead", config = function()
    require("barbar").setup({
      icons = { filetype = { enabled = true } },
      sidebar_filetypes = {
        NvimTree = { text = "File Explorer", align = "center" },
      },
    })
  end, keys = {
    { "<leader>bb", "<cmd>BufferPick<CR>", desc = "Pick Buffer" },
    { "<leader>bc", "<cmd>BufferClose<CR>", desc = "Close Buffer" },
    { "<leader>bn", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
    { "<leader>bp", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
  } },
}
