# MasonExtraCmds
This plugins adds the command `:MasonUpdateAll`.

## What it does
The same as opening mason and update packages.

## Why
Because if you can update in one step, why using two.

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
