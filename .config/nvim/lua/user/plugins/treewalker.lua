return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- Whether to briefly highlight the node after jumping to it
		highlight_duration = 250, -- How long should above highlight last (in ms)
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<Down>", ":Treewalker Down<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<Up>", ":Treewalker Up<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<Left>", ":Treewalker Left<CR>", { noremap = true })
		vim.api.nvim_set_keymap("n", "<Right>", ":Treewalker Right<CR>", { noremap = true })
	end,
}
