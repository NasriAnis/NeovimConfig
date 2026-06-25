return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup", 
    },
    popupmenu = {
      enabled = true, 
    },
    -- Add this views section to change the layout position
    views = {
      cmdline_popup = {
        position = {
          row = "10%", -- Default is usually 50% (centered vertically). 30% pushes it higher up.
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "18%", -- Adjust this so your autocomplete suggestions drop down neatly beneath the higher box
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  },
}