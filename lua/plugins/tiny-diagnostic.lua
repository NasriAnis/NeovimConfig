return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          multilines = false,
          break_line = {
            enabled = true,
            after = 60,
          },
          virt_texts = {
            priority = 2048,
          },
        },
        signs = {
          arrow = "",   -- simple arrow, no special glyph
        },
      })
    end,
  },
}
