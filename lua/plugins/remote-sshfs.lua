-- lua/plugins/remote-sshfs.lua
return {
	"nosduco/remote-sshfs.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		connections = {
			-- The plugin will read your ~/.ssh/config and list "digitalocean"
			ssh_configs = { vim.fn.expand("$HOME/.ssh/config") },
			sshfs = "sshfs", -- path to sshfs binary; usually just "sshfs"
			sshfs_args = { "-o", "reconnect" }, -- auto-reconnect mounts
		},
		mounts = {
			-- where remote mounts appear locally
			base_dir = vim.fs.normalize(vim.fn.expand("$HOME/.sshfs")),
			unmount_on_exit = true,
		},
	},
	config = function(_, opts)
		local rss = require("remote-sshfs")
		rss.setup(opts)
		require("telescope").load_extension("remote-sshfs")

		local api = require("remote-sshfs.api")
		vim.keymap.set("n", "<leader>rc", api.connect, { desc = "SSHFS connect" })
		vim.keymap.set("n", "<leader>re", api.edit, { desc = "SSHFS edit (pick host/path)" })
		vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "SSHFS disconnect" })
		vim.keymap.set("n", "<leader>rm", "<cmd>Telescope remote-sshfs mounts<cr>", { desc = "SSHFS mounts" })
	end,
}
