return {
  -- Палитра из обоев (файл lua/matugen.lua генерит Noctalia)
  { "RRethy/base16-nvim", lazy = false, priority = 1000 },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Статусная строка
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "filename", symbols = { modified = " ●", readonly = " " } } },
        lualine_c = { "branch", "diff", "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = { "encoding", "fileformat" },
        lualine_z = { "progress", "location" },
      },
    },
  },

  -- Строка буферов
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        offsets = { { filetype = "NvimTree", text = "Файлы", highlight = "Directory" } },
      },
    },
  },

  -- Подсветка синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    -- ветка main выкинула nvim-treesitter.configs; на master классический API живой
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "python", "json", "yaml", "toml", "markdown" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Поиск
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Найти файл" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Поиск по тексту" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Буферы" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Справка" },
    },
    opts = { defaults = { borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" } } },
  },

  -- Дерево файлов
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Дерево файлов" } },
    opts = { view = { width = 32 }, renderer = { group_empty = true } },
  },

  -- Git в поле знаков
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },

  -- Подсказки по клавишам
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },

  -- Автопарные скобки
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Направляющие отступов
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = { "BufReadPost", "BufNewFile" }, opts = { indent = { char = "│" } } },
}
