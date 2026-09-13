-- Collection of various small independent plugins/modules
return {
	"nvim-mini/mini.nvim",
	config = function()
		require("mini.ai").setup({})
		require("mini.pairs").setup({})
		require("mini.diff").setup({})
	end,
}
