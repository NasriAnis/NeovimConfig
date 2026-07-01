return {
  "rmagatti/auto-session",
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Required for searching sessions
  },
  config = function()
    require("auto-session").setup({
      auto_restore_enabled = true,
      
      -- Disable global auto-save so it doesn't clutter your session folder
      -- with every random directory you visit in the terminal.
      auto_save_enabled = false, 
      
      -- This replaces your previous VimLeavePre autocmd for the file tree
      pre_save_cmds = { "NvimTreeClose" },
      
      -- Enable Telescope integration for searching
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })

    -- 1. "Flag" it: Manually save the session for the first time
    vim.keymap.set("n", "<leader>qs", "<cmd>SessionSave<CR>", { desc = "Save/Flag Session" })

    -- 2. Search sessions: Opens a Telescope picker to jump between projects
    vim.keymap.set("n", "<leader>sf", "<cmd>AutoSession search<CR>", { desc = "Search Sessions" })

    -- 3. Smart Auto-Update: Only update on quit IF the folder is already a session
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        -- auto-session uses the full path, replacing slashes with %
        local session_dir = vim.fn.stdpath("data") .. "/sessions/"
        local cwd = vim.fn.getcwd()
        local file_name = cwd:gsub("/", "%%") .. ".vim"
        local session_file = session_dir .. file_name

        -- If you previously flagged it with <leader>qs, the file exists
        if vim.fn.filereadable(session_file) == 1 then
          vim.cmd("SessionSave")
        end
      end,
    })
  end,
}