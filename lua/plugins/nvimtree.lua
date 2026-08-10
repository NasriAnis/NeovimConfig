-- plugins/nvimtree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
      hijack_netrw = true,
      update_focused_file = {
          enable = true,
          update_root = false,   -- set true if you also want the tree's root to jump to the file's project root
          ignore_list = {},
      },
    -- hijack_netrw = true,
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      group_empty = true,       -- collapse empty folders
      highlight_git = true,
      icons = {
        show = {
          git = true,
          file = true,
          folder = true,
        },
      },
    },
    filters = {
      dotfiles = false,         -- show dotfiles
      git_ignored = false,      -- show .gitignored files
    },
    git = {
      enable = true,
    },
    diagnostics = {
      enable = true,            -- show LSP diagnostic icons
    },
    actions = {
      open_file = {
        quit_on_open = false,   -- keep tree open when opening a file
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- same keymap you probably had for neo-tree
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
    vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<cr>",  { desc = "Focus file tree" })
  end,
}