return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {},
      bufdelete = {},
      dashboard = {
        formats = {
          key = function(item)
            return { { "[", hl = "function" }, { item.key, hl = "key" }, { "]", hl = "function" } }
          end,
          header = { "%s", align = "center", hl = "MiniIconsBlue" },
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return Snacks.dashboard.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "MiniIconsPurple" }
          end,
        },
        preset = {
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "find file",
              action = ":lua Snacks.dashboard.pick('files', { hidden = true })",
            },
            {
              icon = " ",
              key = "w",
              desc = "find text",
              action = ":lua Snacks.dashboard.pick('live_grep', { hidden = true })",
            },
            { icon = " ", key = "e", desc = "explorer", action = ":lua require('oil').toggle_float()" },
            { icon = "󰒲 ", key = "l", desc = "lazy", action = ":Lazy" },
            { icon = "󰭿 ", key = "q", desc = "quit", action = ":qa" },
          },
          header = require("utils.ascii").snufkin,
        },
        sections = {
          {
            section = "terminal",
            cmd = "chafa ~/.config/clouds.jpg --format symbols --symbols vhalf --size 60x15 --stretch; sleep .1",
            height = 17,
            padding = 1,
          },
          {
            pane = 2,
            { title = "shortcuts", hl = ""},
            { section = "keys", padding = 1 },
            { title = "mru ", file = vim.fn.fnamemodify(".", ":~")},
            { section = "recent_files", cwd = true, limit = 5, padding = 1 },
            { section = "startup", icon = " " },
          },
        },
      },
      git = {},
      indent = {
        indent = {
          enabled = false,
        },
        animate = {
          enabled = false,
        },
        scope = {
          treesitter = {
            enabled = true,
          },
        },
      },
      image = {
        doc = {
          inline = false,
          max_height = 12,
          max_width = 24,
        },
      },
      notifier = {
        timeout = 3000,
      },
      statuscolumn = {},
      rename = {},
      terminal = {},
      picker = {
        ui_select = false,
        layout = {
          preset = "minimal",
        },
        layouts = {
          minimal = {
            preview = false,
            layout = {
              backdrop = false,
              height = 0.25,
              width = 0.4,
              box = "horizontal",
              {
                border = "single",
                box = "vertical",
                title = "{title}",
                title_pos = "left",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", title_pos = "left", border = "single" },
            },
          },
        },
        sources = {
          grep = {
            layout = {
              preview = true,
            },
          },
          icons = {
            layout = {
              preset = "minimal",
            },
          },
        },
      },
      styles = {
        notification = {
          border = "single",
          wo = { wrap = true, winblend = 0 }, -- Wrap notifications
        },
        ["notification.history"] = {
          border = "single",
        },
        snacks_image = {
          relative = "editor",
          border = "single",
          focusable = false,
          backdrop = false,
          row = 1,
          col = -1,
        },
        lazygit = {
          border = "single",
        },
        blame_line = {
          border = "single",
          title = "git blame",
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "delete buffer" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "blame line" },
      { "<leader>cR", function() Snacks.rename() end, desc = "rename file" },
      { "<leader>fn", function() Snacks.notifier.show_history() end, desc = "notification history" },
      { "<leader><leader>", function() Snacks.terminal() end, desc = "terminal" },
      { "<leader>fs", function() Snacks.picker.smart() end, desc = "smart files" },
      { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "find files" },
      { "<leader>fw", function() Snacks.picker.grep({ hidden = true }) end, desc = "live grep" },
      { "<leader>fw", function() Snacks.picker.grep_word() end, mode = "x", desc = "grep selection" },
      { "<leader>fi", function() Snacks.picker.icons() end, desc = "icons" },
      { "<leader>ti", function() Snacks.image.hover() end, desc = "image hover" },
      -- stylua: ignore end
    },

    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>ts"
          Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>tw"
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map "<leader>tC"
          Snacks.toggle.inlay_hints():map "<leader>th"
          Snacks.toggle.indent():map "<leader>tg"
          Snacks.toggle.dim():map "<leader>tD"
        end,
      })
    end,
  },
}
