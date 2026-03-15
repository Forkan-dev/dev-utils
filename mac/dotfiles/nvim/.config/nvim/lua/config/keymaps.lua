local map = vim.keymap.set

-- Window navigation (consistent with tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Quick save / quit
map("n", "<leader>w", "<cmd>w<cr>",  { desc = "Save file" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
