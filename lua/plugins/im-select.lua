return {
	"keaising/im-select.nvim",
	event = "VeryLazy",
	opts = {
		-- English layout to use in Normal mode:
		default_im_select = "com.apple.keylayout.US",
		set_default_events = { "InsertLeave", "CmdlineLeave" },
		set_previous_events = { "InsertEnter" }, -- restore the IME you last used in Insert
	},
}
