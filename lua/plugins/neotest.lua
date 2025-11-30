return {
  {
    "nvim-neotest/neotest",
    -- keys オプションを使うと、プラグイン読み込み時にキー設定を上書きできます
    keys = {
      -- === 1. 邪魔なデフォルト設定を無効化 (false) ===
      -- これらを消さないと、<leader>t を押した瞬間にNeovimが次の入力を待ってしまいます
      { "<leader>tt", false }, -- 元: Run Nearest
      { "<leader>tf", false }, -- 元: Run File
      { "<leader>ta", false }, -- 元: Run All
      { "<leader>ts", false }, -- 元: Summary
      { "<leader>to", false }, -- 元: Output
      { "<leader>tl", false }, -- 元: Run Last
      { "<leader>tw", false }, -- 元: Watch

      -- === 2. ご希望の設定を適用 ===
      -- カーソル付近のテストを実行
      {
        "<leader>t",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
      -- カーソル付近のテストをデバッグ実行
      {
        "<leader>g",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },

      -- === 3. (推奨) 消えた「ファイル全体のテスト」を別キーに救済 ===
      -- <leader>t を占有したせいでファイル全体実行ができなくなるため、
      -- 必要であれば Shift + t (<leader>T) などに割り当てておくと便利です。
      {
        "<leader>T",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Current File Test",
      },
    },
  },
}
