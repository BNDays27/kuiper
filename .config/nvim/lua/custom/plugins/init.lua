-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  {
    'startup-nvim/startup.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      require('startup').setup()
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',

    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  { 'norcalli/nvim-colorizer.lua', name = 'Neovim Colorizer', priority = 1000 },
}
