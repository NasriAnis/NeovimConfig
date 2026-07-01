-- ============================================================
-- EDITOR
-- ============================================================

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50 --250
vim.opt.signcolumn = "yes"

-- ============================================================
-- INDENTATION
-- ============================================================

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ============================================================
-- COMPLETION MENU
-- ============================================================

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"

-- ============================================================
-- VISUALS
-- ============================================================

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Show tabs and trailing spaces
vim.opt.list = true
vim.opt.listchars = {
  -- space = "·",
  tab = "→ ",
  trail = "·",
}

-- ============================================================
-- MISC
-- ============================================================

vim.deprecate = function() end -- silence deprecation warnings

-- Disable netrw so neo-tree handles directories
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.hidden = true
