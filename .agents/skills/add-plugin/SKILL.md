---
name: add-plugin
description: >-
  Use this skill when adding, enabling, or configuring a new Neovim plugin in this configuration repository.
---

# Adding a Neovim Plugin

Follow this procedure to add and properly enable a new plugin in this Neovim configuration.

## Workflow Overview

1. **Create the plugin spec file** in `lua/plugins/<plugin-name>.lua`.
2. **Register the plugin in config tables** (`lua/config/config_default.lua` and host-specific configs).
3. **Verify the configuration** to ensure it loads without errors or missing config warnings.

---

## Step 1: Create the Plugin Specification

Create a file in `lua/plugins/<plugin-name>.lua` returning a valid `lazy.nvim` plugin specification table (or array of tables).

### Guidelines
- **Lazy loading**: Use `event`, `cmd`, `ft`, or `keys` to defer loading when appropriate.
- **Keymaps**: Define plugin-specific keybindings inside the `keys` table or within `config`.
- **Dependencies**: Declare dependencies in the `dependencies` list.
- **Code style**: Format with `stylua` (2 spaces indentation, single quotes).

### Example (`lua/plugins/example.lua`)
```lua
return {
  'author/example.nvim',
  event = 'VeryLazy',
  opts = {
    -- plugin options
  },
  keys = {
    { '<leader>ex', '<cmd>ExampleCommand<cr>', desc = 'Run Example' },
  },
}
```

---

## Step 2: Register & Enable in Configuration

This configuration uses `lua/config/config_loader.lua` with `lazy.nvim`'s `defaults.cond` to conditionally enable plugins per environment. If a plugin is omitted from the config, `config_loader` will raise a `[config_loader] Missing <name>` warning.

The plugin name key must match the repository name in lazy.nvim (e.g., `example.nvim`, `vim-fugitive`).

1. **Add to default config** (`lua/config/config_default.lua`):
   ```lua
   config['example.nvim'] = true
   ```

2. **Add to host-specific configs** (e.g., `lua/config/config_waraclesam.lua` or any `lua/config/config_<hostname>.lua`):
   ```lua
   config['example.nvim'] = true
   ```

---

## Step 3: Verify Plugin Loading

Verify that Neovim parses the new configuration cleanly:

```sh
nvim --headless "+Lazy! sync" +qa
```

Ensure no syntax errors or `[config_loader] Missing ...` warnings are emitted.
