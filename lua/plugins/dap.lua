return {
  {
    "mfussenegger/nvim-dap",
    -- keysセクションでキーマップの上書き・無効化を行います
    keys = {
      -- 1. LazyVimデフォルトの "Toggle REPL" (<leader>dr) を無効化します
      { "<leader>dr", false },

      -- 2. ここに「デバッグなし実行」のキーマップを定義します
      --    ご希望の <leader>r を使う場合の設定です
      {
        "<leader>r",
        function()
          local dap = require("dap")
          local dapui = require("dapui")
          if not dap.configurations.python then
            require("dap.ext.vscode").load_launchjs()
          end

          -- 設定を選んで noDebug で実行
          require("dap.ui").pick_one(dap.configurations.python, "Select Configuration (No Debug)", function(item)
            return item.name
          end, function(choice)
            if choice then
              local config = vim.deepcopy(choice)
              config.noDebug = true
              config.name = config.name .. " (No Debug)"
              -- 【追加】ここで明示的にUIを開く
              dapui.open()
              dap.run(config)
            end
          end)
        end,
        desc = "Run without Debug (launch.json)",
      },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    -- レイアウト設定（先ほどの内容）
    opts = {
      layouts = {
        {
          elements = {
            { id = "console", size = 1.0 },
          },
          size = 60,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 1.0 },
          },
          size = 0.25,
          position = "bottom",
        },
      },
    },
    -- config関数で動作（リスナー）を定義
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      -- 設定（opts）を読み込んでUIをセットアップ
      dapui.setup(opts)

      -- 【ここが重要】デバッグ開始時(初期化時)にUIを自動で開く
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- (任意) デバッグ終了時にUIを自動で閉じる
      -- 自動で閉じたくなければ、以下の2つのブロックは削除してください
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
    end,
  },
}
