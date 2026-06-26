return {
  { "wsdjeg/vim-fetch" },
  {
    "stevearc/overseer.nvim",
    config = function()
      local overseer = require("overseer")

      overseer.setup({
        task_list = {
          direction      = "bottom",
          min_height     = 15,
          max_height     = 15,
          default_detail = 2,
        },
        -- vim.api.nvim_create_autocmd("FileType", {
        --   pattern = { "overseer", "OverseerOutput" },
        --   callback = function()
        --     vim.keymap.set("n", "gf", function()
        --       local line = vim.api.nvim_get_current_line()
        --       line = line:gsub("\27%[[%d;]*m", "")
        --       local path = line:match("([%w%.%-%_/]+%.%w+:%d+[:%d]*)")
        --       if not path then return end
        
        --       -- wincmd p = jump to previous (code) window, then let vim-fetch open it
        --       vim.cmd("wincmd p")
        --       vim.cmd("wincmd k")
        --       vim.cmd("edit " .. vim.fn.fnameescape(path))
        --     end, { buffer = true, silent = true })
        --   end,
        -- })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "overseer", "OverseerOutput" },
          callback = function()
            vim.keymap.set("n", "gf", function()
              local line = vim.api.nvim_get_current_line()
              line = line:gsub("\27%[[%d;]*m", "")
              local path, lnum, col = line:match("([%w%.%-%_/]+%.%w+):(%d+):?(%d*)")
              if not path then return end
        
              lnum = tonumber(lnum) or 1
              col  = tonumber(col)  or 1
        
              -- find the first window that is neither overseer nor neotree
              local ignored = { overseer = true, OverseerOutput = true, ["neo-tree"] = true }
              for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                if not ignored[ft] then
                  vim.api.nvim_set_current_win(win)
                  break
                end
              end
        
              vim.cmd("edit " .. vim.fn.fnameescape(path))
              vim.schedule(function()
                vim.api.nvim_win_set_cursor(0, { lnum, math.max(0, col - 1) })
                vim.cmd("normal! zz")
              end)
            end, { buffer = true, silent = true })
          end,
        })
      })

      local function make_task(cmd, args, env)
        return {
          cmd        = cmd,
          args       = args or {},
          env        = env or {},
          components = { "default", "on_output_summarize" },
        }
      end

      overseer.register_template({
        name    = "cargo build",
        builder = function()
          return make_task({ "cargo" }, { "build" }, { CARGO_TERM_COLOR = "always" })
        end,
        condition = { callback = function(s)
          return vim.fn.filereadable(s.dir .. "/Cargo.toml") == 1
        end },
      })

      overseer.register_template({
        name    = "cargo check",
        builder = function()
          return make_task({ "cargo" }, { "check" }, { CARGO_TERM_COLOR = "always" })
        end,
        condition = { callback = function(s)
          return vim.fn.filereadable(s.dir .. "/Cargo.toml") == 1
        end },
      })

      overseer.register_template({
        name    = "make",
        builder = function()
          return make_task({ "make" })
        end,
        condition = { callback = function(s)
          return vim.fn.filereadable(s.dir .. "/Makefile") == 1
            or vim.fn.filereadable(s.dir .. "/makefile") == 1
        end },
      })

      overseer.register_template({
        name    = "go build",
        builder = function()
          return make_task({ "go" }, { "build", "./..." })
        end,
        condition = { callback = function(s)
          return vim.fn.filereadable(s.dir .. "/go.mod") == 1
        end },
      })

      local function run(template_name)
        overseer.run_template({ name = template_name }, function(task)
          if task then vim.cmd("OverseerOpen") end
        end)
      end

      local function smart_build()
        local cwd = vim.fn.getcwd()
        local runners = {
          { file = "Cargo.toml", template = "cargo build" },
          { file = "Makefile",   template = "make"        },
          { file = "makefile",   template = "make"        },
          { file = "go.mod",     template = "go build"    },
        }
        for _, r in ipairs(runners) do
          if vim.fn.filereadable(cwd .. "/" .. r.file) == 1 then
            run(r.template)
            return
          end
        end
        overseer.run_template()
      end

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
      end

      map("<leader>bb", smart_build, "Build (auto-detect)")
      map("<leader>bC", function() run("cargo check") end, "Cargo check")
      map("<leader>bR", function()
        local tasks = overseer.list_tasks({ recent_first = true })
        if tasks[1] then
          overseer.run_action(tasks[1], "restart")
          vim.cmd("OverseerOpen")
        else
          smart_build()
        end
      end, "Re-run last task")
      map("<leader>bt", "<cmd>OverseerToggle<cr>", "Toggle output panel")
    end,
  },
}