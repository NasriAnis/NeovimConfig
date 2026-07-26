-- vim.g.blink_cmp_enabled = false

-- return {
--   {
--     "saghen/blink.lib",
--   },
--   {
--     "saghen/blink.cmp",
--     dependencies = { "saghen/blink.lib" },
--     build = function()
--       require("blink.cmp").build():pwait()
--     end,
--     opts = {
--       enabled = function()
--         return vim.g.blink_cmp_enabled ~= false
--       end,
--       keymap = {
--         preset = "default",
--       },
--       completion = {
--         ghost_text = {
--           enabled = false,
--         },
--       },
--     },
--   },
-- }

vim.g.blink_cmp_enabled = false

return {
  {
    "saghen/blink.lib",
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib" },
    build = function()
      require("blink.cmp").build():pwait()
    end,
    opts = {
      enabled = function()
        return vim.g.blink_cmp_enabled ~= false
      end,
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}