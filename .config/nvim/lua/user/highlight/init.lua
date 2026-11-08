local function apply_sql_highlights()
	package.loaded["user.highlight.sqlhighlight_vscode"] = nil
	require("user.highlight.sqlhighlight_vscode")
end

apply_sql_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("user-sql-highlights", { clear = true }),
	desc = "Re-apply custom SQL treesitter highlights after colorscheme changes",
	callback = apply_sql_highlights,
})
