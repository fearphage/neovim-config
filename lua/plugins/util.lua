return {
	-- tmux
	{
		"alexghergh/nvim-tmux-navigation",
		keys = {
			{ "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "Left window" },
			{ "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "Up window" },
			{ "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "Down window" },
			{ "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Right window" },
		},
		lazy = false,
		opts = {
			disable_when_zoomed = true,
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		cmd = "MarkdownPreview",
		ft = "markdown",
	},

	{
		"kylechui/nvim-surround",
		config = true,
		event = "VeryLazy",
		version = "*",
	},

	{
		"numToStr/Comment.nvim",
		config = true,
		event = "VeryLazy",
	},

	"kyazdani42/nvim-web-devicons",

	-- makes some plugins dot-repeatable like leap
	{ "tpope/vim-repeat", event = "VeryLazy" },
}
