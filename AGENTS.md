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
