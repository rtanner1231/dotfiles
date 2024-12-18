return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = "fish",
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local function lazygit_toggle()
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = {
					border = "none",
					width = 100000,
					height = 100000,
				},
				on_open = function(_)
					vim.cmd("startinsert!")
				end,
				on_close = function(_) end,
				count = 99,
			})
			lazygit:toggle()
		end

		-- vim.keymap.set("n", "<leader>gl", "<cmd>lua _Lazygit_toggle()<CR>", { desc = "Open Lazygit" })
		--vim.keymap.set("n", "<leader>gl", lazygit_toggle, { desc = "Open Lazygit" })
	end,
}
