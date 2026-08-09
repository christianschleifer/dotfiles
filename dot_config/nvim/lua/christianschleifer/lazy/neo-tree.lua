local function toggle_neo_tree_focus()
	-- Check if the current window is a Neo-tree buffer
	if vim.bo.filetype == "neo-tree" then
		-- If it is, execute the command to go to the previous window
		vim.cmd("wincmd p")
	else
		-- Otherwise, focus the Neo-tree window
		vim.cmd("Neotree focus")
	end
end

-- Map this new function, for example, to your original <leader>e
vim.keymap.set("n", "<leader>e", toggle_neo_tree_focus, { desc = "Toggle focus between file and Neo-tree" })
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					hide_dotfiles = false,
				},
			},
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			window = {
				mappings = {
					["o"] = "open",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							vim.fn.setreg("+", node.path)
							vim.notify("Copied: " .. node.path)
						end,
						desc = "Copy absolute path",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>e", toggle_neo_tree_focus, { desc = "Focus Neo-tree" })
		vim.keymap.set("n", "<f12>", "<Cmd>Neotree document_symbols<CR>", { desc = "Toggle symbol explorer" })
	end,
}
