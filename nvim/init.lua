-- ========================================================================== -- ==                           CORE SETTINGS                            == --
-- ========================================================================== --

require("core")

-- ========================================================================== --
-- ==                           LAZY PLUGINS                            == --
-- ========================================================================== --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{'nvim-lua/plenary.nvim'},
	{"nvim-tree/nvim-web-devicons"},
	{"iamcco/markdown-preview.nvim"},
	{
	    'goolord/alpha-nvim',
	    config = function ()
		require'alpha'.setup(require'alpha.themes.dashboard'.config)
	    end
	},	
	{ 'Bekaboo/dropbar.nvim' },
	{'HiPhish/rainbow-delimiters.nvim'},
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  init = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 1000
	  end,
	  opts = {
	  }
	},
	{
	  "nvim-treesitter/nvim-treesitter",
	  build = ":TSUpdate",
	  config = function () 
	  local configs = require("nvim-treesitter.configs")
	  configs.setup({
	    ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python", "javascript", "html", "toml", "yaml", "css", "typescript" },
	    sync_install = true,
	    highlight = { enable = true },
	    incremental_selection = {
	    enable = true,
	      keymaps = {
		init_selection = '<CR>',
		node_incremental = '<CR>',
		node_decremental = '<BS>',
		scope_incremental = '<TAB>',
	      }
	    },
	    indent = { enable = true },  
	  })
	  end
	},
	-- Git related plugins
	{'tpope/vim-fugitive'},
	{'tpope/vim-rhubarb'},

	-- Detect tabstop and shiftwidth automatically
	{'tpope/vim-sleuth'},
	{
	  'windwp/nvim-autopairs',
	  event = "InsertEnter",
	  opts = {} -- this is equalent to setup({}) function
	},
  	{
  	  "williamboman/mason.nvim",
	  config = function()
	    require("mason").setup()
	  end
  	},
  	{
  	  "williamboman/mason-lspconfig.nvim",
	  config = function()
	   require("mason-lspconfig").setup()
	  end
  	},
	-- nav start
	{
	  's1n7ax/nvim-window-picker',
	  name = 'window-picker',
	  event = 'VeryLazy',
	  version = '2.*',
	  config = function()
	      local picker = require("window-picker")
	      picker.setup({
		 highlights = {
		  statusline = {
		      focused = {
			  fg = '#ededed',
			  bg = '#e35e4f',
			  bold = true,
		      },
		      unfocused = {
			  fg = '#ededed',
			  bg = '#002b36',
			  bold = true,
		      },
		  },
		}
	      })

	      vim.keymap.set("n", "<leader><leader>w", function()
		local picked_window_id =
		picker.pick_window() or vim.api.nvim_get_current_win()
		vim.api.nvim_set_current_win(picked_window_id)
	      end, { desc = "Pick a window" })
	  end,
	},
  	{
  	  "karb94/neoscroll.nvim",
	  config = function()
    		require("neoscroll").setup()
	  end
  	},
	{'simrat39/symbols-outline.nvim'},
	{ "junegunn/fzf", build = "./install --bin" },
	{
	  "ibhagwan/fzf-lua",
	  -- optional for icon support
	  config = function()
	  -- calling `setup` is optional for customization
	  require("fzf-lua").setup({})
	  end
	},
	{'akinsho/bufferline.nvim', version = "*"},
	{
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  config = function()
	  require("nvim-tree").setup ({
			  update_focused_file = {
			  enable = true,
		  }
		  })
	  end,
	},

	{'nvim-lualine/lualine.nvim'},
	{'voldikss/vim-floaterm'},
	{
	  'phaazon/hop.nvim',
	  branch = 'v2', -- optional but strongly recommended
	  config = function()
	    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
	  end
	},
	-- nav end
	
	-- edit
	{
	  'numToStr/Comment.nvim',
	  opts = {},
	  lazy = false,
	},
	{'RRethy/vim-illuminate'},
	{
	  'lewis6991/gitsigns.nvim',
	  config = function()
		  require('gitsigns').setup()	
	  end
	},

	{'tpope/vim-surround'},
	{"lukas-reineke/indent-blankline.nvim"},
	{'nvim-pack/nvim-spectre'},

	--lsp start
	{'neovim/nvim-lspconfig'},
	{'simrat39/rust-tools.nvim'},
	--lsp end

	-- cmp start
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'hrsh7th/cmp-calc'},
	{'hrsh7th/cmp-cmdline'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
   	{'L3MON4D3/LuaSnip'},
	{'honza/vim-snippets'},
   	{'saadparwaiz1/cmp_luasnip'},
	{'rafamadriz/friendly-snippets'},
	-- cmp end

	-- Useful status updates for LSP
	{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

	-- debug start
	{'mfussenegger/nvim-dap'},
	{ 
	  "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"},
	  config = function()
		  require("dapui").setup()
	  end
	},
	-- debug end

	--colorscheme start
	{
	  'folke/tokyonight.nvim',
	  lazy = false,
	  priority = 1000,
	  opts = {},
	  config = function()
	    --vim.cmd.colorscheme 'tokyonight'
	  end,
	},
	{
	  -- Theme inspired by Atom
	  'navarasu/onedark.nvim',
	  priority = 1000,
	  config = function()
	    --vim.cmd.colorscheme 'onedark'
	  end,
	},
	{
	  "rebelot/kanagawa.nvim",
	  config = function()
	    vim.cmd.colorscheme 'kanagawa-wave'
	  end,
	},
	--colorscheme end


})
-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

