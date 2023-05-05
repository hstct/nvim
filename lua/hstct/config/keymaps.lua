local u = require("hstct.util.functions")

-- Fix * (keep the cursor position, don't move to next match)
u.map("n", "*", "*N")

-- Visual * and # search
-- Until https://github.com/neovim/neovim/pull/15472 is merged
u.map("x", "*", 'y/\\V<C-R>"<CR>')
u.map("x", "#", 'y?\\V<C-R>"<CR>')

-- Fix n and N. Keeping cursor in center
u.map("n", "n", "nzz")
u.map("n", "N", "Nzz")

-- Remove highlight
u.map("n", "<ESC>", "<CMD>noh<CR>")

-- Mimic shell movements
u.map("i", "<C-E>", "<C-o>$")
u.map("i", "<C-A>", "<C-o>^")

-- Quickly save the current buffer or all buffers
u.map("n", "<leader>w", "<CMD>update<CR>")
u.map("n", "<leader>W", "<CMD>wall<CR>")

-- Move to the next/previous buffer
u.map("n", "<leader>[", "<CMD>bp<CR>")
u.map("n", "<leader>]", "<CMD>bn<CR>")

-- Move to last buffer
u.map("n", "''", "<CMD>b#<CR>")

-- Copying the vscode behavior of making tab splits
u.map("n", "<C-\\>", "<CMD>vsplit<CR>")
u.map("n", "<A-\\>", "<CMD>split<CR>")

-- Resize window using <Shift> arrow keys
u.map("n", "<S-Up>", "<CMD>resize +2<CR>")
u.map("n", "<S-Down>", "<CMD>resize -2<CR>")
u.map("n", "<S-Left>", "<CMD>vertical resize -2<CR>")
u.map("n", "<S-Right>", "<CMD>vertical resize +2<CR>")

-- Move line up and down in NORMAL and VISUAL modes
-- Reference<CR> https://vim.fandom.com/wiki/Moving_lines_up_or_down
u.map("n", "<A-j>", "<CMD>move .+1<CR>==")
u.map("n", "<A-k>", "<CMD>move .-2<CR>==")
u.map("x", "<A-j>", ":move '>+1<CR>gv=gv")
u.map("x", "<A-k>", ":move '<-2<CR>gv=gv")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
u.map("o", "A", ":<C-U>normal! mzggVG<CR>`z")
u.map("x", "A", ":<C-U>normal! ggVG<CR>")

-- Switch buffers
u.map("n", "<C-Left>", "<CMD>bprevious<CR>")
u.map("n", "<C-Right>", "<CMD>bnext<CR>")
u.map("n", "<S-h>", "<CMD>bp<CR>")
u.map("n", "<S-l>", "<CMD>bn<CR>")
u.map("n", "<S-x>", "<CMD>bdelete!<CR>")
