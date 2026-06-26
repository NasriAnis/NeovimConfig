return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = "rust",
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = { auto_focus = true },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = false,
      
            diagnostics = {
              enable = false,
            },
      
            cargo = {
              allFeatures = true,
            },
      
            procMacro = {
              enable = true,
            },
      
            inlayHints = {
              enable = false,
            },
          },
        },
      },
      -- server = {
      --   settings = {
      --     ["rust-analyzer"] = {
      --       checkOnSave = true,
      --       check = {
      --         command = "clippy",
      --       },
      --       cargo = {
      --         allFeatures = true,
      --       },
      --       procMacro = {
      --         enable = true,
      --       },
      --       diagnostics = {
      --         enable = true,
      --         experimental = { enable = true },
      --       },
      --     },
      --   },
      -- },
    }
  end,
}