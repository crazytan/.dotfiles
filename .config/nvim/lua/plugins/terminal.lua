return {
  {
    "snacks.nvim",
    keys = {
      {
        "<c-/>",
        function()
          Snacks.terminal(nil, { win = { style = "float" } })
        end,
        desc = "Float Terminal",
      },
    },
  },
}
