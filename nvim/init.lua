require('plugins')
-- 1. Style
vim.o.syntax = 'on'
vim.o.number = true
vim.o.relativenumber = true

vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.guioptions=Ace

vim.api.nvim_set_hl(0, 'Normal', {ctermbg=black, guibg=black, guifg=white})
vim.api.nvim_set_hl(0, 'Comment', {fg='cyan'})
vim.api.nvim_set_hl(0, 'Preproc', {fg='yellow'})
vim.api.nvim_set_hl(0, 'Question', {fg='yellow'})
vim.api.nvim_set_hl(0, 'Statement', {fg='white'})
vim.api.nvim_set_hl(0, 'Identifier', {fg='white'})
vim.api.nvim_set_hl(0, 'Function', {fg='lightgray'})
vim.api.nvim_set_hl(0, 'Type', {fg='magenta'})
vim.api.nvim_set_hl(0, 'Label', {fg='magenta'})

vim.api.nvim_set_hl(0, 'String', {fg='lightgreen'})
vim.api.nvim_set_hl(0, 'Character', {fg='lightgreen'})
vim.api.nvim_set_hl(0, 'Number', {fg='lightgreen'})
vim.api.nvim_set_hl(0, 'Boolean', {fg='lightgreen'})

vim.api.nvim_set_hl(0, 'Delimiter', {fg='gray'})

-- 2. Keybinds
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader><leader>', '<cmd>Ex<cr>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>')

vim.keymap.set('n', '<leader>t', '<cmd>tabe<cr>')
vim.keymap.set('n', '<leader>l', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>tabprevious<cr>')

vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')

vim.keymap.set('x', 'p', 'P')

-- 3. Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.path = vim.o.path .. '**'

-- 4. Plugin config
vim.g.UltiSnipsExpandTrigger='<tab>'
vim.g.UltiSnipsJumpForwardTrigger='<c-b>'
vim.g.UltiSnipsJumpBackwardTrigger='<c-z>'
vim.g.UltiSnipsSnippetDirectories={'/home/tori/.vim/UltiSnips'}
