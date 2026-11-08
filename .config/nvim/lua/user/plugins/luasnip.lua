return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*",
	-- install jsregexp when make & a C compiler are available (on NixOS, extraLuaPackages provides jsregexp)
	build = (function()
		if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 or vim.fn.executable("cc") == 0 then
			return
		end
		return "make install_jsregexp"
	end)(),
	config = function()
		local ls = require("luasnip")
		local sc = require("luasnip.extras.select_choice")

		ls.config.setup({})

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
