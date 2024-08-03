vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup()

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.del('n', '<C-]>', { buffer = bufnr })
    vim.keymap.set('n', '<C-e>', api.tree.reload,                       opts('Refresh'))

    -- add your mappings
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    ---
end

require("nvim-tree").setup({
    on_attach = my_on_attach
})

