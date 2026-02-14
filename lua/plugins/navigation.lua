return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VimEnter",
		config = function()
			require("nvim-tree").setup({
				hijack_cursor = true,
				sync_root_with_cwd = true,
				update_focused_file = {
					enable = true,
					ignore_list = { "help" },
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				filters = {
					custom = {
						"^.git$",
					},
				},
			})
		end,
		keys = { { "<leader>e", ":NvimTreeOpen<CR>", desc = "Open NvimTree" } },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
						i = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
					},
				},
			})
		end,
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
			{ "<leader>fc", "<cmd>Telescope grep_string<CR>", desc = "Grep Current Word" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Grep Help Doc" },
			{ "<leader>td", "<cmd>Telescope lsp_definitions<CR>", desc = "Goto defi" },
			{ "<leader>ti", "<cmd>Telescope lsp_implementations<CR>", desc = "Goto impl" },
			{ "<leader>tr", "<cmd>Telescope lsp_references<CR>", desc = "Goto refer" },
			{ "<leader>tD", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Goto  type defi" },
			{ "<leader>te", "<cmd>Telescope diagnostics<CR>", desc = "List error" },
		},
	},
	-- 快速移动
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	-- outline
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		config = function()
			require("outline").setup({})
		end,
		keys = { -- Example mapping to toggle outline
			{ "<leader>l", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
}
