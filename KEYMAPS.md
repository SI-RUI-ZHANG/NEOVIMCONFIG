# Global Keymaps Summary

This file consolidates all active keymaps defined across the config in this repo. Leader is Space (`<leader> = <Space>`), local leader is backslash (`<localleader> = \`).

- Defined in: `init.lua:1-8`, `lua/config/keymaps.lua:1-99`, plugin specs under `lua/plugins/`.
- Notes on precedence: plugin-provided keymaps added on `VeryLazy` will override earlier mappings from `lua/config/keymaps.lua` when they collide (e.g., Bufferline takes `J/K`).

## Core Editing & Navigation

- Normal: `<Esc>` → clear search highlight (`:nohlsearch`).
- Normal: `H` / `L` → start/end of line (`^`/`$`).
- Normal: `<leader>j` / `<leader>k` → move 15 lines down / up.
- Normal: `Y` → yank to end of line (`y$`).
- Normal: `<leader>a` / `<leader>i` → Append at EOL / Insert at BOL (`A`/`I`).
- Normal/Visual: `<Tab>` / `<S-Tab>` → indent right / left.
- Normal/Visual: `gs` → jump to matching pair (`%`).
- Normal/Visual: `gh` / `gl` → start/end of line.
- Visual: `<leader>i` / `<leader>I` → increment / decrement selection numbers.
- Normal: `<leader>Q` → save all and quit (`:xa`).
- Normal: `<leader>md` / `<leader>mD` → delete one mark / all marks.
- Normal: `<leader>rr` → reload externally changed files (`:checktime`).

References: `lua/config/keymaps.lua:6`, `lua/config/keymaps.lua:9-24`, `lua/config/keymaps.lua:31-59`, `lua/config/autoread.lua:17`.

## Windows & Splits

- Focus: `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` → focus window left / down / up / right.
- Split: `-` / `\` → horizontal / vertical split.
- Resize width: `_` / `+` → narrower / wider (vertical resize −2/+2).
- Resize height: `<S-Up>` / `<S-Down>` → taller / shorter (resize +2/−2).

References: `lua/config/keymaps.lua:16-38`.

## Buffer Management (Bufferline)

- Navigate: `J` / `K` → next / prev buffer.
- Reorder: `<leader>K` / `<leader>J` → move buffer right / left.
- Pin: `<leader>bp` → toggle pin buffer.
- Jump: `<leader>1..9` → go to buffer 1..9.
- Close others: `<leader>C` → close other buffers.
- Pick close: `<leader>x` → pick a buffer to close.
- Smart close: `<leader>c` → context-aware window/buffer close (custom logic).

References: `lua/plugins/bufferline.lua:18-59`, `lua/config/keymaps.lua:66-79`, `lua/config/smart_close.lua:1-160`.

## Search, Pickers, Projects (Snacks)

- Files: `<leader>ff` Smart Find Files, `<leader>F` All Files, `<leader>fg` Git Files, `<leader>fr` Recent, `<leader>fp` Projects, `<leader>e` Explorer.
- Buffers: `<leader>,` Buffers.
- Grep: `<leader>/` Ripgrep workspace, `<leader>sB` Grep open buffers, `<leader>sw` Grep word/visual.
- Command/registers/history: `<leader>:` Command history, `<leader>s"` Registers, `<leader>s/` Search history.
- Lists: `<leader>sb` Buffer lines, `<leader>sC` Commands, `<leader>sl` Location list, `<leader>sq` Quickfix, `<leader>sR` Resume.
- Help/docs: `<leader>sh` Help, `<leader>sH` Highlights, `<leader>si` Icons, `<leader>sk` Keymaps, `<leader>sj` Jumps, `<leader>sp` Search plugin specs.
- Git: `<leader>gb` Branches, `<leader>gl` Log, `<leader>gL` Log (line), `<leader>gs` Status, `<leader>gS` Stash, `<leader>gd` Diff hunks, `<leader>gf` Log (file), `<leader>gB` Git browse, `<leader>gg` Lazygit.
- Scratch/notes: `<leader>.` Toggle scratch, `<leader>S` Select scratch buffer, `<leader>rN` Rename file.
- Terminal: `<C-/>` / `<C-_>` / `<leader>t` → toggle terminal.
- References jump: `)` / `(` → next/prev reference (normal/terminal).

References: `lua/plugins/snacks.lua:81-240`.

### Snacks Toggles

- `<leader>us` Spelling, `<leader>uw` Wrap, `<leader>uL` Relative number, `<leader>ud` Diagnostics, `<leader>ul` Line number,
  `<leader>uc` Conceal level, `<leader>uT` Treesitter, `<leader>ub` Background (dark/light), `<leader>uh` Inlay hints,
  `<leader>ug` Indent guides, `<leader>uD` Dim inactive.

References: `lua/plugins/snacks.lua:241-320` (init User VeryLazy toggle mappings).

## LSP (buffer-local on attach)

- Goto: `gd` Definition, `gD` Declaration, `gi` Implementation, `gy` Type definition.
- Calls: `gai` Incoming, `gao` Outgoing.
- References: `gr` References (skip declarations).
- Symbols/diagnostics: `<leader>ss` Document symbols, `<leader>sS` Workspace symbols, `<leader>sd` Workspace diagnostics, `<leader>sD` Buffer diagnostics.
- Hover/Actions: `<leader>lh` Hover, `<leader>la` Code action (also visual), `<leader>rn` Rename.
- Diagnostics: `<leader>le` Line diagnostics float, `[d` / `]d` Prev/next diagnostic, `<leader>lq` Diagnostics → quickfix.

References: `lua/plugins/lsp.lua:120-179`.

## Formatting (Conform)

- `<leader>lf` Format (smart: range in visual unless whole file selected; else full file).
- `<leader>lF` Format whole file (force; exits visual if active).
- `<leader>li` Conform info (formatters/logs).
- On save: formats small/normal files; skips large files and `node_modules`.

References: `lua/plugins/conform-nvim.lua:1-158` and `lua/plugins/conform-nvim.lua:160-257`.

## Motion (Flash)

- `s` (n/x/o) → jump; `r` (o) → remote; `R` (o/x) → Treesitter search; `<C-s>` (cmdline) → toggle Flash search.

Reference: `lua/plugins/flash-nvim.lua:1-10`.

## AI (Copilot)

- Insert: `<Tab>` Accept, `<M-]>` Next, `<M-[>` Prev, `<C-]>` Dismiss.

Reference: `lua/plugins/copilot.lua:1-18`.

## Completion (blink.cmp)

- Preset: `enter` — `<CR>` accepts completion. Shared defaults: `<C-Space>` open menu/docs, `<C-n>/<C-p>` or `Up/Down` select, `<C-e>` hide, `<C-k>` toggle signature help (if enabled).

Reference: `lua/plugins/blink.lua:1-48`.

## Helper Plugins

- Which-key: `<leader>?` → show buffer-local keymaps (`which-key`).
- Comment.nvim: `gc` (motions/visual) and `gcc` (line) comment toggles (defaults).
- nvim-surround: default mappings enabled (e.g., `ys`, `ds`, `cs`, visual `S`).

References: `lua/plugins/editing.lua:1-24`.

## Explorer Keys (Snacks Explorer)

The explorer view defines its own list window keys:

- `<Esc>` → return focus to previous window.
- `o` → open and keep focus on explorer.
- `s` / `v` → split / vsplit open and keep explorer focus.
- `-` / `\` → split / vsplit open (switch focus to file window).

Reference: `lua/plugins/snacks.lua:20-54`.

### Explorer Defaults

- Navigation: `<CR>` or `l` open file or toggle dir; `h` close dir; `<BS>` go up; `.` focus/set cwd to current dir; `H` toggle hidden; `I` toggle ignored; `Z` close all dirs.
- File ops: `<Tab>` select files; `m` move selection to current dir (single file without selection renames); `c` copy selection to current dir (single file prompts copy name); `r` rename; `d` delete; `a` add file/dir (use `/` suffix for dir).
- System/refresh: `o` open with system application (default; overridden here to open in editor and keep focus); `u` refresh/update tree.
- Yank/paste: `y` yank selected file paths to register; `p` paste (copy files from register) in current dir.
- Quick actions: `<leader>/` grep in current dir; `<C-t>` terminal in current dir; `<C-c>` change tab directory to current dir; `P` toggle preview.
- Git jumps: `]g` / `[g` next/prev git change when `git_status` is enabled (default).
- Diagnostics: `]d` / `[d` next/prev diagnostic, `]e` / `[e` next/prev error, `]w` / `[w` next/prev warning when `diagnostics` is enabled (default).
- Visual mode: `v`/`V` select multiple files; `y` yanks selection; most operations act on selection.

Source: Snacks Explorer docs https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md (pinned `snacks.nvim@de352425` in `lazy-lock.json`).

## Notes & Behavior

- `J/K` navigate buffers (Bufferline). `<leader>j/k` are 15-line jumps. Window focus uses `<C-h/j/k/l>`.
- LSP hover is on `<leader>lh`.
- Explorer-specific mappings only apply in the Snacks Explorer list window.
