# Neovim Keymaps & Commands

Leader: Space (`<leader>` = Space). Local leader: `\`.

This file summarizes the most useful keymaps and commands configured in this Neovim setup, grouped by function. Unless noted, mappings are available in Normal mode.

## Navigation & Windows
- Clear search highlight: `<Esc>`
- Line start/end: `H` → `^`, `L` → `$`
- Scroll half-page centered: `<leader>j` → `<C-d>zz`, `<leader>k` → `<C-u>zz`
- Split windows: `<leader>-` horizontal, `<leader>|` vertical
- Window close/only: `<leader>c` close, `<leader>C` keep only this window
- Window focus: `<C-h/j/k/l>` move between splits
- Match pair (easier %): `gs` in Normal/Visual jumps to matching pair

## Buffers (bufferline)
- Next/Prev buffer: `]b` / `[b`
- Move buffer right/left: `]B` / `[B`
- Jump to buffer N: `<leader>1..9`
- Close via pick: `<leader>bX`
- Close others/left/right: `<leader>bo` / `<leader>bh` / `<leader>bl`
- Pin/unpin: `<leader>bp`
- Delete current buffer (Snacks): `<leader>bd`

## Files & Explorer (Snacks)
- Open explorer: `<leader>e`
- Smart find files (git-aware): `<leader>ff`
- Plain file search (all files): `<leader>F`
- Git files: `<leader>fg`
- Recent files: `<leader>fr`
- Config files: `<leader>fc`
- Projects: `<leader>fp`

Note: Snacks Explorer provides sensible defaults inside the explorer (e.g., Enter/o open, s horizontal split, v vertical split, p preview).

## Search, Pickers, and Registers (Snacks)
- Live grep: `<leader>/`
- Command history: `<leader>:`
- Buffers picker: `<leader>,`
- Registers: `<leader>s"`
- Search history: `<leader>s/`
- Autocmds: `<leader>sa`
- Buffer lines: `<leader>sb`
- Commands: `<leader>sC`
- Help/Highlights/Icons: `<leader>sh` / `<leader>sH` / `<leader>si`
- Jumps/Keymaps/Loclist/Marks: `<leader>sj` / `<leader>sk` / `<leader>sl` / `<leader>sm`
- Man pages/Plugins/Qflist: `<leader>sM` / `<leader>sp` / `<leader>sq`
- Resume/Undo history: `<leader>sR` / `<leader>su`
- Notifications list: `<leader>n`

## LSP (on attach)
- Goto: `gd` definition, `gD` declaration, `gr` references, `gi` implementations, `gy` type def
- Call hierarchy: `gai` incoming, `gao` outgoing
- Symbols: `<leader>ss` document, `<leader>sS` workspace
- Diagnostics: `<leader>sd` workspace, `<leader>sD` buffer
- Line diagnostics: `<leader>le`
- Next/Prev diagnostic: `]d` / `[d`
- Diagnostics → quickfix: `<leader>lq`
- Hover: `K`
- Code action: `<leader>ca` (Normal/Visual)
- Rename symbol: `<leader>rn`

## Formatting (Conform)
- Smart format (range when appropriate): `<leader>lf` (Normal/Visual)
- Force whole-file format: `<leader>lF` (Normal/Visual)
- Conform info: `<leader>li`

## Flash (navigation)
- Flash jump: `s` (Normal/Visual/Operator)
- Remote flash (operator-pending): `r`
- Treesitter search: `R` (Operator/Visual)
- Toggle in command-line: `<C-s>`

Reference jumps (Snacks words)
- Next/Prev reference (word under cursor): `)` / `(`
- Section motions `[[` / `]]` use Vim defaults (not remapped)

## Git (Snacks)
- Lazygit: `<leader>gg`
- Browse on remote: `<leader>gB` (Normal/Visual)
- Status/Diff/Branches: `<leader>gs` / `<leader>gd` / `<leader>gb`
- Log (project/line/file): `<leader>gl` / `<leader>gL` / `<leader>gf`
- Stash list: `<leader>gS`

## Scratch, Zen, Terminal, Toggles
- Scratch buffer toggle/select: `<leader>.` / `<leader>S`
- Zen/Zoom: `<leader>z` / `<leader>Z`
- Terminal toggle: `<C-/>` (also `<C-_>`)
- Neovim News: `<leader>N`
- Reload externally changed files: `<leader>rr`

Toggles (Snacks)
- Spell/Wrap/Relativenumber: `<leader>us` / `<leader>uw` / `<leader>uL`
- Diagnostics/Line numbers: `<leader>ud` / `<leader>ul`
- Conceallevel/Treesitter: `<leader>uc` / `<leader>uT`
- Background (light/dark): `<leader>ub`
- Inlay hints/Indent/Dim: `<leader>uh` / `<leader>ug` / `<leader>uD`

## Editing
- Yank to EOL: `Y`
- Insert at end/start of line: `<leader>a` → `A`, `<leader>i` → `I`
- Indent/unindent (Normal/Visual): `<Tab>` / `<S-Tab>`

Visual mode
- Increment/Decrement numbers in selection: `<leader>i` / `<leader>I`
- Move view: `<leader>j` down, `<leader>k` up
- Match pair: `gs`
- Line start/end: `H` / `L`
- Re-indent selection: `<Tab>` / `<S-Tab>`

## Helpers
- Which-key for buffer-local maps: `<leader>?`

Notes
- “Buffers” are shown as tabs via bufferline; real Vim tabpages use defaults (`gt/gT`) and are not remapped.
- Some pickers integrate with project roots/LSP for scope; smart file search prefers Git when available.
