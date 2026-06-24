vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- find the workspace root (where Cargo.toml is)
    local root = vim.fs.find("Cargo.toml", {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })[1]

    if root then
      local root_dir = vim.fn.fnamemodify(root, ":h")
      vim.opt_local.makeprg = "cargo build --manifest-path " .. root_dir .. "/Cargo.toml 2>&1"
    else
      vim.opt_local.makeprg = "cargo build 2>&1"
    end
  end,
})

-- close quickfix automatically if no errors
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    local qflist = vim.fn.getqflist()
    local has_errors = false
    for _, item in ipairs(qflist) do
      if item.type == "E" then
        has_errors = true
        break
      end
    end
    if has_errors then
      vim.cmd("copen")
    else
      vim.cmd("cclose")
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


-- This is fore automitic build check --
-- :Next and :Prev to navigate errors
vim.api.nvim_create_user_command("Next", function()
  vim.cmd("cnext")
end, {})

vim.api.nvim_create_user_command("Prev", function()
  vim.cmd("cprev")
end, {})

vim.api.nvim_create_user_command("Build", function()
  local cargo_toml = vim.fs.find("Cargo.toml", {
    upward = true,
    path = vim.fn.getcwd(), -- use cwd instead of current buffer path
  })[1]

  if cargo_toml then
    local root_dir = vim.fn.fnamemodify(cargo_toml, ":h")
    vim.opt.makeprg = "cargo build --manifest-path " .. root_dir .. "/Cargo.toml 2>&1"
    vim.cmd("make")
  else
    vim.notify("No Cargo.toml found", vim.log.levels.WARN)
  end
end, {})