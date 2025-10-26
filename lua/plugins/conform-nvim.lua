-- lua/plugins/formatting.lua
-- Code formatting with Conform (copy-paste ready)
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- load before saving
		keys = {
			-- Format whole buffer (normal mode)
			{
				"<leader>lf",
				function()
					require("conform").format({ lsp_format = "fallback", timeout_ms = 1000 })
				end,
				mode = "n",
				desc = "Format file (Conform)",
			},
			-- Format selection (visual mode) — Conform auto-uses the selection
			{
				"<leader>lf",
				function()
					require("conform").format({ lsp_format = "fallback", timeout_ms = 1000 })
				end,
				mode = "v",
				desc = "Format selection (Conform)",
			},
			-- Force format the whole file (even from visual mode)
			{
				"<leader>lF",
				function()
					require("conform").format({ lsp_format = "fallback", timeout_ms = 1000, range = nil })
				end,
				mode = { "n", "v" },
				desc = "Format whole file (force)",
			},
			-- Inspect available formatters & logs
			{ "<leader>li", "<cmd>ConformInfo<cr>", desc = "Conform info" },
		},
		opts = {
			-- Run formatters per filetype (first available wins if stop_after_first)
			formatters_by_ft = {
				lua = { "stylua" },

				-- Prefer ruff if available, otherwise isort+black
				python = function(bufnr)
					local c = require("conform")
					if c.get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,

				-- JS/TS & friends
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },

				-- HTML & Java (added)
				html = { "prettierd", "prettier", stop_after_first = true },
				java = { "google-java-format" },

				-- Others
				sh = { "shfmt" },
				go = { "goimports", "gofmt" },
			},

			-- Format on save; fall back to LSP if no external formatter
			format_on_save = function(bufnr)
				-- Disable for very large files
				local max = 200 * 1024 -- 200 KB
				if vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max then
					return
				end
				return { lsp_format = "fallback", timeout_ms = 1000 }
			end,
		},
	},
}
