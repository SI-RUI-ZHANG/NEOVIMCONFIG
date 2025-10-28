# Repository Guidelines

## Project Structure & Module Organization
- Root entry: `init.lua` loads core config.
- Core modules: `lua/config/` (`lazy.lua`, `options.lua`, `keymaps.lua`).
- Plugins: one spec per file under `lua/plugins/` (kebab-case), each returns a table for lazy.nvim.
- Lockfile: `lazy-lock.json` pins plugin versions.

## Build, Test, and Development Commands
- Run Neovim: `nvim` (requires Neovim 0.11+).
- Manage plugins: `:Lazy sync`, `:Lazy check`, `:Lazy clean`, `:Lazy build`.
- Treesitter: `:TSUpdate` to update parsers.
- Tooling & LSP: `:Mason` to install servers, `:LspInfo` to inspect.
- Health checks: `:checkhealth` (look for red/yellow items).
- Formatting: `<leader>lf` (buffer/selection), `<leader>lF` (force whole file), `:ConformInfo`.

## Coding Style & Naming Conventions
- Language: Lua, 2-space indent, no tabs; keep lines reasonably short.
- Modules: return configuration tables; avoid side effects in `lua/plugins/*.lua` beyond plugin specs.
- Naming: plugins in `lua/plugins/` use kebab-case (e.g., `neo-tree.lua`), config modules are lowercase snake (e.g., `options.lua`).
- Keep changes minimal and focused; prefer small, composable modules.

## Testing Guidelines
- Manual verification: open representative files (Lua, Python, JS, Markdown) and confirm Treesitter highlight, LSP (`gd`, `gr`, `K`), and formatting keys work.
- Run `:checkhealth`, `:LspInfo`, and `:ConformInfo` after changes.
- If plugins add builds (e.g., blink.cmp), ensure required toolchains are present and `:Lazy build` succeeds.

## Commit & Pull Request Guidelines
- Messages: short, imperative, present tense (e.g., "add treesitter config", "fix lsp rename").
- Scope changes per commit; include brief rationale in body if needed.
- PRs: clear description, screenshots for UI-affecting changes (themes/trees), steps to validate (commands used), and any breaking notes.

## Security & Configuration Tips
- Requirements: Neovim 0.11+, Git, and language toolchains via Mason. For blink.cmp, install Rust nightly (`rustup toolchain install nightly`).
- Avoid committing secrets. Do not hardcode absolute local paths.

## Documentation-First Changes (Required)
- Do not ship changes based on guesswork. Back every behavior change with sources.
- Source-of-truth order:
  1) Official docs and plugin code (APIs, action names, documented key tables).
  2) Maintainer posts/issues/discussions (GitHub Discussions/Issues in the plugin repo).
  3) Community notes with code samples (blogs, gists, reputable configs). Include dates/versions if relevant.
- Cross-reference at least 2 sources (ideally official docs + one community thread) in the commit/PR description for non-trivial remaps or behavior changes.
- Match versions: confirm the documented API/action names against the exact plugin version pinned in `lazy-lock.json` before using them.
- Prefer official configuration entry points over ad-hoc hooks (e.g., for Snacks Explorer, set keys under `opts.picker.sources.explorer.win.list.keys` instead of autocmd overrides).
- If API names differ across versions, implement the minimal, verified subset first. Defer additional mappings until names are confirmed for the pinned version.
- Always update local docs when behavior changes:
  - `KEYMAPS.md` for global/editor keymaps
  - `EXPLORER_KEYMAPS.md` for Explorer-specific actions
- Validate after changes with concrete steps (open explorer, test Esc/splits/preview, etc.) and record any known caveats.
