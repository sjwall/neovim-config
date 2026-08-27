# AGENTS.md

## Overview
This repository contains a modular Neovim configuration built with Lua and managed using [lazy.nvim](https://github.com/folke/lazy.nvim).

## Project Structure
- `init.lua` - Main entry point; loads the core `config` module.
- `lua/config/` - Core configuration files:
  - `lazy.lua` - lazy.nvim bootstrap and setup.
  - `settings.lua` - Global Neovim options (`vim.opt`).
  - `remap.lua` - Global keymaps (`vim.keymap.set`).
  - `config_loader.lua` - Environment/host-specific configuration loader.
  - `init.lua` - Core autocommands and module initialization.
- `lua/plugins/` - Individual plugin specifications automatically imported by lazy.nvim.
- `lua/utils/` - Shared helper utilities.

## Guidelines for AI Agents

### Keymaps and Settings
- Add global keybindings to `lua/config/remap.lua`.
- Declare plugin-specific keymaps within the plugin's `keys` table in `lua/plugins/` or inside its `config` function.
- Add general Neovim options to `lua/config/settings.lua`.
