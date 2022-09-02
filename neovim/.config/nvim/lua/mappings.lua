local function map(mode, keys, command)
  api.nvim_set_keymap(mode, keys, command, { noremap = true, silent = true })
end

local active = false
function Minimal()
  if active then
    opt.number = true
    opt.showmode = false
    opt.showtabline = 2
    opt.laststatus = 2
    opt.signcolumn = 'yes'
    opt.foldcolumn = '0'
  else
    opt.number = false
    opt.relativenumber = false
    opt.showmode = true
    opt.showtabline = 0
    opt.laststatus = 0
    opt.signcolumn = 'no'
    opt.foldcolumn = '1'
  end
  active = not active
end

-- Terminal
map("n", "<leader>v", ":vs +terminal | startinsert<CR>")
map("n", "<leader>h", ":split +terminal | startinsert<CR>")

-- Minimal toggle
map("n", "<leader>m", ":lua Minimal()<CR>")
map("n", "<leader>n", ":set relativenumber!<CR>")

-- Hard update
map("n", "<leader>u", ":tabnew | term cd $HOME/.config/nvim && git reset --hard HEAD && git pull<CR>")

-- Telescope
map("n", "<leader><space>", ":Telescope<CR>")
map("n", "<C-D>", ":Telescope find_files<CR>")

-- NvimTree
map("n", "<C-B>", ":NvimTreeToggle<CR>")

-- Comment
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)")

-- Insert Map
map("i", "<C-E>", "<End>")
map("i", "<C-A>", "<Home>")
map("i", "jk", "<Esc>")

-- Shift tab
map("i", "<S-TAB>", "<ESC><<<Ins>")
