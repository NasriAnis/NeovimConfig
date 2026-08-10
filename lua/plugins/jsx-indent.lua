return {
  -- Pure vim/lua plugin for JSX indentation without any external CLI
  "maxmellon/vim-jsx-pretty",
  ft = { "javascriptreact", "typescriptreact" },
  config = function()
    -- Enable JSX indenting rules
    vim.g.vim_jsx_pretty_enable_jsx_highlight = 0 -- Keep Treesitter for highlights
  end,
}