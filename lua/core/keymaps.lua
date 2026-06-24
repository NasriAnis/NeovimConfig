local map = vim.keymap.set

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "File tree" })

-- move between splits
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })

-- move between buffer tabs
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer tab" })

-- build and jump to errors
map("n", "<leader>m", "<cmd>make<cr>", { desc = "Build" })
-- navigate quickfix errors
map("n", "<leader>cn", "<cmd>cnext<cr>", { desc = "Next error" })
map("n", "<leader>cp", "<cmd>cprev<cr>", { desc = "Prev error" })
map("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix" })

-- open terminal below code only, not affecting neo-tree
map("n", "<C-/>", function()
  -- move to the main code window first if neo-tree is open
  if vim.bo.filetype == "neo-tree" then
    vim.cmd("wincmd l")
  end
  vim.cmd("ToggleTerm")
end, { desc = "Toggle terminal" })