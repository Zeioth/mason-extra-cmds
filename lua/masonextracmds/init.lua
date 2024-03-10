-- This plugin add a couple extra mason commands.

local cmd = vim.api.nvim_create_user_command
local mason = require("masonextracmds.mason")

local M = {}

function M.setup()

  -- Creaete extra Mason commands
  cmd("MasonUpdate", function(options)
    mason.update(options.fargs)
  end, {
    nargs = "*",
    desc = "Update Mason Package",
    complete = function(arg_lead)
      local _ = require "mason-core.functional"
      return _.sort_by(
        _.identity,
        _.filter(_.starts_with(arg_lead), require("mason-registry").get_installed_package_names())
      )
    end,
  })

  cmd("MasonUpdateAll", function()
    mason.update_all()
  end, { desc = "Update Mason Packages" })

end

return M
