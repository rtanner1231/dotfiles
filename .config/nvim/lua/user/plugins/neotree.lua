return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal" },
	},
	opts = {
		close_if_last_window = true,
		filesystem = {
			window = {
				mappings = {
					["<leader>e"] = "close_window",
				},
			},
		},
		event_handlers = {

			{
				event = "file_open_requested",
				handler = function()
					-- auto close
					-- vimc.cmd("Neotree close")
					-- OR
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
