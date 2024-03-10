--- ### General utils

local M = {}

--- Serve a notification with a default title.
---@param msg string The notification body.
---@param type number|nil The type of the notification (:help vim.log.levels).
---@param opts? table The nvim-notify options to use (:help notify-options).
function M.notify(msg, type, opts)
  vim.schedule(function() vim.notify(
    msg, type, M.extend_tbl({ title = "Distroupdate.nvim" }, opts)) end)
end

return M
