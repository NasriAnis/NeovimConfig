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
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
}