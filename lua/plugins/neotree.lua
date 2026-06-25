return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {
    close_if_last_window = false,
    hijack_netrw_behavior = "open_current",
    -- This keeps the tree state synchronized across different Neovim tabpages
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      position = "left",
      width = 30,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      -- Automatically open directories and focus on the active file
      follow_current_file = {
        enabled = true,          -- This is what you have now
        leave_dirs_open = true,  -- Keeps other directories open when focusing the new file
      },
      use_libuv_file_watcher = true, -- Automatically refreshes the tree if files change on disk
    },
  },
}