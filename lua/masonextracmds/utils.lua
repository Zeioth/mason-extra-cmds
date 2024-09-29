--- ### General utils
--
--  DESCRIPTION:
--  General functions used across this plugin.

--    Functions:
--      -> notify                   → Send a notification with a default title.
--      -> trigger_event            → Manually trigger an event.

local M = {}

--- Serve a notification with a default title.
--- @param msg string The notification body.
--- @param type number|nil The type of the notification (:help vim.log.levels).
--- @param opts? table The nvim-notify options to use (:help notify-options).
function M.notify(msg, type, opts)
  opts = opts or {}
  local default_opts = { title = "mason.nvim" }
  local combined_opts = vim.tbl_deep_extend("force", default_opts, opts)

  vim.schedule(function() vim.notify(msg, type, combined_opts) end)
end

--- Convenient wapper to save code when we Trigger events.
--- @param event string Name of the event.
--  @usage To run a User event:   `trigger_event("User MyUserEvent")`
--  @usage To run a Neovim event: `trigger_event("BufEnter")`
function M.trigger_event(event)
  -- detect if event start with the substring "User "
  local is_user_event = string.match(event, "^User ") ~= nil

  vim.schedule(function()
    if is_user_event then
      -- Substract the substring "User " from the beginning of the event.
      event = event:gsub("^User ", "")
      vim.api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end)
end

return M
