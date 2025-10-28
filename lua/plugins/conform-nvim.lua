-- Conform-based code formatting

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
		local lastcol = vim.fn.col({ erow, "$" }) - 1 -- last character column
		local end_ok = (erow == lastline and ecol >= lastcol)
		return start_ok and end_ok
	end
end

-- Filetypes where range formatting is unreliable: always format whole file.
local WHOLE_FILE_ONLY = {
	python = true, -- black/ruff_format
	go = true, -- goimports/gofmt
	java = true, -- google-java-format
	sh = true, -- shfmt
}

-- Smart format: choose range vs full-file based on mode/selection/filetype.
local function smart_format(opts)
	opts = opts or {}
	local ft = vim.bo.filetype
	local mode = vim.fn.mode()

	local use_range = false
	if mode == "v" or mode == "V" or mode == "\022" then
		if not WHOLE_FILE_ONLY[ft] then
			-- If selection is the entire buffer, prefer full-file for stability.
			use_range = not selection_covers_entire_buffer()
		end
	end

	require("conform").format({
		lsp_format = "fallback",
		timeout_ms = 1000,
		range = use_range and true or nil, -- nil => full-file
	})
end

return {
	{
		"stevearc/conform.nvim",
    event = { "BufWritePre" },
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
					require("conform").format({ lsp_format = "fallback", timeout_ms = 1000, range = nil })
				end,
				mode = { "n", "v" },
				desc = "Format whole file (force)",
			},

			-- Inspect configured/available formatters & logs
			{ "<leader>li", "<cmd>ConformInfo<cr>", desc = "Conform info" },
		},
		opts = {
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

        -- Others
        sh = { "shfmt" },
        go = { "goimports", "gofmt" },
      },

			-- Format on save; fall back to LSP if no external formatter
			format_on_save = function(bufnr)
				local max = 200 * 1024 -- 200 KB
				if vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > max then
					return
				end
				return { lsp_format = "fallback", timeout_ms = 1000 }
			end,
		},
	},
}
