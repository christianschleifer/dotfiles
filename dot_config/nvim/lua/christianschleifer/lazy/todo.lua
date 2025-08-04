return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	config = function()
		require("todo-comments").setup({})
	end,
}
