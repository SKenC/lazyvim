return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          -- F2 でファイル名変更 (デフォルトは 'r')
          ["<F2>"] = "rename",
        },
      },
    },
  },
}
