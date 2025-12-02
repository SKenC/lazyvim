local map = vim.keymap.set

-- === 1. ファイル検索 (Ctrl + p) ===
-- デフォルトのTelescope検索を呼び出します
-- map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)" })
map("n", "<C-p>", function()
  LazyVim.pick("files")()
end, { desc = "Find Files (Root Dir)" })

-- === 2. デバッグ実行の構成選択・開始 (<leader> + e) ===
-- Space + d + c (Debug Continue) と同じ動作
map("n", "<leader>e", function()
  require("dap").continue()
end, { desc = "Debug: Start/Continue" })

-- === 3. 通常実行 (高速化) (<leader> + r) ===
-- Snacks.terminal を使用して現在のファイルを Python で実行します
map("n", "<leader>r", function()
  local file = vim.fn.expand("%") -- 現在のファイル名
  Snacks.terminal({ "python3", file }, {
    cwd = vim.fn.expand("%:p:h"), -- ファイルのあるディレクトリで実行
    interactive = true, -- 実行後、出力を確認できるようにターミナルを開いたままにする
  })
end, { desc = "Run Python File" })

-- === 4. テスト関連 (<leader> + t / g) ===
-- カーソル付近のテストを実行
map("n", "<leader>t", function()
  require("neotest").run.run()
end, { desc = "Run Nearest Test" })
-- カーソル付近のテストをデバッグ実行
map("n", "<leader>g", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug Nearest Test" })

-- === 5. Git Tree (<leader> + n) ===
-- LazyVimではLazyGitが標準なのでそれを呼び出します
map("n", "<leader>n", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- === 7. デバッグコンソールへ移動 (Ctrl + Shift + F8) ===
-- DAPのREPL(対話画面)を開いてフォーカスします
-- ※ ターミナルによっては Shift+F8 が認識されにくい場合があります
map("n", "<C-S-F8>", function()
  require("dap").repl.open()
end, { desc = "Open Debug REPL" })

-- === 8. Neo-tree 開閉 (Ctrl + b) ===
-- 現在のファイルを選択した状態でツリーを開閉
map("n", "<C-b>", "<cmd>Neotree toggle reveal<cr>", { desc = "Toggle Neo-tree" })

-- === 9. ターミナル開閉 (Ctrl + @) ===
-- LazyVim標準のターミナル機能を利用
-- ※ Macのキーボード設定によっては <C-2> と認識されることもあります
map({ "n", "t" }, "<C-@>", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle Terminal" })
-- 念のため Ctrl + ` (backtick) や Ctrl + 2 も同じ挙動にしておくと安心です
map({ "n", "t" }, "<C-`>", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle Terminal" })

-- === 10. デバッグ中の選択範囲実行 (Ctrl + q) ===
-- ビジュアルモードで選択した範囲をデバッガで評価
map("v", "<C-q>", function()
  require("dapui").eval()
end, { desc = "Eval selection in Debug" })
