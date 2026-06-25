local map = vim.keymap.set

-- ============================================================
-- TERMINAL
-- ============================================================

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-/>", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd("wincmd l")
  end
  vim.cmd("ToggleTerm")
end, { desc = "Toggle terminal" })

-- ============================================================
-- FILE TREE
-- ============================================================

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })

-- ============================================================
-- SPLITS
-- ============================================================

map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })

-- ============================================================
-- BUFFERS
-- ============================================================

-- Cycle through buffer tabs
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- Close current buffer (switches to prev, keeps layout intact)
map("n", "<leader>bd", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 1 then
    vim.cmd("bprevious")
    vim.cmd("bdelete #")
  else
    vim.cmd("enew")
    vim.cmd("bdelete #")
  end
end, { desc = "Close current buffer" })

-- Close all buffers except current
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })

-- Close all buffers
map("n", "<leader>bA", "<cmd>%bd<CR>", { desc = "Close all buffers" })

-- ============================================================
-- QUICKFIX / ERRORS
-- ============================================================

map("n", "]e", "<cmd>cnext<cr>", { desc = "Next error" })
map("n", "[e", "<cmd>cprev<cr>", { desc = "Prev error" })