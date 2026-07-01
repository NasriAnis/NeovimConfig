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

map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

-- Close all buffers except current
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all other buffers" })

-- Close all buffers
map("n", "<leader>bA", "<cmd>%bd<CR>", { desc = "Close all buffers" })

-- ============================================================
-- QUICKFIX / ERRORS
-- ============================================================

map("n", "]e", "<cmd>cnext<cr>", { desc = "Next error" })
map("n", "[e", "<cmd>cprev<cr>", { desc = "Prev error" })