-- Autoformat
return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		notify_on_error = true,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			json = { "jq" },
			markdown = { "prettier", "injected" },
			java = { "google-java-format" },
		},
		formatters = {
			prettier = {
				append_args = { "--print-width", "140", "--prose-wrap", "always" },
			},
		},
	},
}
