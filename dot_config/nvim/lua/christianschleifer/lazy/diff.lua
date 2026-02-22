return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
		{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File History" },
		{ "<leader>ga", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: Project History" },
	},
	opts = {
		enhanced_diff_hl = true, -- Better syntax highlighting in diffs
	},
}
