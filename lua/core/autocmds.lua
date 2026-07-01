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

-- ============================================================
-- Terminal
-- ============================================================
local term_bufnr = nil
local prev_bufnr = nil

local function toggle_term()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- If we're already in the terminal, go back to previous buffer
  if cur_buf == term_bufnr then
    if prev_bufnr and vim.api.nvim_buf_is_valid(prev_bufnr) then
      vim.api.nvim_set_current_buf(prev_bufnr)
    else
      vim.cmd("bprevious")
    end
    return
  end

  -- Save where we are before jumping
  prev_bufnr = cur_buf

  -- Reuse existing terminal buffer if alive
  if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
    vim.api.nvim_set_current_buf(term_bufnr)
    vim.cmd("startinsert")
    return
  end

  -- Create a new terminal buffer
  vim.cmd("enew")
  vim.cmd("terminal")
  term_bufnr = vim.api.nvim_get_current_buf()

  -- Don't list it in bufferline
  vim.bo[term_bufnr].buflisted = false

  vim.wo.number = false
  vim.wo.relativenumber = false

  vim.api.nvim_buf_attach(term_bufnr, false, {
    on_detach = function()
      term_bufnr = nil
      prev_bufnr = nil
    end,
  })

  vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-t>", toggle_term, { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-t>", toggle_term, { desc = "Toggle terminal" })
