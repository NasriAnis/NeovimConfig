-- ============================================================
-- AUTO SAVE
-- ============================================================
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- better one but can cause throttles
-- local autosave_group = vim.api.nvim_create_augroup("AutosaveGroup", { clear = true })
-- local timer = vim.loop.new_timer()

-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave" }, {
--   group = autosave_group,
--   pattern = "*",
--   callback = function()
--     if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" and vim.bo.modifiable then
--       -- Debounce the write: Wait 500ms after the last change before saving
--       timer:start(500, 0, vim.schedule_wrap(function()
--         if vim.api.nvim_buf_is_valid(0) and vim.bo.modified then
--           vim.cmd("silent! write")
--         end
--       end))
--     end
--   end,
-- })

-- ============================================================
-- BUILD SYSTEM
-- ============================================================

-- Rust: set makeprg to cargo when entering a rust file
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "rust",
--   callback = function()
--     local root = vim.fs.find("Cargo.toml", {
--       upward = true,
--       path = vim.fn.expand("%:p:h"),
--     })[1]
--     if root then
--       local root_dir = vim.fn.fnamemodify(root, ":h")
--       vim.opt_local.makeprg = "cargo build --manifest-path " .. root_dir .. "/Cargo.toml --message-format=short 2>&1"
--     else
--       vim.opt_local.makeprg = "cargo build --message-format=short 2>&1"
--     end
--   end,
-- })

-- -- C/C++: set makeprg to make when entering a c/cpp file
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp", "make" },
--   callback = function()
--     local makefile = vim.fs.find({ "Makefile", "makefile", "GNUmakefile" }, {
--       upward = true,
--       path = vim.fn.expand("%:p:h"),
--     })[1]
--     if makefile then
--       local root_dir = vim.fn.fnamemodify(makefile, ":h")
--       vim.opt_local.makeprg = "make -C " .. root_dir .. " 2>&1"
--     else
--       vim.opt_local.makeprg = "make 2>&1"
--     end
--   end,
-- })

-- -- :Build — auto-detects Cargo.toml or Makefile from cwd
-- vim.api.nvim_create_user_command("B", function()
--   local cargo_toml = vim.fs.find("Cargo.toml", {
--     upward = true,
--     path = vim.fn.getcwd(),
--   })[1]
--   local makefile = vim.fs.find({ "Makefile", "makefile", "GNUmakefile" }, {
--     upward = true,
--     path = vim.fn.getcwd(),
--   })[1]

--   if cargo_toml then
--     local root_dir = vim.fn.fnamemodify(cargo_toml, ":h")
--     vim.opt.makeprg = "cargo build --manifest-path " .. root_dir .. "/Cargo.toml --message-format=short 2>&1"
--     vim.cmd("make")
--   elseif makefile then
--     local root_dir = vim.fn.fnamemodify(makefile, ":h")
--     vim.opt.makeprg = "make -C " .. root_dir .. " 2>&1"
--     vim.cmd("make")
--   else
--     vim.notify("No Cargo.toml or Makefile found", vim.log.levels.WARN)
--   end
-- end, {})

-- ============================================================
-- QUICKFIX
-- ============================================================

-- -- Auto open quickfix on errors, close it if none
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--   callback = function()
--     local qflist = vim.fn.getqflist()
--     local has_errors = false
--     for _, item in ipairs(qflist) do
--         if item.valid == 1 then
--         has_errors = true
--         break
--       end
--     end
--     if has_errors then
--       vim.cmd("copen 15")
--     else
--       vim.cmd("cclose")
--     end
--   end,
-- })

-- -- :Next and :Prev to navigate quickfix errors
-- vim.api.nvim_create_user_command("Next", function()
--   vim.cmd("cnext")
-- end, {})

-- vim.api.nvim_create_user_command("Prev", function()
--   vim.cmd("cprev")
-- end, {})

-- ============================================================
-- SESSION
-- ============================================================

-- Close neo-tree before session saves so it doesn't restore broken
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    pcall(vim.cmd, "Neotree close")
  end,
})

