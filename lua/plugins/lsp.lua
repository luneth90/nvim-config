return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- LSPs (语言服务器)
				"rust_analyzer",
				"html",
				"lua_ls",
				"ts_ls",
				"cssls",
				"eslint",
				"emmet_ls",
				"vimls",
				"pyright",
				"tailwindcss",
				"vue-language-server",
				"tree-sitter-cli",
				-- Formatters (格式化工具)
				"stylua",
				"black",
				"prettier",
				-- debug
				"codelldb",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		-- 必须在 mason.nvim 和 nvim-lspconfig 之后加载
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = {
					"html",
					"lua_ls",
					"cssls",
					"eslint",
					"emmet_ls",
					"vimls",
					"pyright",
					"tailwindcss",
				},
			})

			-- ts_ls and vue lsp config

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"
			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			local ts_ls_config = {
				init_options = {
					plugins = {
						vue_plugin,
					},
				},
				filetypes = tsserver_filetypes,
			}
			local vue_ls_config = {
				on_init = function(client)
					client.handlers["tsserver/request"] = function(_, result, context)
						local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })
						if #clients == 0 then
							vim.notify(
								"Could not find `ts_ls` lsp client, `vue_ls` would not work without it.",
								vim.log.levels.ERROR
							)
							return
						end
						local ts_client = clients[1]

						local param = unpack(result)
						local id, command, payload = unpack(param)
						ts_client:exec_cmd({
							title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
							command = "typescript.tsserverRequest",
							arguments = {
								command,
								payload,
							},
						}, { bufnr = context.bufnr }, function(_, r)
							local response = r and r.body
							-- TODO: handle error or response nil here, e.g. logging
							-- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
							local response_data = { { id, response } }

							---@diagnostic disable-next-line: param-type-mismatch
							client:notify("tsserver/response", response_data)
						end)
					end
				end,
			}
			-- nvim 0.11 or above
			vim.lsp.config("ts_ls", ts_ls_config)
			vim.lsp.config("vue_ls", vue_ls_config)
			vim.lsp.enable({ "ts_ls", "vue_ls" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
			{ "gr", vim.lsp.buf.references, desc = "Go to References" },
			{ "gt", vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
			{ "<space>ca", vim.lsp.buf.code_action, "Code Action" },
			{ "<space>rn", vim.lsp.buf.rename, "Rename" },
			{ "<space>d", vim.diagnostic.open_float, "Show Line Diagnostics" },
			{ "[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic" },
			{ "]d", vim.diagnostic.goto_next, "Go to Next Diagnostic" },
		},
	},

	-- rust lsp,debug 优化功能
	{
		-- Automatically sets up LSP, so lsp.lua doesn't include rust.
		-- Makes debugging work seamlessly.
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended by module.
		ft = "rust",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ "<leader>rr", "<cmd>RustLsp run<cr>", desc = "Run" },
			{ "<leader>rd", "<cmd>RustLsp debug<cr>", desc = "Debug" },
			{ "<leader>ra", "<cmd>RustLsp codeAction<cr>", desc = "Code Action" },
			{ "<leader>rc", "<cmd>RustLsp openCargo<cr>", desc = "Open cargo.toml" },
			{ "<leader>rk", "<cmd>RustLsp openDocs<cr>", desc = "Open docs" },
			{ "<leader>rm", "<cmd>RustLsp parentModule<cr>", desc = "Parent Module" },
		},
	},
	-- lsp 进度浮窗提示
	{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

	-- 语法高亮，核心插件
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
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
	},
}
