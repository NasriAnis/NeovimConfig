local map = vim.keymap.set

-- stop highlights with escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>rr", "<cmd>restart<cr>", { desc = "restart" })

-- ============================================================
-- SPLITS
-- ============================================================

map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })

-- in keymaps.lua
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close split" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other splits" })

-- ============================================================
-- BUFFERS
-- ============================================================

-- Cycle through buffer tabs
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
map("n", "<leader>bd", function()
  local bufs = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted and vim.api.nvim_buf_get_name(b):match("NvimTree") == nil
  end, vim.api.nvim_list_bufs())
  local cur = vim.api.nvim_get_current_buf()
  vim.cmd("bnext")
  vim.cmd("bdelete " .. cur)
end, { desc = "Close current buffer" })

-- Close all buffers except current
-- map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
map("n", "<leader>ba", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local ok, bt = pcall(function() return vim.bo[buf].buftype end)
    local name = vim.api.nvim_buf_get_name(buf)
    if buf ~= cur
      and vim.bo[buf].buflisted
      and (not ok or bt == "")
      and not name:match("NvimTree")
    then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close all other buffers" })

-- Close all buffers
-- map("n", "<leader>bA", "<cmd>%bd<CR>", { desc = "Close all buffers" })
map("n", "<leader>bA", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local ok, bt = pcall(function() return vim.bo[buf].buftype end)
    local name = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].buflisted
      and (not ok or bt == "")
      and not name:match("NvimTree")
    then
      pcall(vim.api.nvim_buf_delete, buf, { force = false })
    end
  end
end, { desc = "Close all buffers" })

-- ============================================================
-- QUICKFIX / ERRORS
-- ============================================================

map("n", "]e", "<cmd>cnext<cr>", { desc = "Next error" })
map("n", "[e", "<cmd>cprev<cr>", { desc = "Prev error" })

-- ============================================================
-- Telescope
-- ============================================================
-- vim.keymap.set("n", "<leader>gr", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
-- vim.keymap.set("n", "<leader>gs", "<cmd>Telescope grep_string<CR>", { desc = "Grep String" })
-- vim.keymap.set("n", "<leader>ff", function()
--   require("telescope.builtin").find_files({ hidden = true })
-- end, { desc = "Find Files (hidden)" })

-- ============================================================
-- Hover info LSP
-- ============================================================
vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, { desc = "Hover" })
-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })