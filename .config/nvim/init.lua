vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({ { import = "user/plugins" }, { import = "user/plugins.lsp" } }, {
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects/nvimplugins",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = { "rtanner1231" }, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
	checker = {
		enabled = true,
		notify = false,
	},
})

require("user.options")
require("user.keymaps")
require("user.autocmds")
require("user.highlight")
