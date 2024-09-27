--- ### Mason utils
--
--  DESCRIPTION:
--  Functions used by the commands of this plugin.

--    Functions:
--      -> update_all   → update all mason packages without opening mason.

local notify = require("masonextracmds.utils").notify
local utils = require("masonextracmds.mason.utils")

local M = {}

--- Function to update all Mason packages.
--- @return boolean success Returns true if the function completed without errors.
function M.update_all()
  notify("Checking for package updates...")

  -- guard clause: if no mason registry, abort.
  local registry = utils.get_mason_registry()
  if not registry then return false end

  -- Update the registry of updates, and run this function as callback.
  registry.update(vim.schedule_wrap(function(success, updated_registries)
    -- guard clause: if failed, exit.
    if not success then
      notify(("Failed to get updates: %s"):format(updated_registries))
      return false
    end

    -- guard clause: if zero packages are installed, abort.
    local installed_pkgs = registry.get_installed_packages()
    if not utils.any_package_installed(installed_pkgs) then return false end

    -- registry is updated now. update installed packages.
    utils.update_packages(installed_pkgs, utils.notify_update_complete)
  end))

  return true
end

return M
