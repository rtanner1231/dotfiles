return {
	"stevearc/aerial.nvim",
	enabled = false,
	opts = {
		close_automatic_events = { "unfocus" },
		autojump = true,
		-- keymaps = {
		-- 	["j"] = "actions.next",
		-- 	["k"] = "actions.prev",
		-- 	["J"] = "actions.next_up",
		-- 	["K"] = "actions.prev_up",
		-- },
	},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>nm",
			"<CMD>AerialToggle right<CR>",
		},
		{
			"<leader>nn",
			"<CMD>AerialNavToggle<CR>",
		},
	},
}
