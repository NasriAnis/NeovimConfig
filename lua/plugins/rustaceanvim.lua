return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = true, -- IMPORTANT: no `ft = {"rust"}` here, or it auto-loads/starts on opening a .rs file
    init = function()
      vim.g.rustaceanvim = {
        server = {
          capabilities = require("blink.cmp").get_lsp_capabilities(),
        },
      }
    end,
  },
}