return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- Whether to briefly highlight the node after jumping to it
		highlight_duration = 250, -- How long should above highlight last (in ms)
	},
	config = function(_, opts)
		require("treewalker").setup(opts)
		vim.keymap.set({ "n", "v" }, "<Down>", "<cmd>Treewalker Down<CR>", { silent = true, desc = "Treewalker Down" })
		vim.keymap.set({ "n", "v" }, "<Up>", "<cmd>Treewalker Up<CR>", { silent = true, desc = "Treewalker Up" })
		vim.keymap.set({ "n", "v" }, "<Left>", "<cmd>Treewalker Left<CR>", { silent = true, desc = "Treewalker Left" })
		vim.keymap.set({ "n", "v" }, "<Right>", "<cmd>Treewalker Right<CR>", { silent = true, desc = "Treewalker Right" })
	end,
}
