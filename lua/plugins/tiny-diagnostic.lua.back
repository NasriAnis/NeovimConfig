return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "simple",
        options = {
          show_source = true,
          multilines = false,
          break_line = {
            enabled = false,
            -- after = 60,
          },
          virt_texts = {
            priority = 2048,
          },
          -- ADD THIS:
          overflow = {
            mode = "wrap",   -- "wrap" | "none" | "oneline"
          },
        },
        signs = {
          arrow = "",
        },
      })
    end,
  },
}
