return {
  "folke/persistence.nvim",
  lazy = false,
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    save_empty = false,
    -- exclude neo-tree and other special buffers from session
    exclude = {
      "neo-tree",
    },
  },
  config = function(_, opts)
    require("persistence").setup(opts)

    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      require("persistence").load()
    end
  end,
  keys = {
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save session" },
  },
}