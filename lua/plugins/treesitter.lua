return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then return end

    configs.setup({
      ensure_installed = {
        -- Core & Config
        "lua", "vim", "vimdoc", "bash", "json", "toml", "yaml", "markdown", "markdown_inline",
        -- Low Level & General
        "c", "cpp", "rust", "python",
        -- Web / TSX
        "javascript", "typescript", "tsx", "html", "css",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}