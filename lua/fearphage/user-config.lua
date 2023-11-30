-- use a user/user_config.lua file to provide your own configuration

local M = {}

-- add any null-ls sources you want here
M.setup_sources = function(b)
	return {
		b.formatting.autopep8,
		b.code_actions.gitsigns,
	}
end

-- add null_ls sources to auto-install
M.null_ls_ensure_installed = {
	"stylua",
	"jq",
}

-- add servers to be used for auto formatting here
M.formatting_servers = {
	["rust_analyzer"] = { "rust" },
	["lua_ls"] = { "lua" },
	["null_ls"] = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
}

-- options you put here will override or add on to the default options
M.options = {
	opt = {
		confirm = false,
	},
}

-- Set any to false that you want disabled in here.
-- Default value is true if left blank
M.autocommands = {
	inlay_hints = true,
	alpha_folding = true,
	treesitter_folds = true,
	trailing_whitespace = true,
	remember_file_state = true,
	session_saved_notification = true,
	format_on_autosave = true,
	css_colorizer = true,
	activate_neotree = true,
}

-- set to false to disable plugins
-- Default value is true if left blank
M.enable_plugins = {
	aerial = true,
	alpha = true,
	autopairs = true,
	autosave = true,
	bufferline = true,
	cmp = true,
	colorizer = true,
	comment = true,
	copilot = true,
	dap = true,
	dressing = true,
	gitsigns = true,
	hop = true,
	indent_blankline = true,
	inlay_hints = true,
	lsp_zero = true,
	lualine = true,
	neodev = true,
	neoscroll = true,
	neotree = true,
	noice = true,
	notify = true,
	null_ls = true,
	onedark = true,
	project = true,
	scope = true,
	session_manager = true,
	surround = true,
	telescope = true,
	toggleterm = true,
	treesitter = true,
	trouble = true,
	twilight = true,
	ufo = true,
	whichkey = true,
	zen = true,
}

return M
