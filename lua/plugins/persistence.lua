return {
  "folke/persistence.nvim",
  lazy = false,
  config = function()
    local session_dir = vim.fn.stdpath("state") .. "/sessions/"

    require("persistence").setup({
      dir = session_dir,
      need = 0, 
      branch = false,
    })

    -- Stop persistence's automatic hidden background saving
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        pcall(vim.api.nvim_del_augroup_by_name, "Persistence")
      end,
    })

    -- Helper to check if the current project folder already has a saved session file
    local function session_exists_for_cwd()
      -- Converts /home/anis/Code/project -> %home%anis%Code%project.vim
      local expected_filename = vim.fn.getcwd():gsub("/", "%%") .. ".vim"
      return vim.fn.filereadable(session_dir .. expected_filename) == 1
    end

    -- Auto-load on startup ONLY if a session already exists
    if session_exists_for_cwd() then
      require("persistence").load()
    end

    -- ============================================================
    -- EXIT TRIGGER: Prompts only if the project is already a session
    -- ============================================================
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        -- Skip prompt completely if no session file exists on disk yet
        if not session_exists_for_cwd() or vim.bo.filetype == "alpha" or vim.bo.filetype == "nofile" then
          require("persistence").stop()
          return
        end

        local choice = vim.fn.confirm("Do you want to save this session before exiting?", "&Yes\n&No", 1)
        if choice == 1 then
          require("persistence").save()
          vim.api.nvim_echo({ { "Session saved!", "Identifier" } }, false, {})
        else
          require("persistence").stop()
        end
      end,
    })

    -- ============================================================
    -- USER COMMANDS
    -- ============================================================
    
    -- :Session — Loads your saved workspaces safely
    vim.api.nvim_create_user_command("Session", function()
      local success, files = pcall(vim.fn.readdir, session_dir)
      if not success or #files == 0 then
        vim.notify("No sessions found", vim.log.levels.WARN)
        return
      end

      local sessions = {}
      for _, file in ipairs(files) do
        local path = file:gsub("%%", "/"):gsub("%.vim$", "")
        table.insert(sessions, { label = path, file = session_dir .. file })
      end

      vim.ui.select(sessions, {
        prompt = "Select session to LOAD:",
        format_item = function(item) return item.label end,
      }, function(choice)
        if choice then
          vim.cmd("source " .. vim.fn.fnameescape(choice.file))
        end
      end)
    end, {})

    -- :SessionDelete — Clean up old, unwanted files safely
    vim.api.nvim_create_user_command("SessionDelete", function()
      local success, files = pcall(vim.fn.readdir, session_dir)
      if not success or #files == 0 then
        vim.notify("No sessions found to delete", vim.log.levels.WARN)
        return
      end

      local sessions = {}
      for _, file in ipairs(files) do
        local path = file:gsub("%%", "/"):gsub("%.vim$", "")
        table.insert(sessions, { label = path, file = session_dir .. file })
      end

      vim.ui.select(sessions, {
        prompt = "Select session to PURGE / DELETE permanently:",
        format_item = function(item) return item.label end,
      }, function(choice)
        if choice then
          vim.fn.delete(choice.file)
          vim.notify("Permanently deleted session context: " .. choice.label, vim.log.levels.INFO)
        end
      end)
    end, {})

    -- ============================================================
    -- KEYMAPS
    -- ============================================================
    
    -- Press <leader>qs to instantly start or update a session for this folder
    vim.keymap.set("n", "<leader>qs", function()
      require("persistence").save()
      vim.notify("Session saved manually!", vim.log.levels.INFO)
    end, { desc = "Save current session" })

    vim.keymap.set("n", "<leader>ql", function()
      require("persistence").load({ last = true })
    end, { desc = "Restore last session" })

    vim.keymap.set("n", "<leader>qd", function()
      require("persistence").stop()
    end, { desc = "Don't save session" })
  end,
}