return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	keys = {
		{
			"<C-n>",
			function()
				require("multicursor-nvim").matchAddCursor(1)
			end,
			mode = { "n", "x" },
			desc = "Multi-cursor: select next occurrence",
		},
	},
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		mc.addKeymapLayer(function(layer_set)
			layer_set({ "n", "x" }, "<C-x>", function()
				mc.matchSkipCursor(1)
			end)
			layer_set({ "n", "x" }, "<C-p>", mc.deleteCursor)
			layer_set("n", "<Esc>", function()
				if mc.cursorsEnabled() then
					mc.clearCursors()
				else
					mc.enableCursors()
				end
			end)
		end)
	end,
}
