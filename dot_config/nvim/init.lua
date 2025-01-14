--- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99

-- never show me line breaks if they're not there
vim.opt.wrap = false

-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'

-- sweet sweet relative line numbers
vim.opt.relativenumber = true

-- and show the absolute line number for the current line
vim.opt.number = true

-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true

-- Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'

-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true

-- never ever make my terminal beep
vim.opt.vb = true

-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'

--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })

-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- the colorscheme should be available when starting Neovim
		{
			"folke/tokyonight.nvim",
			lazy = false, -- make sure we load this during startup if it is your main colorscheme
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				-- load the colorscheme here
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
		-- nice bar at the bottom
		{
			'itchyny/lightline.vim',
			lazy = false, -- also load at start since it's UI
			config = function()
				-- no need to also show mode in cmd line when we have bar
				vim.o.showmode = false
				vim.g.lightline = {
					active = {
						left = {
							{ 'mode', 'paste' },
							{ 'readonly', 'filename', 'modified' }
						},
						right = {
							{ 'lineinfo' },
							{ 'percent' },
							{ 'fileencoding', 'filetype' }
						},
					},
					component_function = {
						filename = 'LightlineFilename'
					},
				}
				function LightlineFilenameInLua(opts)
					if vim.fn.expand('%:t') == '' then
						return '[No Name]'
					else
						return vim.fn.getreg('%')
					end
				end
				-- https://github.com/itchyny/lightline.vim/issues/657
				vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
				return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
				)
			end
		},
		{
			"ibhagwan/fzf-lua",
			-- optional for icon support
			dependencies = { "nvim-tree/nvim-web-devicons" },
			-- or if using mini.icons/mini.nvim
			-- dependencies = { "echasnovski/mini.icons" },
			opts = {}
		}

	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.api.nvim_set_keymap("n", "<C-\\>", [[<Cmd>lua require"fzf-lua".buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-k>", [[<Cmd>lua require"fzf-lua".builtin()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-p>", [[<Cmd>lua require"fzf-lua".files()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-l>", [[<Cmd>lua require"fzf-lua".live_grep_glob()<CR>]], {})
vim.api.nvim_set_keymap("n", "<C-g>", [[<Cmd>lua require"fzf-lua".grep_project()<CR>]], {})
vim.api.nvim_set_keymap("n", "<F1>", [[<Cmd>lua require"fzf-lua".help_tags()<CR>]], {})

require("fzf-lua").utils.info(
  "|<C-\\> buffers|<C-p> files|<C-g> grep|<C-l> live grep|<C-k> builtin|<F1> help|")
