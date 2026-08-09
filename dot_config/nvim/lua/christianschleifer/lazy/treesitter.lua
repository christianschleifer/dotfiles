local parsers = {
	"java",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup({})
		treesitter.install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Enable Treesitter highlighting",
			group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
			pattern = { "java", "json", "jsonc", "lua", "markdown", "python", "rust" },
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
