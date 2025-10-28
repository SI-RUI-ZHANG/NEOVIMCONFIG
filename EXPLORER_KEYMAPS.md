# Snacks Explorer: Actions and Recommended Keymaps

Scope: These keys are intended to be active only inside the Snacks Explorer buffer (`filetype=snacks_explorer`). They avoid Ctrl chords and aim for simple, mnemonic letters. The global toggle for the explorer remains `<leader>e`. Inside the explorer, `<Esc>` only moves focus back to the previous window and does not close the explorer.

## Open & Preview

- Enter / `o` — Open file in the current window
- `-` — Open in horizontal split
- `\` — Open in vertical split
- `p` — Preview file (peek without changing active window)
- `l` — Expand directory / open file (Right)
- `h` — Collapse directory / go to parent if already collapsed (Left)
- `u` — Go to parent directory
- `R` — Refresh listing
- `.` — Toggle hidden files (dotfiles)

## Create, Rename, Delete

- `n` — New file
- `N` — New folder
- `r` — Rename file or folder
- `d` — Delete (safe/trash with confirmation)
- `D` — Delete permanently (force)

## Select, Copy, Move, Duplicate

- `m` — Toggle mark on the current item
- `M` — Mark all
- `U` — Unmark all
- `x` — Cut (prepare to move marked/current item)
- `c` — Copy (prepare to duplicate marked/current item)
- `P` — Paste (execute the pending move/copy)
- `C` — Duplicate current item (shorthand for copy → paste in-place)

## Paths & Clipboard

- `y` — Yank relative path to the item
- `Y` — Yank absolute filesystem path
- `gy` — Yank filename only (no path)
- `gY` — Yank directory path only

## External & Terminal

- `gx` — Open with system handler (OS default application)
- `T` — Open terminal here (split at bottom in the item’s directory)

## Notes & Conflicts

- No `q`/`Esc` to close: use `<leader>e` to toggle the explorer; `<Esc>` only returns focus to the previous window.
- H/J/K/L are reserved globally for window navigation. Use lowercase `h`/`l` for folding/expanding nodes inside the explorer.
- Bulk operations (`x`, `c`, `P`) work on the marked set if any item is marked; otherwise they apply to the current item.

## Rationale

- Single-letter, discoverable keys mirror common file manager conventions (nvim-tree, netrw-inspired flows) while avoiding Ctrl chords.
- `m` for mark keeps “Space” free (Space is your global `<leader>` and should not be overloaded here).
- `s`/`v` match split directions; `p` is an easy mnemonic for preview; `.` for hidden files feels natural.
- Separate yank actions (`y`, `Y`, `gy`, `gY`) cover frequent clipboard needs without nested prompts.
