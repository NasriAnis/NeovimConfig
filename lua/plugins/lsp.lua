-- return {
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup()
--     end,
--   },
--   {
--     "williamboman/mason-lspconfig.nvim",
--     dependencies = { "neovim/nvim-lspconfig" },
--     config = function()
--       require("mason-lspconfig").setup({
--         automatic_enable = false,
--       })

--       vim.api.nvim_create_user_command("LspEnable", function()
--         vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
--         vim.cmd("edit")
--       end, {})

--       vim.api.nvim_create_user_command("LspDisable", function()
--         for _, c in ipairs(vim.lsp.get_clients()) do
--           c:stop(true)
--         end
--         vim.lsp.enable(require("mason-lspconfig").get_installed_servers(), false)
--       end, {})
--     end,
--   },
-- }

-- return {
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup()
--     end,
--   },
--   {
--     "williamboman/mason-lspconfig.nvim",
--     dependencies = { "neovim/nvim-lspconfig" },
--     config = function()
--       -- Merge blink.cmp's capabilities into every LSP server config
--       vim.lsp.config('*', {
--         capabilities = require("blink.cmp").get_lsp_capabilities(),
--       })

--       require("mason-lspconfig").setup({
--         automatic_enable = false,
--       })

--       vim.api.nvim_create_user_command("LspEnable", function()
--         vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
--         vim.cmd("edit")
--       end, {})

--       vim.api.nvim_create_user_command("LspDisable", function()
--         for _, c in ipairs(vim.lsp.get_clients()) do
--           c:stop(true)
--         end
--         vim.lsp.enable(require("mason-lspconfig").get_installed_servers(), false)
--       end, {})
--     end,
--   },
-- }

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- Merge blink.cmp's capabilities into every LSP server config
      vim.lsp.config('*', {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      require("mason-lspconfig").setup({
        automatic_enable = false,
      })

      -- Enable LSP (for current filetype's installed servers) + completions
      vim.api.nvim_create_user_command("LspEnable", function()
        local ft = vim.bo.filetype
      
        if ft == "rust" then
          require("lazy").load({ plugins = { "rustaceanvim" } })
        else
          vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
        end
      
        vim.g.blink_cmp_enabled = true
        vim.cmd("edit")
        print("LSP + completions enabled")
      end, {})

      -- Disable everything: stop all LSP clients + turn off completions
      vim.api.nvim_create_user_command("LspDisable", function()
        for _, c in ipairs(vim.lsp.get_clients()) do
          c:stop(true)
        end
        vim.lsp.enable(require("mason-lspconfig").get_installed_servers(), false)
        vim.g.blink_cmp_enabled = false
        print("LSP + completions disabled")
      end, {})
    end,
  },
}