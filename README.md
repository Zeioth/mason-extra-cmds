# MasonExtraCmds
This plugins adds the command `:MasonUpdateAll`.

![screenshot_2024-09-28_18-08-09_002163534](https://github.com/user-attachments/assets/82221f3c-54f7-4dea-a79e-3c6a99a86054)

<div align="center">
  <a href="https://discord.gg/ymcMaSnq7d" rel="nofollow">
    <img src="https://img.shields.io/discord/1121138836525813760?color=azure&labelColor=6DC2A4&logo=discord&logoColor=black&label=Join%20the%20discord%20server&style=for-the-badge" alt="Discord">
  </a>
</div>

## What it does
It allows you to update all mason packages through a Neovim command, so you don't need to open mason. This is cool for key mappings, autocmds and stuff.

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

## Events
* **Can I run lazy automatically after `MasonUpdateAll`?** Yes.
```lua
--- EXAMPLE: Run lazy after `:MasonUpdateAll` finishes updating.
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonUpdateAllCompleted",
  callback = function()
    vim.cmd(":Lazy update")
  end,
})
```

* **Can I run `:MasonUpdateAll` automatically after a lazy update?** Yes.
```lua
--- EXAMPLE: Run mason after lazy finishes updating.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyInstall",
  callback = function()
    vim.cmd(":MasonUpdateAll")
  end,
})
```

Through the same mechanism you could also do `:TSUpdate` to update `treesitter`, for example.

## Tested versions
* Neovim: `0.11`/`0.12`
* Mason: `v2.x.x`
