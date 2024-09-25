# MasonExtraCmds
This plugins adds the command `:MasonUpdateAll`.

## What it does
Same as mason update all, but without having to open mason. This is cool for autocmds and stuff.

## How to use
On lazy
```lua
{
  "williamboman/mason.nvim",
  dependencies = { "Zeioth/mason-extra-cmds", opts = {} },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
    "MasonUpdate",
    "MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
  },
},
```

## Tested versions
Mason `v1.x.x`
