local M = {}

local plenary_popup = require("plenary.popup")

local function copy_buffer_to_clipboard(bufnr)
	-- Check if the buffer number is valid
	if type(bufnr) ~= "number" then
		print("Error: Buffer number must be a number.")
		return
	end

	if not vim.api.nvim_buf_is_valid(bufnr) then
		print("Error: Invalid buffer number.")
		return
	end

	-- Get the lines of the buffer
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) -- 0 and -1 get all lines

	-- Join the lines into a single string
	local text = table.concat(lines, "\n")

	-- Set the clipboard contents
	vim.fn.setreg("+", text) -- Use the '+' register for system clipboard
end

function M.create_popup()
	-- Get current buffer number and file path
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)

	-- Transform the path
	local start_index = string.find(filepath, "TypeScripts/")
	if not start_index then
		print("Error: TypeScripts/ directory not found in the file path.")
		return
	end

	local modPath = string.gsub(string.sub(filepath, start_index), "%.ts$", "")
	modPath = "SuiteScripts/" .. string.sub(modPath, 13) -- Remove "TypeScripts/" from the path

	-- Create a new buffer for the popup
	--local bufnr_popup = vim.api.nvim_create_buf(false, true)

	local mod_contents = ""

	-- Set content of the popup buffer
	local content = { string.format('require(["%s"],(mod)=>{', modPath), mod_contents, "})" }
	--vim.api.nvim_buf_set_lines(bufnr_popup, 0, -1, false, content)

	-- Create a window for the popup buffer using plenary.popup.create
	local _, win = plenary_popup.create(content, {
		title = "SuiteScript Path",
		highlight = "Pmenu",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		pos = "center",
		minwidth = #modPath + 21,
		minheight = 6,
	})

	local bufnr_popup = vim.api.nvim_win_get_buf(win.win_id)

	-- Make the popup buffer readonly
	--vim.api.nvim_buf_set_option(bufnr_popup, "modifiable", false)

	local function close_window(wid)
		if vim.api.nvim_win_is_valid(wid) then
			vim.api.nvim_win_close(wid, true) -- Force close the window
		end
	end

	local function close_popup()
		-- Close the window first
		close_window(win.win_id)
		close_window(win.border.win_id)
		-- Delete the buffer
		if vim.api.nvim_buf_is_valid(bufnr_popup) then
			vim.api.nvim_buf_delete(bufnr_popup, { force = true })
		end
		vim.cmd("autocmd! FocusLost <buffer=" .. bufnr_popup .. ">")
	end

	local function close_and_remove_autocmd()
		close_popup()
	end

	vim.api.nvim_create_autocmd("WinLeave", {
		buffer = bufnr_popup,
		callback = close_and_remove_autocmd,
	})
	-- Map 'q' to close the popup window
	vim.api.nvim_buf_set_keymap(bufnr_popup, "n", "q", "", { noremap = true, silent = true, callback = close_popup })
	vim.api.nvim_buf_set_keymap(bufnr_popup, "n", "y", "", {
		silent = true,
		callback = function()
			copy_buffer_to_clipboard(bufnr_popup)
			close_popup()
		end,
	})
end

return M
