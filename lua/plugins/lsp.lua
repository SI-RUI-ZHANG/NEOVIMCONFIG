-- lua/plugins/lsp.lua
return {
	-- Mason (external tools/LSPs)
	{ "mason-org/mason.nvim", opts = {} },

	-- Bridge: installs + (by default) enables LSP servers on 0.11+
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig", -- provides server presets in runtimepath/lsp/
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"gopls",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"bashls",
				"marksman",
				"clangd",
				"rust_analyzer",
			},
			automatic_enable = true, -- mason-lspconfig v2 will call vim.lsp.enable()
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- Capabilities from your completion engine (works with nvim-cmp or blink.cmp)
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
				vim.lsp.config(server, cfg) -- new API (0.11+)
			end

			-- Only override servers you want to tweak; others use upstream defaults.
			conf("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			})
			conf("ts_ls") -- TS (renamed from tsserver)
			conf("pyright") -- examples; add settings only if needed
			conf("gopls")
			conf("rust_analyzer")

			-- LSP-only keymaps via LspAttach (recommended on 0.11+)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
				callback = function(ev)
					local map = function(m, lhs, rhs, desc)
						vim.keymap.set(m, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
					end
					map("n", "gd", vim.lsp.buf.definition, "Definition")
					map("n", "gr", require("telescope.builtin").lsp_references, "References")
					map("n", "gD", vim.lsp.buf.declaration, "Declaration")
					map("n", "gi", vim.lsp.buf.implementation, "Implementation")
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					-- 💡 Diagnostics (put here)
					map("n", "<leader>le", vim.diagnostic.open_float, "Line diagnostics")
					map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("n", "<leader>lq", vim.diagnostic.setqflist, "Diagnostics quickfix")
				end,
			})
		end,
	},
}
