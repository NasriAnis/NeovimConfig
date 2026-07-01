-- plugins/fzf.lua
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "down:45%",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>ff", fzf.files,       { desc = "Find files" })
    map("n", "<leader>fg", fzf.live_grep,   { desc = "Live grep" })
    map("n", "<leader>fw", fzf.grep_cword,  { desc = "Grep word under cursor" })
    map("n", "<leader>fb", fzf.buffers,     { desc = "Buffers" })
    map("n", "<leader>fr", fzf.oldfiles,    { desc = "Recent files" })
    map("n", "<leader>fh", fzf.help_tags,   { desc = "Help tags" })
  end,
}
