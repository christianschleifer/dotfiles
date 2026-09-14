local function toggle_neo_tree()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd("Neotree close")
	else
		vim.cmd("Neotree focus")
	end
end

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
					["<esc>"] = function()
						vim.cmd("wincmd p")
					end,
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

		vim.keymap.set("n", "<leader>e", toggle_neo_tree, { desc = "Toggle Neo-tree" })
		if vim.uv.os_uname().sysname == "Darwin" then
			vim.keymap.set("n", "<D-1>", toggle_neo_tree, { desc = "Toggle Neo-tree" })
			vim.keymap.set("i", "<D-1>", function()
				vim.cmd("stopinsert")
				toggle_neo_tree()
			end, { desc = "Toggle Neo-tree" })
		end
		vim.keymap.set("n", "<f12>", "<Cmd>Neotree document_symbols<CR>", { desc = "Open symbol explorer" })
	end,
}
