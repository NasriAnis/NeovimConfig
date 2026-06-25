
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose" },
  keys = {
    {
      "<leader>do",
      "<cmd>DiffviewOpen<cr>",
      desc = "Diffview Open",
    },
    {
      "<leader>dc",
      "<cmd>DiffviewClose<cr>",
      desc = "Diffview Close",
    },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        winbar_info = true,
      },
    },
    hooks = {
      view_closed = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match("^diffview://") then
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
          end
        end
      end,
    },
  },
}