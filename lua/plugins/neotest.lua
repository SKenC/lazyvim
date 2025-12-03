return {
  {
    "nvim-neotest/neotest",
    -- 設定オプション
    opts = {
      summary = {
        -- open: ウィンドウを開く際のVimコマンドを指定
        -- "botright vsplit" : 画面の右端に垂直分割で開く
        -- "vertical resize 40": 幅を40カラムにする（お好みの数値に変更してください）
        open = "botright vsplit | vertical resize 40",
      },
    },
    -- 既存のキーマップを上書き設定
    keys = {
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
          require("neotest").summary.open() -- 実行後にサマリーを開く
        end,
        desc = "Run Nearest (and show summary)",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
          require("neotest").summary.open() -- 実行後にサマリーを開く
        end,
        desc = "Run File (and show summary)",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
          require("neotest").summary.open() -- 実行後にサマリーを開く
        end,
        desc = "Debug Nearest (and show summary)",
      },
    },
  },
}
