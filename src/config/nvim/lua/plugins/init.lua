return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    enabled = true,
    config = function()
      require("nvim-treesitter").install {
        "rust",
        "zig",
        "typescript",
        "javascript",
        "tsx",
        "jsx",
        "astro",
        "html",
        "css",
        "scss",
        "svelte",
        "c",
        "cpp",
        "go",
        "cmake",
        "lua",
        "python",
        "bash",
        "markdown",
        "markdown_inline",
        "toml",
        "kdl",
        "yaml",
        "json",
        "jsonc",
        "ini",
        "dockerfile",
      }
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
  },

  {
    "mason-org/mason.nvim",
    enabled = false,
  },
}
