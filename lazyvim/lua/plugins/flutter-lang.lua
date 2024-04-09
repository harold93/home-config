return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    -- config = function()
    --   require("flutter-tools").setup {
    --     flutter_lookup_cmd = '/nix/store/b4jwbp7qcjbi5q04d3pbqwl1kza3mnwn-flutter-wrapped-3.13.8-sdk-links/bin'
    --
    --   }
    -- end,
    -- opt = {
    --   -- flutter_lookup_cmd = '/nix/store/b4jwbp7qcjbi5q04d3pbqwl1kza3mnwn-flutter-wrapped-3.13.8-sdk-links/bin'
    --   flutter_path = '/home/harold/flutter'
    -- }
  },
}
