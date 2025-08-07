local netsuitescripts = require("user.scripts.netsuitescripts")

local setK = vim.keymap.set

setK("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Resize with arrows
setK("n", "<C-Up>", ":resize +2<CR>", { desc = "decrease height" })
setK("n", "<C-Down>", ":resize -2<CR>", { desc = "increase hight" })
setK("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "decrease width" })
setK("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "increase width" })

-- Navigate buffers
setK("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" })
setK("n", "<S-h>", ":bprevious<CR>", { desc = "Previous Buffer" })
-- Close current buffer
setK("n", "<leader>b", ":bd<CR>", { desc = "Close Buffer" })

setK("i", "jk", "<ESC>", { desc = "Go to Normal Mode" })

-- Move text up and down
setK("v", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
setK("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
setK("v", "p", '"_dP', { desc = "Paste from clipboard" })

-- Visual Block --
-- Move text up and down
setK("x", "J", ":move '>+1<CR>gv-gv")
setK("x", "K", ":move '<-2<CR>gv-gv")
setK("x", "<A-j>", ":move '>+1<CR>gv-gv")
setK("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- setK("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- setK("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- setK("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- setK("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

setK("n", "<leader>xx", ":source %<cr>", { desc = "Run current file" })

--splits
setK("n", "<leader>vv", "<cmd>vsplit<cr>", { desc = "vertical Split" })
setK("n", "<leader>vh", "<cmd>split<cr>", { desc = "Horizontal Split" })
setK("n", "<leader>vc", "<C-w>c", { desc = "Close current split" })
setK("n", "<leader>vo", "<cmd>on<cr>", { desc = "Close other splits" })

setK("n", "<BS>", "^", { noremap = true })

--gitsigns
setK("n", "<leader>=", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Gitsigns preview hunk" })
setK("n", "<leader>]", "<cmd>Gitsigns next_hunk<cr>", { desc = "Gitsigns next hunk" })
setK("n", "<leader>[", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Gitsigns previous hunk" })

vim.api.nvim_set_keymap("n", "<leader>zz", "", {
	desc = "Netsuite Console",
	callback = function()
		netsuitescripts.create_popup()
	end,
})

--navbuddy
setK("n", "<leader>nn", "<cmd>Navbuddy<cr>", { desc = "Navbuddy" })
