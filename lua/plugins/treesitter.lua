return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then return end

    configs.setup({
      ensure_installed = {
        "lua", "rust", "c", "python",
        "bash", "json", "toml", "yaml",
        "markdown", "vim", "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}