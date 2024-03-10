-- This plugin add a couple extra mason commands.

local cmd = vim.api.nvim_create_user_command
local mason = require("masonextracmds.mason")

local M = {}

function M.setup()

  -- Creaete extra Mason commands
  cmd("MasonUpdateAll", function()
    mason.update_all()
  end, { desc = "Update Mason Packages" })

end

return M
