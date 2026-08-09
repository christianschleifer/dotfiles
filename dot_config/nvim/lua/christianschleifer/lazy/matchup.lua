return {
	"andymass/vim-matchup",
	init = function()
		vim.g.matchup_matchparen_deferred = 1
	end,
	config = function()
		require("match-up").setup({})
	end,
}
