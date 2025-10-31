-- Conform-based code formatting (2025-10)

-- Detect if the current visual selection covers the entire buffer.
local function selection_covers_entire_buffer()
	local mode = vim.fn.mode()
	if not (mode == "v" or mode == "V" or mode == "\022") then
		return false
	end
	local srow, scol = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local erow, ecol = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))

	-- Normalize order (selection might be made backwards)
	if srow > erow or (srow == erow and scol > ecol) then
		srow, erow = erow, srow
		scol, ecol = ecol, scol
	end

	local lastline = vim.api.nvim_buf_line_count(0)
	if mode == "V" then
		-- Visual-line: full file if it spans first..last line
		return srow == 1 and erow == lastline
	else
		-- Char/block-wise: start at (1,1) and end at last line's end
		local start_ok = (srow == 1 and scol <= 1)
		local lastcol = vim.fn.col({ erow, "$" }) - 1
		local end_ok = (erow == lastline and ecol >= lastcol)
		return start_ok and end_ok
	end
end

-- Filetypes where range formatting is often unreliable (import sorting, etc.)
local WHOLE_FILE_ONLY = {
	python = true, -- ruff_fix/ruff_format
	go = true, -- goimports/gofumpt
	java = true,
	sh = true,
	rust = true,
	c = true,
	cpp = true,
}

-- Smart format: choose range vs full-file based on mode/selection/filetype,
-- and leave visual mode after range formatting.
local function smart_format()
	local ft = vim.bo.filetype
	local mode = vim.fn.mode()
	local use_range = false
	if mode == "v" or mode == "V" or mode == "\022" then
		if not WHOLE_FILE_ONLY[ft] then
			use_range = not selection_covers_entire_buffer()
		end
	end

	require("conform").format({
		lsp_format = "fallback",
		timeout_ms = 2000,
		range = use_range and true or nil, -- nil => full-file
	}, function(err)
		if not err then
			local m = vim.api.nvim_get_mode().mode
			if m:lower():sub(1, 1) == "v" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end

-- Helper: pick the first *available* formatter at runtime.
local function first(bufnr, ...)
	local conform = require("conform")
	for i = 1, select("#", ...) do
		local f = select(i, ...)
		local info = conform.get_formatter_info(f, bufnr)
		if info and info.available then
			return f
		end
	end
	return select(1, ...)
end

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			-- Smart format in both Normal and Visual modes
			{
				"<leader>lf",
				function()
					smart_format()
				end,
				mode = { "n", "v" },
				desc = "Format (smart)",
			},

			-- Force whole-file formatting (even from Visual mode)
			{
				"<leader>lF",
				function()
					require("conform").format({
						lsp_format = "fallback",
						timeout_ms = 2000,
						range = nil,
					}, function(err)
						if not err then
							local m = vim.api.nvim_get_mode().mode
							if m:lower():sub(1, 1) == "v" then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
									"n",
									true
								)
							end
						end
					end)
				end,
				mode = { "n", "v" },
				desc = "Format whole file (force)",
			},

			-- Inspect configured/available formatters & logs
			{ "<leader>li", "<cmd>ConformInfo<cr>", desc = "Conform info" },
		},

		opts = {
			-- Pick formatters per filetype. Lists run sequentially unless stop_after_first.
			formatters_by_ft = {
				lua = { "stylua" },

				-- Python: prefer Ruff (fixes + format); fallback to isort+black if Ruff formatter missing
				python = function(bufnr)
					local c = require("conform")
					if c.get_formatter_info("ruff_format", bufnr).available then
						-- Run fixes first (unused imports, etc.), then final formatting
						return { "ruff_fix", "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,

				-- Web stack: prefer Biome if present; else Prettier (prettierd > prettier)
				javascript = function(bufnr)
					return { first(bufnr, "biome", "prettierd", "prettier") }
				end,
				typescript = function(bufnr)
					return { first(bufnr, "biome", "prettierd", "prettier") }
				end,
				javascriptreact = function(bufnr)
					return { first(bufnr, "biome", "prettierd", "prettier") }
				end,
				typescriptreact = function(bufnr)
					return { first(bufnr, "biome", "prettierd", "prettier") }
				end,
				json = function(bufnr)
					return { first(bufnr, "biome", "prettierd", "prettier") }
				end,

				yaml = { "yamlfmt" },
				toml = { "taplo" },

				-- Markdown: formatter + injected code blocks
				markdown = function(bufnr)
					return { first(bufnr, "prettierd", "prettier"), "injected" }
				end,

				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },

				go = { "goimports", "gofumpt" }, -- imports then stricter style
				rust = { "rustfmt" },

				c = { "clang-format" },
				cpp = { "clang-format" },
			},

			-- Small, pragmatic formatter tweaks
			formatters = {
				shfmt = { append_args = { "-i", "2", "-bn", "-ci", "-sr" } },
				-- You can also tweak biome/prettier args here if needed.
			},

			-- Format on save; avoid giant files; prefer external tools for web filetypes
			format_on_save = function(bufnr)
				local max = 200 * 1024 -- 200 KB
				local name = vim.api.nvim_buf_get_name(bufnr)
				if name:find("/node_modules/") then
					return
				end
				if vim.fn.getfsize(name) > max then
					return
				end

				local external_only = {
					javascript = true,
					typescript = true,
					javascriptreact = true,
					typescriptreact = true,
					json = true,
					yaml = true,
					markdown = true,
				}
				return {
					lsp_format = external_only[vim.bo[bufnr].filetype] and false or "fallback",
					timeout_ms = 2000,
				}
			end,

			-- Optional: surface errors in a friendly way
			notify_on_error = true,
			notify_no_formatters = true,
		},
	},
}
