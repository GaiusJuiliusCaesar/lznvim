-- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins List
require("lazy").setup {

  -- Color Scheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Fuzzy Finder (Files, LSP, etc)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- Visualize buffer as tabs
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Preview markdown live in web browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    ft = { "markdown" },
  },

  -- Comment code
  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup { create_mappings = false }
    end,
  },

  -- Autoclose
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },

  -- LSP Zero
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require "lsp-zero"
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require "cmp"
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup {
        formatting = lsp_zero.cmp_format { details = true },
        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      }
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require "lsp-zero"
      lsp_zero.extend_lspconfig()

      -- if you want to know more about mason.nvim
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps { buffer = bufnr }
      end)

      require("mason-lspconfig").setup {
        ensure_installed = {
          "ansible-language-server",
          "ansible-lint",
          "bash-language-server",
          "beautysh",
          "css-lsp",
          "css-variables-language-server",
          "cssmodules-language-server",
          "django-template-lsp",
          "djlint",
          "docker-compose-language-service",
          "dockerfile-language-server",
          "editorconfig-checker",
          "groovy-language-server",
          "html-lsp",
          "htmlbeautifier",
          "htmlhint",
          "jinja-lsp",
          "json-lsp",
          "lua-language-server",
          "luacheck",
          "nginx-language-server",
          "powershell-editor-services",
          "python-lsp-server",
          "ruff",
          "ruff-lsp",
          "shellcheck",
          "shfmt",
          "sql-formatter",
          "sqlfmt",
          "sqlls",
          "stylua",
          "terraform-ls",
          "tflint",
          "tfsec",
          "vim-language-server",
          "yaml-language-server",
          "yamlfmt",
          "yamllint",
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require("lspconfig")[server_name].setup {}
          end,

          -- this is the "custom handler" for `lua_ls`
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      }
    end,
  },
}
