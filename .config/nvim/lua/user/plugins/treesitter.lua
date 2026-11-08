return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Tracking main branch for Neovim 0.12+
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Ensure core language parsers are installed (no-op when already installed)
		local ensure_installed = {
			"bash",
			"c",
			"css",
			"diff",
			"fish",
			"graphql",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"nix",
			"python",
			"query",
			"regex",
			"sql",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"xml",
			"yaml",
		}

		local installed = require("nvim-treesitter.config").get_installed()
		local installed_set = {}
		for _, lang in ipairs(installed) do
			installed_set[lang] = true
		end

		local missing = {}
		for _, lang in ipairs(ensure_installed) do
			if not installed_set[lang] then
				table.insert(missing, lang)
			end
		end

		if #missing > 0 and vim.fn.executable("tree-sitter") == 1 and vim.fn.executable("cc") == 1 then
			ts.install(missing)
		end

		-- In nvim-treesitter `main` branch + Neovim 0.12+, highlighting and indentation
		-- must be started explicitly via a FileType autocmd.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user-treesitter-start", { clear = true }),
			desc = "Start Treesitter syntax highlighting and indentation",
			callback = function(args)
				local bufnr = args.buf
				local ft = vim.bo[bufnr].filetype
				if ft == "" then
					return
				end

				-- Skip special UI/plugin filetypes or huge files handled by Snacks.bigfile
				if ft == "bigfile" then
					return
				end

				local lang = vim.treesitter.language.get_lang(ft) or ft
				if not pcall(vim.treesitter.language.add, lang) then
					return
				end

				-- Enable Treesitter syntax highlighting
				pcall(vim.treesitter.start, bufnr, lang)

				-- Enable Treesitter indentation if an indents query exists for this language
				local has_indents = #vim.treesitter.query.get_files(lang, "indents") > 0
				if has_indents and ft ~= "ruby" then
					vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
