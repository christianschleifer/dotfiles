return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit: Open" },
		{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit: Commit" },
	},
	opts = {
		integrations = {
			diffview = true,
		},
	},
}
