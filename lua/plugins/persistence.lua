return {
  "folke/persistence.nvim",
  lazy = false,
  config = function()
    require("persistence").setup({
      dir = vim.fn.stdpath("state") .. "/sessions/",
      save_empty = false,
    })

    -- auto restore only if opened in a directory with no args
    if vim.fn.argc() == 0 then
      require("persistence").load()
    end

    -- session picker with readable names
    vim.keymap.set("n", "<leader>qS", function()
      local dir = vim.fn.stdpath("state") .. "/sessions/"
      local files = vim.fn.readdir(dir)

      local sessions = {}
      for _, file in ipairs(files) do
        local path = file:gsub("%%2F", "/"):gsub("%.vim$", "")
        table.insert(sessions, { label = path, file = dir .. file })
      end

      vim.ui.select(sessions, {
        prompt = "Select session:",
        format_item = function(item) return item.label end,
      }, function(choice)
        if choice then
          vim.cmd("source " .. vim.fn.fnameescape(choice.file))
        end
      end)
    end, { desc = "Pick session" })

    vim.keymap.set("n", "<leader>ql", function()
      require("persistence").load({ last = true })
    end, { desc = "Restore last session" })

    vim.keymap.set("n", "<leader>qd", function()
      require("persistence").stop()
    end, { desc = "Don't save session" })
  end,
}