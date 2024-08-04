return {
	"rtanner1231/suiteqltools.nvim",
	dev = true,
	keys = {
		{ "<leader>ss", ":SuiteQL FormatQuery<cr>", desc = "NeoTree reveal" },
		{ "<leader>sa", ":SuiteQL FormatFile<cr>", desc = "Format all SuiteQL in file" },
		{ "<leader>se", ":SuiteQL ToggleEditor<cr>", desc = "Toggle SuiteQL editor" },
		{ "<leader>sw", ":SuiteQL EditQuery<cr>", desc = "Edit the query under the cursor" },
		{ "<leader>sc", ":NSConn SelectProfile<cr>", desc = "Change the active profile" },
		{ "<leader>sh", ":SuiteQL History<cr>", desc = "View the query history" },
		{ "<leader>sq", ":SuiteQL ShowTablePicker<cr>", desc = "Show the table picker" },
		{ "<leader>sk", ":SuiteQL ShowFieldPicker<cr>", desc = "Show the field picker for the last table" },
		{ "<leader>sl", ":SuiteQL ShowLastTableFieldPicker<cr>", desc = "Show the field picker for the last table" },
	},
	opts = {
		sqlFormatter = {
			keywordCase = "upper",
			logicalOperatorNewline = "after",
		},
		queryRun = {
			editorKeymap = {
				toggleWindow = "<leader>sa",
				runQuery = "<leader>sr",
				toggleResultZoom = "<leader>sf",
				nextPage = "<leader>sn",
				previousPage = "<leader>sp",
				toggleDisplayMode = "<leader>sm",
			},
			history = true,
			completion = true,
		},
	},
}
