vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- set makeprg based on filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.makeprg = "cargo build 2>&1"
  end,
})

-- close quickfix automatically if no errors
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    local qflist = vim.fn.getqflist()
    if #qflist == 0 then
      vim.cmd("cclose")
    else
      vim.cmd("copen")
    end
  end,
})

-- close special buffers before saving session
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- close neo-tree before session saves so it doesn't restore
    pcall(vim.cmd, "Neotree close")
  end,
})