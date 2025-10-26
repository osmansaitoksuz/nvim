-- Dosya arama ve gezinti
require("telescope").setup({
  defaults = {
    mappings = {
      i = { ["<esc>"] = require("telescope.actions").close },
    },
  },
})

