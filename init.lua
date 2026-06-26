vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.enable(false)

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")
require("core.autocmds")

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})

-- ============================================================
-- QUICKFIX AND AUTOCOMPILE / ERRORS
-- ============================================================
-- Rust
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "rust",
--     callback = function()
--         vim.cmd("compiler cargo")
--         vim.opt_local.makeprg = "cargo build"
--     end,
-- })

-- -- C/C++
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "c", "cpp" },
--     callback = function()
--         vim.cmd("compiler gcc")
--         vim.opt_local.makeprg = "make"
--     end,
-- })

-- -- Build
-- --
-- vim.keymap.set("n", "<leader>b", function()
--     vim.api.nvim_echo({ { "󱎫 Building...", "WarningMsg" } }, false, {})

--     vim.cmd("silent make")

--     if vim.fn.getqflist({ size = 0 }).size > 0 then
--         vim.cmd("copen")
--         vim.api.nvim_echo({ { " Build failed", "ErrorMsg" } }, false, {})
--     else
--         vim.api.nvim_echo({ { " Build succeeded", "MoreMsg" } }, false, {})
--     end
-- end, { desc = "Build project" })

-- -- vim.keymap.set("n", "<leader>b", function()
-- --     vim.cmd("silent make")

-- --     if vim.fn.getqflist({ size = 0 }).size > 0 then
-- --         vim.cmd("copen")
-- --     else
-- --         vim.notify("Build succeeded!")
-- --     end
-- -- end, { desc = "Build project" })

-- -- Quickfix navigation
-- vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
-- vim.keymap.set("n", "[q", "<cmd>cprev<CR>")
-- vim.keymap.set("n", "<leader>q", "<cmd>cclose<CR>")

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "qf",
--     callback = function(event)
--         vim.keymap.set("n", "q", "<cmd>cclose<CR>", {
--             buffer = event.buf,
--             silent = true,
--             desc = "Close quickfix",
--         })
--     end,
-- })

-- TEMP: paste this in your config or run via :lua, press Enter on an error line first
local function debug_wins()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft   = vim.api.nvim_buf_get_option(buf, "filetype")
    local bt   = vim.api.nvim_buf_get_option(buf, "buftype")
    local name = vim.api.nvim_buf_get_name(buf)
    print(string.format("win=%d ft=%q bt=%q name=%q", win, ft, bt, name))
  end
end

debug_wins()