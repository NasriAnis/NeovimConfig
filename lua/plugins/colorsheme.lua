-- return{ 
--   {
--   "Mofiqul/dracula.nvim",
--   priority = 1000,
--   config = function()
--     require("dracula").setup({
--       colors = {
--         bg = "#000000",        -- pure black background
--         menu = "#0d0d0d",      -- slightly lighter for menus
--         black = "#000000",
--         visual = "#2b2b2b",    -- selection color
--         comment = "#6272A4",
--         fg = "#F8F8F2",
--         red = "#FF5555",
--         orange = "#FFB86C",
--         yellow = "#F1FA8C",
--         green = "#50fa7b",
--         purple = "#BD93F9",
--         cyan = "#8BE9FD",
--         pink = "#FF79C6",
--       },
--       show_end_of_buffer = false,
--       transparent_bg = false,
--       italic_comment = true,
--       lualine_bg_color = "#0d0d0d",
--     })

--     vim.cmd.colorscheme("dracula")
--   end,
--   }
-- }

-- return {
--   {
--     "Mofiqul/dracula.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("dracula").setup({
--         colors = {
--           bg = "#000000",
--           menu = "#0d0d0d",
--           black = "#000000",
--           visual = "#2b2b2b",
--           comment = "#6272A4",
--           fg = "#F8F8F2",
--           red = "#FF5555",
--           orange = "#FFB86C",
--           yellow = "#F1FA8C",
--           green = "#50fa7b",
--           purple = "#BD93F9",
--           cyan = "#8BE9FD",
--           pink = "#FF79C6",
--         },
--         show_end_of_buffer = false,
--         transparent_bg = false,
--         italic_comment = true,
--         lualine_bg_color = "#0d0d0d",
--       })

--       -- Default theme on startup
--       vim.cmd.colorscheme("dracula")
--     end,
--   },
--   {
--     "projekt0n/github-nvim-theme",
--     lazy = false,
--     priority = 999,
--     config = function()
--       require("github-theme").setup({})
--     end,
--   },
-- }


local theme_file = vim.fn.stdpath("data") .. "/last_colorscheme.txt"

local function save_theme(name)
  local file = io.open(theme_file, "w")
  if file then
    file:write(name)
    file:close()
  end
end

local function load_theme()
  local file = io.open(theme_file, "r")
  if file then
    local name = file:read("*l")
    file:close()
    return name
  end
  return nil
end

return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        colors = {
          bg = "#000000",
          menu = "#0d0d0d",
          black = "#000000",
          visual = "#2b2b2b",
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
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 999,
    config = function()
      require("github-theme").setup({})

      -- Apply saved theme, or fall back to dracula
      local saved = load_theme()
      vim.cmd.colorscheme(saved or "dracula")

      -- Whenever :colorscheme is run (by you, manually), save the new choice
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function(ev)
          save_theme(ev.match)
        end,
      })
    end,
  },
}