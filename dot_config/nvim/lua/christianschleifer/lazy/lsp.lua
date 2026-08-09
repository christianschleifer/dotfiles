local servers = {
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				check = { command = "clippy" },
			},
		},
	},
	pyright = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
			},
		},
	},
	marksman = {},
	jsonls = {},
	jdtls = {},
}

local tools = {
	"rust-analyzer",
	"pyright",
	"lua-language-server",
	"marksman",
	"json-lsp",
	"jdtls",
	"stylua",
	"black",
	"jq",
	"prettier",
	"google-java-format",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = tools,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local telescope = require("telescope.builtin")
				map("grn", vim.lsp.buf.rename, "Rename")
				map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				map("grr", telescope.lsp_references, "References")
				map("gri", telescope.lsp_implementations, "Implementation")
				map("gd", telescope.lsp_definitions, "Definition")
				map("gD", vim.lsp.buf.declaration, "Declaration")
				map("gO", telescope.lsp_document_symbols, "Document Symbols")
				map("gW", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("grt", telescope.lsp_type_definitions, "Type Definition")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
					local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						buffer = event.buf,
						group = highlight_group,
						callback = function()
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
						end,
					})
				end

				if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
					end, "Toggle Inlay Hints")
				end
			end,
		})

		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
			vim.lsp.enable(name)
		end
	end,
}
