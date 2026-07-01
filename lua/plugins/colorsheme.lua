return{ 
  {
  "Mofiqul/dracula.nvim",
  priority = 1000,
  config = function()
    require("dracula").setup({
      colors = {
        bg = "#000000",        -- pure black background
        menu = "#0d0d0d",      -- slightly lighter for menus
        black = "#000000",
        visual = "#2b2b2b",    -- selection color
        comment = "#6272A4",
        fg = "#F8F8F2",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
      },
      show_end_of_buffer = false,
      transparent_bg = false,
      italic_comment = true,
      lualine_bg_color = "#0d0d0d",
    })

    vim.cmd.colorscheme("dracula")
  end,
  }
}
