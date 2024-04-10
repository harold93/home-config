return {
  -- Text and Edition
  -- ****************************************
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      -- 'David-Kunz/markid',
    },
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "html",
          "css",
          "ruby",
          "vue",
          "nix",
          "bash",
          "json",
          "haskell",
          "dart",
          "typescript"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        endwise = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>", -- set to `false` to disable one of the mappings
            node_incremental = "<C-Space>",
            scope_incremental = "<C-Space>",
            node_decremental = "<BS>",
          },
        },
        autotag = {enable = true},
        -- markid = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },

              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            ["]o"] = "@loop.*",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            ["]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["[d"] = "@conditional.outer",
          },
        },
      })

      --      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
      --
      --      -- Repeat movement with ; and ,
      --      -- ensure ; goes forward and , goes backward regardless of the last direction
      --      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      --      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },
  -- Help to comment
  {
    "echasnovski/mini.comment",
    dependencies = {
      -- Help comment for vue
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
  },
  {
    "vim-scripts/BufOnly.vim",
    config = function ()
      vim.keymap.set('n', '<leader>bda', ':BufOnly<CR>', {desc = 'delete all buff but the current one'})

    end
  },
  -- Text and Edition end
  -- ****************************************


  -- Ui stuff
  -- ****************************************
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = true,
        terminal_colors = true,
        devicons = true, -- highlight the icons of `nvim-web-devicons`
        styles = {
          comment = { italic = true },
          keyword = { italic = true }, -- any other keyword
          type = { italic = true }, -- (preferred) int, long, char, etc
          storageclass = { italic = true }, -- static, register, volatile, etc
          structure = { italic = true }, -- struct, union, enum, etc
          parameter = { italic = true }, -- parameter pass in function
          annotation = { italic = true },
          tag_attribute = { italic = true }, -- attribute of tag in reactjs
        },
        filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
        -- Enable this will disable filter option
        day_night = {
          enable = false, -- turn off by default
          day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
          night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        },
        inc_search = "background", -- underline | background
        background_clear = {},
        -- background_clear = {
        --   "float_win",
        --   "toggleterm",
        --   "telescope",
        --   -- "which-key",
        --   "renamer",
        --   "notify",
        --   -- "nvim-tree",
        --   -- "neo-tree",
        --   -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
        -- },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
          },
          indent_blankline = {
            context_highlight = "default", -- default | pro
            context_start_underline = false,
          },
        },
      })
      vim.cmd("colorscheme monokai-pro")
    end,
  },
  -- find files , search grep
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local ts = require("telescope")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find in files" })
      vim.keymap.set("v", "<leader>ff", "y<ESC>:Telescope find_files default_text=<c-r>0<CR>", { desc = "find in files with select" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find in buffers" })

      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "find in files" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "select mode find in files" })
      vim.keymap.set(
        "v",
        "<leader>sg",
        "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>",
        { desc = "paste in input selected" }
      )

      ts.setup({
        defaults = {
          borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top"
          },
          sorting_strategy = "ascending"
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      ts.load_extension("ui-select")
    end,
  },
  -- Dashbord
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local dashboard = require("alpha.themes.startify")
      local logo = {
        [[ ███       ███ ]],
        [[████      ████]],
        [[██████     █████]],
        [[███████    █████]],
        [[████████   █████]],
        [[█████████  █████]],
        [[█████ ████ █████]],
        [[█████  █████████]],
        [[█████   ████████]],
        [[█████    ███████]],
        [[█████     ██████]],
        [[████      ████]],
        [[ ███       ███ ]],
        [[                  ]],
        [[ N  E  O  V  I  M ]],
      }
      dashboard.section.header.val = logo
      -- no Idea how it works exaclty, try n error with distinguishable colors lol
      dashboard.section.header.opts.hl = {
        {
          { "AlphaNeovimLogoBlue",  0,  0 },
          { "AlphaNeovimLogoGreen", 1,  14 },
          { "AlphaNeovimLogoBlue",  23, 34 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  2 },
          { "AlphaNeovimLogoGreenFBlueB", 2,  4 },
          { "AlphaNeovimLogoGreen",       4,  19 },
          { "AlphaNeovimLogoBlue",        27, 40 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  4 },
          { "AlphaNeovimLogoGreenFBlueB", 4,  7 },
          { "AlphaNeovimLogoGreen",       7,  22 },
          { "AlphaNeovimLogoBlue",        29, 42 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  8 },
          { "AlphaNeovimLogoGreenFBlueB", 8,  10 },
          { "AlphaNeovimLogoGreen",       10, 25 },
          { "AlphaNeovimLogoBlue",        31, 44 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  10 },
          { "AlphaNeovimLogoGreenFBlueB", 10, 13 },
          { "AlphaNeovimLogoGreen",       13, 28 },
          { "AlphaNeovimLogoBlue",        33, 46 },
        },
        {
          { "AlphaNeovimLogoBlue",  0,  13 },
          { "AlphaNeovimLogoGreen", 14, 31 },
          { "AlphaNeovimLogoBlue",  35, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",  0,  13 },
          { "AlphaNeovimLogoGreen", 16, 32 },
          { "AlphaNeovimLogoBlue",  35, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",  0,  13 },
          { "AlphaNeovimLogoGreen", 17, 33 },
          { "AlphaNeovimLogoBlue",  35, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  13 },
          { "AlphaNeovimLogoGreen",       18, 34 },
          { "AlphaNeovimLogoGreenFBlueB", 33, 35 },
          { "AlphaNeovimLogoBlue",        35, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  13 },
          { "AlphaNeovimLogoGreen",       19, 35 },
          { "AlphaNeovimLogoGreenFBlueB", 34, 35 },
          { "AlphaNeovimLogoBlue",        35, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  13 },
          { "AlphaNeovimLogoGreen",       20, 36 },
          { "AlphaNeovimLogoGreenFBlueB", 35, 37 },
          { "AlphaNeovimLogoBlue",        37, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",        0,  13 },
          { "AlphaNeovimLogoGreen",       21, 37 },
          { "AlphaNeovimLogoGreenFBlueB", 36, 37 },
          { "AlphaNeovimLogoBlue",        37, 49 },
        },
        {
          { "AlphaNeovimLogoBlue",  1,  13 },
          { "AlphaNeovimLogoGreen", 20, 35 },
          { "AlphaNeovimLogoBlue",  37, 48 },
        },
        {},
        { { "AlphaNeovimLogoGreen", 0, 9 }, { "AlphaNeovimLogoBlue", 9, 18 } },
      }

      require("alpha").setup(dashboard.config)
    end,
  },
  -- To make rainbow index
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({ indent = { highlight = highlight } })
    end,
  },
  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {'kevinhwang91/promise-async'},
    config = function()

      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      -- vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      -- vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', 'zk', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          -- choose one of coc.nvim and nvim lsp
          vim.fn.CocActionAsync('definitionHover') -- coc.nvim
          vim.lsp.buf.hover()
        end
      end)

      -- Option 1: coc.nvim as LSP client
      --      use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
      --      require('ufo').setup()
      --

      -- Option 2: nvim lsp as LSP client
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
        })
      end
      require('ufo').setup()
      --

      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.)
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      --      require('ufo').setup({
      --        provider_selector = function(bufnr, filetype, buftype)
      --          return {'treesitter', 'indent'}
      --        end
      --      })
    end,
  },
  -- Botton status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "monokai-pro",
      },
    },
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     "3rd/image.nvim",           -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  --   config = function()
  --     vim.keymap.set("n", "<leader>e", ":Neotree position=current<CR>", { desc = "open neotree page" })
  --     vim.keymap.set(
  --       "n",
  --       "<leader>1",
  --       ":Neotree source=filesystem toggle=true position=right<CR>",
  --       { desc = "open neotree to the right" }
  --     )
  --   end,
  -- },
  -- Ui stuff end
  -- ****************************************


  -- LSP CONFIGS
  -- *****************************************
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "solargraph", "jsonls", "hls", "volar", "tsserver" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.solargraph.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.hls.setup({})
      lspconfig.volar.setup({})
      lspconfig.tsserver.setup({})

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to def" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show info" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "show implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "show ref" })
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { desc = "see code action" })
      vim.keymap.set(
        "n",
        "<leader>cd",
        vim.diagnostic.setloclist,
        { desc = "show diagnostics in buf", noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ck",
        vim.diagnostic.open_float,
        { desc = "show diagnostics in popup", noremap = true, silent = true }
      )

      -- Disabling annoying text lsp
      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = true,
          })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local mason_null_ls = require("mason-null-ls")

      mason_null_ls.setup({
        ensure_installed = { "stylua", "rubocop" },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- formatters
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.rubocop,

          -- diag
          -- null_ls.builtins.diagnostics.rubocop,
        },
      })

      vim.keymap.set({"n", "v"}, "<leader>cf", vim.lsp.buf.format, { desc = "format with lsp" })
    end,
  },
  -- Autocomplete
  {
    "hrsh7th/nvim-cmp", -- for what I understood cmp is a ui dropdown
    dependencies = {
      -- engine for cmp
      'L3MON4D3/LuaSnip',
      -- the gatweay between cmp and and engine
      'saadparwaiz1/cmp_luasnip',
      -- lsp source (engine)
      'neovim/nvim-lspconfig',
      -- the gatweay between cmp and and lsp
      'hrsh7th/cmp-nvim-lsp',
      -- buffer source
      'hrsh7th/cmp-buffer',
      -- filesystem source
      'hrsh7th/cmp-path',
      -- vim command source
      'hrsh7th/cmp-cmdline',
      -- Add pico to cmp
      "onsails/lspkind.nvim"
    },
    config = function()
      -- Set up nvim-cmp.
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
          }
        ),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as 
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (_, vim_item)
              return vim_item
            end
          })
        }
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}

      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
          capabilities = capabilities
          -- you can add other fields for setting up lsp server in this table
        })
      end
    end,
  },
  -- LSP CONFIGS end
  -- ****************************************


  -- Neovim and external bins
  -- ****************************************
  -- Navigation nvim tmux
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- Neovim and external bins end
  -- ****************************************


  -- Git integration
  -- ****************************************
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          --  local function map(mode, lhs, rhs, opts)
          --    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
          --    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          --  end

          --  -- Actions
          --  map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { desc = "preview of git hunk" })
          --  map(
          --    "n",
          --    "<leader>gb",
          --    '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
          --    { desc = "toggle git blame" }
          --  )

          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>gh", gs.preview_hunk, {desc = "preview hunk"})
          map("n", "<leader>gb", gs.toggle_current_line_blame, {desc = { "git blame current line"}})
          map('n', '<leader>grh', gs.reset_hunk, {desc = "reset hunk"})
          map('v', '<leader>grh', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "reset hunk"})
        end,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit", noremap = true, silent = true },
    },
  },
  -- Git integration end
  -- ****************************************


}
