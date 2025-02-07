require("bufferline").setup{
options = {
    always_show_bufferline = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    modified_icon = "",
    show_tab_indicators = true,
    tab_size = 5,
    -- separator_style = "thin",
    numbers = function(opts)
      return opts.ordinal
    end,
  },
  highlights = {
    indicator_selected = {
      guifg = {
          attribute = "fg",
          highlight = "Type"
      },
      guibg = {
          attribute = "bg",
          highlight = "Type"
      },
    },
    buffer_selected = {
      gui = "NONE",
    },
    pick_selected = {
      gui = "NONE",
    },
  },
}
