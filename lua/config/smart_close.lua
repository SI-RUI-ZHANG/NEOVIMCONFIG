local M = {}

local function is_float(win)
  local cfg = vim.api.nvim_win_get_config(win)
  return cfg and cfg.relative ~= "" and cfg.relative ~= nil
end

local function list_normal_windows()
  local wins = {}
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if not is_float(w) then table.insert(wins, w) end
  end
  return wins
end

local function is_explorer_win(win)
  local b = vim.api.nvim_win_get_buf(win)
  local ft = vim.bo[b].filetype or ""
  return ft == "snacks_explorer" or ft:match("^snacks_picker") ~= nil
end

local function has_explorer()
  for _, w in ipairs(list_normal_windows()) do
    if is_explorer_win(w) then return true end
  end
  return false
end

local function cur_is_explorer()
  return is_explorer_win(vim.api.nvim_get_current_win())
end

local function is_file_win(win)
  local b = vim.api.nvim_win_get_buf(win)
  return vim.bo[b].buftype == "" and not is_explorer_win(win)
end

local function list_file_windows()
  local out = {}
  for _, w in ipairs(list_normal_windows()) do
    if is_file_win(w) then table.insert(out, w) end
  end
  return out
end
local function close_window()
  pcall(vim.cmd, "silent! close")
end

local function switch_then_delete_prev()
  local prev = vim.api.nvim_get_current_buf()
  -- save current buffer if possible
  pcall(vim.cmd, "silent! update")
  -- try bufferline prev (matches <leader>k), then builtin prev/next
  local ok = pcall(vim.cmd, "silent! BufferLineCyclePrev")
  if not ok or vim.api.nvim_get_current_buf() == prev then
    pcall(vim.cmd, "silent! bprevious")
  end
  if vim.api.nvim_get_current_buf() == prev then
    pcall(vim.cmd, "silent! bnext")
  end
  if vim.api.nvim_get_current_buf() == prev then
    -- no alternate buffer, keep layout with an empty buffer
    pcall(vim.cmd, "enew")
  end
  if vim.api.nvim_buf_is_valid(prev) then
    pcall(vim.api.nvim_buf_delete, prev, { force = false })
  end
end

function M.close()
  local wins = list_normal_windows()
  local explorer_open = has_explorer()
  local file_wins = list_file_windows()
  local n_file_wins = #file_wins

  if not explorer_open then
    -- No Explorer
    if n_file_wins >= 2 then
      -- Multiple file windows -> close current window
      close_window()
      return
    end
    -- Single file window -> switch/enew then delete previous
    switch_then_delete_prev()
    return
  end

  -- Explorer is open
  if n_file_wins >= 2 then
    -- Multiple file windows present -> close current window
    close_window()
    return
  end

  if n_file_wins == 1 then
    if cur_is_explorer() then
      -- Focused on explorer -> close all explorer-related windows
      for _, w in ipairs(wins) do
        if is_explorer_win(w) then pcall(vim.api.nvim_win_close, w, true) end
      end
      return
    else
      -- Focused on file -> switch/enew then delete previous
      switch_then_delete_prev()
      return
    end
  end

  -- Only Explorer windows remain -> close current (Explorer) window
  close_window()
end

return M
