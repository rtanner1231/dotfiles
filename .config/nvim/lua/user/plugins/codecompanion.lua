local prefix = "<leader>c"
local user = vim.env.USER or "User"

vim.api.nvim_create_autocmd("User", {
	pattern = "CodeCompanionChatAdapter",
	callback = function(args)
		if args.data.adapter == nil or vim.tbl_isempty(args.data) then
			return
		end
		vim.g.llm_name = args.data.adapter.name
	end,
})

return {
	"olimorris/codecompanion.nvim",
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd", "CodeCompanionChat" },
	--enabled = false,
	opts = {
		adapters = {
			deepseek_coder = function()
				return require("codecompanion.adapters").extend("ollama", {
					name = "deepseek_coder",
					env = {
						url = "http://192.168.1.16:11434",
					},
					schema = {
						model = {
							--default = "deepseek-coder-v2:16b",
							default = "qwen2.5-coder:32b",
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "deepseek_coder",
				roles = {
					llm = "  CodeCompanion",
					user = " " .. user:sub(1, 1):upper() .. user:sub(2),
				},
				keymaps = {
					close = { modes = { n = "q", i = "<C-c>" } },
					stop = { modes = { n = "<C-c>" } },
				},
			},
			inline = { adapter = "deepseek_coder" },
			agent = { adapter = "deepseek_coder" },
		},
		-- display = {
		-- 	chat = {
		-- 		show_settings = true,
		-- 		render_headers = false,
		-- 	},
		-- },
	},
	keys = {
		{ prefix .. "a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action Palette" },
		{ prefix .. "c", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
		{ prefix .. "A", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add Code" },
		{ prefix .. "i", "<cmd>CodeCompanion<cr>", mode = "n", desc = "Inline Prompt" },
		{ prefix .. "C", "<cmd>CodeCompanionToggle<cr>", mode = "n", desc = "Toggle Chat" },
	},
}
