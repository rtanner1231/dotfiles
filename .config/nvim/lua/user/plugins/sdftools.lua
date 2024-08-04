return {
	"rtanner1231/sdftools.nvim",
	dev = true,
	keys = {
		{ "<leader>ss", ":SuiteQL FormatQuery<cr>", desc = "NeoTree reveal" },
		{ "<leader>dp", ":SDF Deploy<cr>", desc = "Run suitecloud deploy" },
		{ "<leader>dc", ":SDF SelectAccount<cr>", desc = "Select SDF Account" },
		{ "<leader>dl", ":SDF DeployCurrentFolder<cr>", desc = "Deploy all files in current file's directory" },
		{ "<leader>df", ":SDF DeployCurrentFile<cr>", desc = "Deploy current buffer file" },
		{ "<leader>dd", ":SDF Menu<cr>", desc = "Show deploy menu" },
	},
	opts = {
		toggleTerm = true,
		sourceDir = "dist",
	},
}
