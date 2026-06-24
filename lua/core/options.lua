vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50 --250
vim.opt.clipboard = "unnamedplus"

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"

-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = "●",  -- icon before the message
--     spacing = 4,
--   },
--   signs = true,
--   underline = true,
--   update_in_insert = false, -- don't show errors while typing
--   severity_sort = true,
-- })

vim.deprecate = function() end -- silence deprecation warnings

-- rounded borders on ALL LSP floating windows
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_open_floating_preview(contents, syntax, opts, ...)
end

-- disable netrw so neo-tree handles directories
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
