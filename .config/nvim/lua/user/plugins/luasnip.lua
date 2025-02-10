return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		local types = require("luasnip.util.types")
		local sc = require("luasnip.extras.select_choice")

		print("in config")

		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if ls.expand_or_jumpable(-1) then
				ls.expand_or_jump(-1)
			end
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })
		vim.keymap.set("i", "<c-]>", function()
			if ls.choice_active() then
				sc()
			end
		end, {})
		vim.keymap.set("i", "<c-}>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, {})
	end,
}
