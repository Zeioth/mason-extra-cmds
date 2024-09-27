-- This plugin add a couple extra mason commands.

local M = {}

function M.setup()
  -- Create cmd `:MasonUpdateAll`
  vim.api.nvim_create_user_command("MasonUpdateAll", function()
    require("masonextracmds.mason").update_all()
  end, { desc = "Update Mason Packages" })
end

return M
