--- ### Mason utils
--
--  DESCRIPTION:
--  Non critical functions used by the updater to have better Mason integration.

--    Functions:
--      -> update_all   → update all lazy, mason, and treesitter packages.

local M = {}
local utils = require("masonextracmds.utils")

--- This function works the same as the Mason command `:MasonUpdateAll`,
--- but with better notifications and support for Mason registries.
function M.update_all()
  local registry_avail, registry = pcall(require, "mason-registry")
  if not registry_avail then
    vim.api.nvim_err_writeln "Unable to access mason registry"
    return
  end

  utils.notify("Checking for package updates...")
  registry.update(vim.schedule_wrap(function(success, updated_registries)
    if success then
      local installed_pkgs = registry.get_installed_packages()
      local running = #installed_pkgs
      local no_pkgs = running == 0

      if no_pkgs then
        utils.notify("No updates available")
        utils.trigger_event("User MasonUpdateCompleted")
      else
        local updated = false
        for _, pkg in ipairs(installed_pkgs) do
          pkg:check_new_version(function(update_available, version)
            if update_available then
              updated = true
              utils.notify(
                ("Updating %s to %s"):format(
                  pkg.name,
                  version.latest_version
                )
              )
              pkg:install():on("closed", function()
                running = running - 1
                if running == 0 then
                  utils.notify "Update Complete"
                  utils.trigger_event("User MasonUpdateCompleted")
                end
              end)
            else
              running = running - 1
              if running == 0 then
                if updated then
                  utils.notify("Update Complete")
                else
                  utils.notify("No updates available")
                end
                utils.trigger_event("User MasonUpdateCompleted")
              end
            end
          end)
        end
      end
    else
      utils.notify(
        ("Failed to update registries: %s"):format(updated_registries),
        vim.log.levels.ERROR
      )
    end
  end))
end

return M

