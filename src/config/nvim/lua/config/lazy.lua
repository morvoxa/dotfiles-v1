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

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>", {})
vim.api.nvim_set_keymap("i", "jk", "<esc>", {})
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>w", {})
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 4
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})
