return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = vim.keymap.set
          local buf = event.buf

          map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
          map("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Go to declaration" })
          map("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "References" })
          map("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover docs" })
          map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
          map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
          map("n", "<leader>d", vim.diagnostic.open_float, { buffer = buf, desc = "Line diagnostics" })
          map("n", "[d", vim.diagnostic.goto_prev, { buffer = buf, desc = "Prev diagnostic" })
          map("n", "]d", vim.diagnostic.goto_next, { buffer = buf, desc = "Next diagnostic" })
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("clangd", {
        cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm",
  },
})
      vim.lsp.config("pyright", {})

      vim.lsp.enable({ "lua_ls", "clangd", "pyright" })
    end,
  },
}
