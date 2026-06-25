return {
  {
    "NeogitOrg/neogit",
    integrations = {
      diffview = true,
    },
    lazy = true,
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },
  {
    "sindrets/diffview.nvim",
  dependencies = { 
    "nvim-lua/plenary.nvim",
},
}
}
