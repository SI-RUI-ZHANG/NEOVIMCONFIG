return {
	{ "mason-org/mason.nvim", opts = {} },

	-- ensure non-LSP tools (formatters/linters) exist
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			run_on_start = true,
			auto_update = false,
			ensure_installed = {
				-- formatters
				"stylua",
				"shfmt",
				"clang-format",
				"gofumpt",
				"goimports",
				"rustfmt",
				"taplo",
				"yamlfmt",
				-- JS/TS formatting: choose ONE line below
				"prettierd", -- <-- Option A (Prettier daemon)
				-- "biome",   -- <-- Option B (unified linter+formatter)

				-- linters (add as you like)
				"shellcheck",
				"markdownlint-cli2",

				-- Python toolchain (Ruff does lint + format + LSP server)
				"ruff",
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				-- core/common
				"lua_ls",
				"basedpyright",
				"ruff", -- native Ruff LSP
				"gopls",
				"ts_ls", -- typescript-language-server (new name)
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				"bashls",
				"marksman",
				"clangd",
				"rust_analyzer",
				"dockerls",
				"docker_compose_language_service",
				"taplo",
				"emmet_ls",
				"tailwindcss",
				-- If you prefer VSCode-like TS features, you can also try:
				-- "vtsls",
			},
			automatic_enable = true, -- mason-lspconfig will vim.lsp.enable() installed servers
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- capabilities (works with nvim-cmp or blink.cmp)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			else
				local ok_blink, blink = pcall(require, "blink.cmp")
				if ok_blink and blink.get_lsp_capabilities then
					capabilities = blink.get_lsp_capabilities(capabilities)
				end
			end

			local function conf(server, cfg)
				cfg = cfg or {}
				cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
				vim.lsp.config(server, cfg)
			end

			-- server configs
			conf("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
						hint = { enable = true },
					},
				},
			})

			-- Python: BasedPyright + Ruff (disable Ruff hover so Pyright handles it)
			conf("basedpyright")
			conf("ruff", {
				on_attach = function(client, _)
					client.server_capabilities.hoverProvider = false
				end,
				init_options = { settings = {} },
			})

			-- Web/TS
			conf("ts_ls") -- or conf("vtsls") if you prefer that server
			conf("html")
			conf("cssls")
			conf("tailwindcss")
			conf("emmet_ls")
			conf("jsonls")
			conf("yamlls")

			-- Others
			conf("gopls")
			conf("rust_analyzer")
			conf("clangd")
			conf("bashls")
			conf("marksman")
			conf("dockerls")
			conf("docker_compose_language_service")
			conf("taplo")

			-- your existing LspAttach keymaps stay the same
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local ok_snacks, snacks = pcall(require, "snacks")
					local map = function(m, lhs, rhs, desc)
						vim.keymap.set(m, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
					end
					map("n", "gd", ok_snacks and function()
						snacks.picker.lsp_definitions()
					end or vim.lsp.buf.definition, "Goto Definition")
					map("n", "gD", ok_snacks and function()
						snacks.picker.lsp_declarations()
					end or vim.lsp.buf.declaration, "Goto Declaration")
					map("n", "gr", ok_snacks and function()
						snacks.picker.lsp_references()
					end or function()
						vim.lsp.buf.references({ includeDeclaration = false })
					end, "References")
					map("n", "gi", ok_snacks and function()
						snacks.picker.lsp_implementations()
					end or vim.lsp.buf.implementation, "Goto Implementation")
					map("n", "gy", ok_snacks and function()
						snacks.picker.lsp_type_definitions()
					end or vim.lsp.buf.type_definition, "Goto Type Definition")
					map("n", "gai", ok_snacks and function()
						snacks.picker.lsp_incoming_calls()
					end or vim.lsp.buf.incoming_calls, "Incoming Calls")
					map("n", "gao", ok_snacks and function()
						snacks.picker.lsp_outgoing_calls()
					end or vim.lsp.buf.outgoing_calls, "Outgoing Calls")
					map("n", "<leader>ss", ok_snacks and function()
						snacks.picker.lsp_symbols()
					end or vim.lsp.buf.document_symbol, "Document Symbols")
					map("n", "<leader>sS", ok_snacks and function()
						snacks.picker.lsp_workspace_symbols()
					end or vim.lsp.buf.workspace_symbol, "Workspace Symbols")
					map("n", "<leader>sd", ok_snacks and function()
						snacks.picker.diagnostics()
					end or function()
						vim.diagnostic.setqflist({ open = true })
					end, "Workspace Diagnostics")
					map("n", "<leader>sD", ok_snacks and function()
						snacks.picker.diagnostics_buffer()
					end or function()
						vim.diagnostic.setloclist(0, { open = true })
					end, "Buffer Diagnostics")
					map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
					map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					map("n", "<leader>le", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("n", "<leader>lq", vim.diagnostic.setqflist, "Diagnostics quickfix")
				end,
			})
		end,
	},
}
