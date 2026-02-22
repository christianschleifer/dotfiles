return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bold = false,
		italic = {
			strings = false,
			emphasis = false,
			comments = false,
			operators = false,
		},
	},
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.cmd("colorscheme gruvbox")
	end,
}
