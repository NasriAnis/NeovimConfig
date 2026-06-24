return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    auto_enable = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border = "rounded",
      show_title = true,
    },
    func_map = {
      open = "<cr>",       -- open file at error
      openc = "o",         -- open and close quickfix
      tab = "t",           -- open in new tab
      vsplit = "v",        -- open in vertical split
      split = "s",         -- open in horizontal split
      previewnext = ">",   -- preview next error
      previewprev = "<",   -- preview prev error
    },
    filter = {
      fzf = {
        action_for = {
          ["ctrl-t"] = "tabedit",
          ["ctrl-v"] = "vsplit",
          ["ctrl-s"] = "split",
        },
      },
    },
  },
}