return {
  { "tpope/vim-fugitive", event = "VeryLazy", keys = { { "<leader>ga", function() vim.cmd('vert Git');vim.cmd('vert res 60') end, desc = "Git Status" } } },
  { "tpope/vim-rhubarb", event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim", event = "BufReadPost", config = function() require("gitsigns").setup({ current_line_blame = true }) end, keys = {
    { "[c", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "]c", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
  } },
}
