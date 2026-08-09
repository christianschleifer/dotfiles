return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{ "<leader>gd", "<cmd>CodeDiff<cr>", desc = "CodeDiff: Open" },
		{ "<leader>gh", "<cmd>CodeDiff history %<cr>", desc = "CodeDiff: File History" },
		{ "<leader>ga", "<cmd>CodeDiff history<cr>", desc = "CodeDiff: Project History" },
	},
	opts = {
		diff = {
			layout = "side-by-side",
		},
	},
}
