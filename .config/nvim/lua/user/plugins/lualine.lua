return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status")

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local mode = {
			"mode",
			fmt = function(str)
				return "-- " .. str .. " --"
			end,
		}

		local filetype = {
			"filetype",
			icons_enabled = false,
			icon = nil,
		}

		local filename = {
			"filename",
			icons_enabled = "false",
			icon = nil,
		}

		local branch = {
			"branch",
			icons_enabled = true,
			icon = "",
		}

		local location = {
			"location",
			padding = 0,
		}

		-- cool function for progress
		local progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end

		local spaces = function()
			return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
		end

		local read_file = function(path)
			local content = ""
			local file = io.open(path, "r")

			if file then
				content = file:read("*a")
				file:close()
			end
			return content
		end

		-- local fileExists = function(file_path)
		-- 	return Path:new(file_path):exists()
		-- end

		local suitecloudaccount = function()
			local cwd = vim.fn.getcwd()

			local data = read_file(cwd .. "/project.json")
			--print(data);
			--local file_lines=lines(data)
			local _, _, c = string.find(data, '"defaultAuthId":%s*"(.*)"')

			--return [[hello world]]
			if c == nil then
				return ""
			else
				return c
			end
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { branch, diagnostics },
				lualine_b = { mode, filename },
				lualine_c = {},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					diff,
					suitecloudaccount,
					"encoding",
					filetype,
				},
				lualine_y = { location },
				lualine_z = { progress },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
