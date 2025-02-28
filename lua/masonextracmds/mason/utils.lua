-- Mason utils
--
--  DESCRIPTION:
--  Utils used by the functions.

--    Helpers:
--      -> install_update         → install a package and call a callback.
--
--    Functions:
--      -> get_mason_registry     → return the mason registry.
--      -> any_package_installed  → return false if no mason packages installed.
--      -> update_packages        → update every individual mason package.
--      -> notify_update_complete → callback to call when update_packages complete.

local utils = require("masonextracmds.utils")

local M = {}

-- HELPERS
-- ----------------------------------------------------------------------------

--- Handles the installation of a package and calls the completion callback when done.
--- @param pkg string Package to be installed.
--- @param on_complete function Callback function to execute on installation complete.
local function install_update(pkg, on_complete)
  pkg:install():on("closed", on_complete)
end

-- FUNCTIONS
-- ----------------------------------------------------------------------------

--- Require the mason registry.
--- @return MasonRegistry|nil
function M.get_mason_registry()
  local registry_avail, registry = pcall(require, "mason-registry")
  if not registry_avail then
    vim.api.nvim_err_writeln("Unable to access mason registry")
    return nil
  end
  return registry
end

--- Checks if there are installed packages and notifies the user if none are found.
--- @param installed_pkgs table A table of installed packages.
--- @return boolean Indicates if any packages are installed.
function M.any_package_installed(installed_pkgs)
  if #installed_pkgs == 0 then
    utils.notify("No updates available")
    utils.trigger_event("User MasonUpdateAllCompleted")
    return false
  end
  return true
end

--- Checks for updates on installed packages and notifies the user about the update status.
--- @param installed_pkgs table A table of installed packages.
--- @param callback function The callback function to execute once all updates have been checked.
function M.update_packages(installed_pkgs, callback)
  local remaining = #installed_pkgs -- Count of remaining packages to check for updates.
  local updates_found = false -- Flag to indicate if any updates were found.

  for _, pkg in ipairs(installed_pkgs) do
    pkg:check_new_version(function(update_available, version)
      if update_available then
        updates_found = true
        utils.notify(
          ("Updating %s to %s"):format(pkg.name, version.latest_version)
        )

        -- install update and update remaining count.
        install_update(pkg, function()
          remaining = remaining - 1
          if remaining == 0 then callback(updates_found) end
        end)
      else -- skip
        remaining = remaining - 1
        if remaining == 0 then callback(updates_found) end
      end
    end)
  end
end

--- Notifies the user and triggers the completion event based on update status.
--- @param updates_found boolean Indicates if any updates were found.
function M.notify_update_complete(updates_found)
  vim.defer_fn(function()
    if updates_found then
      utils.notify("Update Complete")
    else
      utils.notify("No updates available")
    end
    utils.trigger_event("User MasonUpdateAllCompleted")
  end, 1000) -- Ensure the callback is not executed ahead of time.
end

return M
