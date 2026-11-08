local function is_nixos()
	return vim.fn.isdirectory("/etc/nixos") == 1
end

return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim on non-NixOS systems
		{ "williamboman/mason.nvim", cond = not is_nixos() },
		{ "williamboman/mason-lspconfig.nvim", cond = not is_nixos() },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", cond = not is_nixos() },

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Configure diagnostics UI (virtual_text disabled because tiny-inline-diagnostic.nvim is used)
		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = "if_many",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Telescope LSP pickers
				local builtin = require("telescope.builtin")
				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Core LSP actions
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gl", vim.diagnostic.open_float, "[G]oto Diagnostic [L]oc")
				map("K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, "Hover Documentation")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Broadcast nvim-cmp and nvim-ufo folding capabilities to LSP servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- Resolve @vue/typescript-plugin path dynamically from vue-language-server (works on both NixOS and Mason/npm)
		local vue_plugin_path = ""
		local vue_bin = vim.fn.exepath("vue-language-server")
		if vue_bin ~= "" then
			local real_path = vim.uv.fs_realpath(vue_bin)
			if real_path then
				local package_root = real_path:match("(.*)/bin/")
				if package_root then
					local candidate_paths = {
						package_root .. "/lib/language-tools/packages/typescript-plugin",
						package_root .. "/lib/language-tools/packages/language-server",
						package_root .. "/lib/packages/typescript-plugin",
					}
					for _, candidate in ipairs(candidate_paths) do
						if vim.uv.fs_stat(candidate) then
							vue_plugin_path = candidate
							break
						end
					end
				end
			end
		end

		local ts_plugins = {}
		if vue_plugin_path ~= "" then
			table.insert(ts_plugins, {
				name = "@vue/typescript-plugin",
				location = vue_plugin_path,
				languages = { "vue" },
			})
		end

		local servers = {
			vue_ls = {},
			nil_ls = {
				settings = {
					["nil"] = {
						formatting = {
							command = { "nixfmt" },
						},
					},
				},
			},
			bashls = {},
			yamlls = {
				filetypes = { "yaml" },
			},
			clangd = {
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			},
			sqls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			ts_ls = {
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					plugins = ts_plugins,
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayVariableTypeHintsWhenTypeMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayVariableTypeHintsWhenTypeMatchesName = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
		}

		if not is_nixos() then
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({ automatic_enable = false })
		end

		-- Register and enable all configured servers using Neovim 0.12 native vim.lsp.config / vim.lsp.enable
		for server_name, server_config in pairs(servers) do
			local final_config = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
			}, server_config or {})

			vim.lsp.config(server_name, final_config)
			vim.lsp.enable(server_name)
		end
	end,
}