--tree
vim.keymap.set({'n', 'x', 'o'}, '<leader>e', ':NvimTreeOpen<cr>')

--outline
vim.keymap.set("n", "<leader>oo", ":SymbolsOutline<cr>",opts)

--fzf config
vim.keymap.set("n", "<leader>ff",
  "<cmd>lua require('fzf-lua').files()<CR>", opts)
vim.keymap.set("n", "<leader>fc",
  "<cmd>lua require('fzf-lua').grep_cword()<CR>", opts)
vim.keymap.set("n", "<leader>fg",
  "<cmd>lua require('fzf-lua').live_grep()<CR>", opts)
vim.keymap.set("n", "<leader>fb",
  "<cmd>lua require('fzf-lua').buffers()<CR>", opts)

--floater
vim.keymap.set("n", "<leader>on", ":FloatermNew<cr>",opts)
vim.keymap.set('t', '<leader>on', [[<C-\><C-n>:FloatermNew<cr>]],opts)
vim.keymap.set("n", "<leader>ot", ":FloatermToggle<cr>",opts)
vim.keymap.set('t', '<leader>ot', [[<C-\><C-n>:FloatermToggle<cr>]],opts)
vim.keymap.set("n", "<leader>oj", ":FloatermNext<cr>",opts)
vim.keymap.set('t', '<leader>oj', [[<C-\><C-n>:FloatermNext<cr>]],opts)
vim.keymap.set("n", "<leader>ok", ":FloatermPrev<cr>",opts)
vim.keymap.set('t', '<leader>ok', [[<C-\><C-n>:FloatermPrev<cr>]],opts)

--hop
vim.keymap.set("n", "<leader>w", ":HopWord<cr>",opts)
vim.keymap.set("n", "<leader>c", ":HopChar1<cr>",opts)
vim.keymap.set("n", "<leader>l", ":HopLine<cr>",opts)
vim.keymap.set("n", "<leader>gb", ":BufferLinePick<CR>", opts)
vim.keymap.set("n", "<leader>gc", ":BufferLinePickClose<CR>", opts)

--dap
vim.keymap.set('n', '<leader>dr', "<cmd>lua require('dap').continue()<cr>" )
vim.keymap.set('n', '<leader>dn', "<cmd>lua require('dap').step_over()<cr>" )
vim.keymap.set('n', '<leader>di', "<cmd>lua require('dap').step_into()<cr>" )
vim.keymap.set('n', '<leader>do', "<cmd>lua require('dap').step_out()<cr>")
vim.keymap.set('n', '<Leader>db', "<cmd>lua require('dap').toggle_breakpoint()<cr>" )
vim.keymap.set('n', '<Leader>dc', "<cmd>lua require('dap').clear_breakpoints()<cr>")
vim.keymap.set('n', '<Leader>dt', "<cmd>lua require('dap').terminate()<cr>")


--dropbar
vim.keymap.set('n', '<leader>bp', "<cmd>lua require('dropbar.api').pick()<cr>" )

--search and replace
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})


--gitsign
vim.keymap.set("n", "[c", "<cmd>Gitsigns next_hunk<CR>",opts)
vim.keymap.set("n", "]c", "<cmd>Gitsigns prev_hunk<CR>",opts)

--vim-illuminate
vim.keymap.set("n", "<leader>n", "<cmd>lua require('illuminate').goto_next_reference(wrap)<CR>",opts)
vim.keymap.set("n", "<leader>p", "<cmd>lua require('illuminate').goto_prev_reference(wrap)<CR>",opts)

require("plugins/lualine")
require("plugins/dap")
require("plugins/cmp")
require("plugins/bufferline")
require("plugins/outline")
require("plugins/lsp")
