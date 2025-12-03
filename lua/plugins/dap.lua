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
              dap.run(config)
            end
          end)
        end,
        desc = "Run without Debug (launch.json)",
      },
    },
  },
}
