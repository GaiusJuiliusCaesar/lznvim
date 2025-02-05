-- Space bar leader key
vim.g.mapleader = " "

-- Buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- Yank to Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Ruff
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "Format current buffer with Ruff" })
