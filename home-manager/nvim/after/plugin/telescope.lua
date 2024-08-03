require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            "./target"
        }
    }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<Leader><Leader>', builtin.oldfiles, {})
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
