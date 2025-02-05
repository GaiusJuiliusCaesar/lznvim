-- Set Encoding
vim.opt.encoding = "utf-8"
-- Enable Line numbers
vim.opt.nu = true
-- Relative Line numbers
vim.opt.relativenumber = true

-- Spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Convert tabs to spaces
vim.opt.expandtab = true
-- Auto Indentation
vim.opt.autoindent = true
-- Show tab characters and trailing whitespace
vim.opt.list = true

-- Disable backup and swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

-- Ignore case when searching
vim.opt.ignorecase = true
-- Unless capital letter in search
vim.opt.smartcase = true

-- Do not highlight all matches on previous search pattern
vim.opt.hlsearch = false
-- Incrementally highlight searches as you type
vim.opt.incsearch = true

-- Enable true color support
vim.opt.termguicolors = true

-- Minimum number of lines to keep above and below the cursor
vim.opt.scrolloff = 8
-- Minimum number of columns to keep above and below the cursor
vim.opt.sidescrolloff = 8

-- Colorcolumn
vim.opt.colorcolumn = "80"

-- Python formatting
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.py", "*.toml" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.textwidth = 88
    vim.opt.colorcolumn = "80"
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line "'\"" > 0 and vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.cmd 'normal! g`"'
    end
  end,
})
