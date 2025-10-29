# Keymaps Overview

This config uses Blink Completion for autocompletion. The accept key has been changed from `C-y` (Blink default) to `Tab` via the built‑in `super-tab` preset.

## Completion (Insert mode)
- `Tab`: accept current completion (Blink `super-tab` preset)
- `S-Tab`: snippet backward / fallback (Blink preset behavior)
- `C-Space`: open menu or docs if already open
- `C-n` / `C-p` or Up/Down: select next/previous item
- `C-e`: hide menu
- `C-k`: toggle signature help

Notes
- Normal/Visual mode Tab mappings for indentation remain unchanged (`<Tab>`/`<S-Tab>` in Normal/Visual still indent). Insert-mode Tab now accepts completion when the menu is active.

## References
- Official docs (Keymap presets): https://cmp.saghen.dev/configuration/keymap.html
- Community discussion (super-tab behavior): https://github.com/Saghen/blink.cmp/discussions/1139
- Pinned version: `blink.cmp` commit `afc4f4d260af11b248a79c5c8b4f82014f7330f4` (lazy-lock.json)

