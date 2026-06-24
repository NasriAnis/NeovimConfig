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
},
--
-- {
--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("kanagawa").setup({
--         theme = "dragon", -- or "wave" depending on which variant you chose
--         transparent = false,
--         overrides = function(colors)
--           return {
--             Normal = { bg = "#000000" },
--             NormalFloat = { bg = "#000000" },
--             SignColumn = { bg = "#000000" },
--             StatusLine = { bg = "#000000" },
--             NeoTreeNormal = { bg = "#000000" },       -- Keeps your file tree pure black
--             NeoTreeNormalNC = { bg = "#000000" },     -- Keeps inactive file tree pure black
--           }
--         end,
--       })
--       vim.cmd("colorscheme kanagawa")
--     end,
--   },
  -- {
  --   "WTFox/jellybeans.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "high_contrast", -- Turns background pure black natively
  --     transparent = false,
  --   },
  --   config = function(_, opts)
  --     require("jellybeans").setup(opts)
  --     vim.cmd("colorscheme jellybeans")
  --   end,
  -- }
}
