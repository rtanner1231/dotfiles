return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = "fish",
		float_opts = {
			border = "curved",
			winblend = 0,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- The core logic for our dynamic Gemini terminal
		local Terminal = require("toggleterm.terminal").Terminal

		local function open_gemini(command)
			-- Create and open the terminal (same as before).
			local term = Terminal:new({
				cmd = command,
				close_on_exit = true,
				hidden = true,
				direction = "float",
				on_open = function(t)
					vim.cmd("startinsert!")
				end,
			})

			term:toggle()
		end

		local function open_gemini_with_project_file()
			local full_path = vim.fn.expand("%:p")

			if full_path == "" then
				print("Error: No file path for the current buffer.")
				return
			end

			local project_root = vim.fn.getcwd()
			local display_path

			-- Check if the file path is within the project root.
			if string.find(full_path, project_root, 1, true) then
				-- Calculate the relative path by taking the substring after the root path.
				-- The '+ 2' accounts for the length of the root and the directory separator '/'.
				display_path = string.sub(full_path, #project_root + 2)
			else
				-- If the file is outside the project root, just use the filename as a fallback.
				display_path = vim.fn.expand("%:t") -- :t gets the "tail" or filename.
			end
			-- Construct the command string.
			local cmd_string = string.format(
				'gemini -i "The current file is @%s.  Do nothing yet, Await further instructions"',
				vim.fn.shellescape(display_path)
			)

			open_gemini(cmd_string)
		end

		local function open_gemini_standard()
			open_gemini("gemini")
		end

		vim.keymap.set("n", "<leader>ai", open_gemini_with_project_file, {
			noremap = true,
			silent = true,
			desc = "Open Gemini with current file context",
		})

		vim.keymap.set("n", "<leader>ao", open_gemini_standard, {
			noremap = true,
			silent = true,
			desc = "Open Gemini",
		})

		local function lazygit_toggle()
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = {
					border = "none",
					width = 100000,
					height = 100000,
				},
				on_open = function(_)
					vim.cmd("startinsert!")
				end,
				on_close = function(_) end,
				count = 99,
			})
			lazygit:toggle()
		end

		-- vim.keymap.set("n", "<leader>gl", "<cmd>lua _Lazygit_toggle()<CR>", { desc = "Open Lazygit" })
		--vim.keymap.set("n", "<leader>gl", lazygit_toggle, { desc = "Open Lazygit" })
	end,
}
