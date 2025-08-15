return {
	"folke/zen-mode.nvim",
	config = function()
		require("zen-mode").setup({
			window = {
				width = 150,
			},
		})
		vim.keymap.set("n", "<leader>z", function()
			require("zen-mode").toggle()
		end, { desc = "Zen Mode" })
	end,
}
