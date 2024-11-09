-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy.nvim if it's not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
     'git',
     'clone',
     '--filter=blob:none',
     'https://github.com/folke/lazy.nvim.git',
     lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'neoclide/coc.nvim',      branch = 'release' },
  'voldikss/vim-floaterm',
  'Raimondi/delimitMate',
  'mileszs/ack.vim',
  'tpope/vim-sleuth',
  { 'junegunn/fzf',           build = './install --all' },
  'junegunn/fzf.vim',
  'ryanoasis/vim-devicons',
  'preservim/nerdtree',
  'morhetz/gruvbox',
  'psliwka/vim-smoothie',
  'chaoren/vim-wordmotion',
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      load_on_setup = true,
      previewer = true,
      theme_conf = {
        border = true,
        -- layout_config = {
        --   width = 0.8, -- Can set width and height as percent of window
        --   height = 0.5,
        -- },
      },
    }
  }
})

-- ============================
-- Basic Settings
-- ============================

vim.opt.exrc = true                   -- Allow local .vimrc
vim.opt.swapfile = false              -- Disable swapfile
vim.opt.backup = false                -- Disable backup
vim.opt.clipboard = 'unnamed'         -- Use system clipboard
vim.opt.encoding = 'utf-8'            -- Set encoding to UTF-8
vim.opt.incsearch = true              -- Incremental search
vim.opt.showmode = false              -- Hide mode display
vim.opt.background = 'dark'           -- Dark background
vim.opt.autowrite = true              -- Automatically save before commands like :next
vim.opt.autowriteall = true           -- Automatically save all buffers
vim.opt.formatoptions:remove('c')     -- Disable automatic commenting on new lines
vim.opt.formatoptions:remove('r')
vim.opt.formatoptions:remove('o')
vim.opt.mouse = 'a'                   -- Enable mouse in all modes
vim.opt.scrolloff = 8                 -- Keep 8 lines visible above and below the cursor
vim.opt.cursorline = true             -- Highlight current line
vim.opt.ignorecase = true             -- Case-insensitive search
vim.opt.smartcase = true              -- Override ignorecase if search contains uppercase
vim.opt.number = true                 -- Show line numbers
vim.opt.errorbells = false            -- Disable error bells
vim.opt.visualbell = false            -- Disable visual bell
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'  -- Set undo directory
vim.opt.undofile = true               -- Enable persistent undo
vim.opt.tabstop = 4                   -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4                -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true              -- Convert tabs to spaces
vim.opt.wrap = false                  -- Disable line wrapping
vim.opt.colorcolumn = '100'           -- Highlight column 100
vim.opt.hidden = true                 -- Allow hidden buffers
vim.opt.backspace = { 'indent', 'eol', 'start' }  -- Better backspace behavior
vim.opt.hlsearch = true               -- Highlight search matches

-- Set command height and update time for better UI
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')         -- Don't show ins-completion-menu messages
vim.opt.signcolumn = 'yes'            -- Always show sign column

-- ============================
-- Appearance
-- ============================

vim.cmd('syntax on')
vim.cmd('colorscheme gruvbox')

-- ============================
-- Mappings
-- ============================

local opts = { noremap = true, silent = true }

-- General Mappings
vim.keymap.set('n', '<leader><Esc>', ':noh<CR>', opts)
vim.keymap.set('n', 'K', 'kJ', opts)
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', opts)

-- Window Resize
vim.keymap.set('n', '<leader>vr', ':vertical resize 30<CR>', opts)
vim.keymap.set('n', '<leader>r+', ':vertical resize +5<CR>', opts)
vim.keymap.set('n', '<leader>r-', ':vertical resize -5<CR>', opts)

-- Floaterm Terminal
vim.keymap.set('n', '<leader>`', ':FloatermToggle<CR>', opts)
vim.keymap.set('t', '<leader>`', '<C-\\><C-n>:FloatermToggle<CR>', opts)

-- NERDTree Mappings
vim.keymap.set('n', '<leader>pt', ':NERDTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>pv', ':NERDTreeFind<CR>', opts)

-- FZF Mappings
vim.keymap.set('n', '<leader>pf', ':Files<CR>', opts)

-- Code Action Mappings (Assuming CoC)
vim.keymap.set('n', '<leader>gn', '<Plug>(coc-rename)', { silent = true })
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gt', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Apply Code Actions
vim.keymap.set('n', '<leader>ga', '<Plug>(coc-codeaction-selected)', { silent = true })
vim.keymap.set('n', '<leader>gac', '<Plug>(coc-codeaction-cursor)', { silent = true })
vim.keymap.set('n', '<leader>gas', '<Plug>(coc-codeaction-source)', { silent = true })
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)', { silent = true })

-- Navigate Diagnostics
vim.keymap.set('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })

-- Yank to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)

-- Toggle Test File in Go (Assuming you set up Go functions)
vim.keymap.set('n', '<leader>tt', ':GoToggleTestFile<CR>', opts)
vim.keymap.set('n', '<leader>tf', ':GoTestFile<CR>', opts)
vim.keymap.set('n', '<leader>tc', ':GoTestAtCursor<CR>', opts)

-- Toggle Highlighting
vim.keymap.set('n', '<leader><leader>', 'V', opts)

-- Autocomplete Mappings (Assuming CoC)
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<TAB>', [[coc#pum#visible() ? coc#pum#next(1) : v:lua.CheckBackspace() ? "\<Tab>" : coc#refresh()]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true, silent = true })

-- DelimitMate CR handling
-- This is broken and is inserting > for some reason.
-- vim.api.nvim_set_keymap('i', '<CR>', [[pumvisible() ? "\<C-y>" : "<Plug>delimitMateCR>"]], { expr = true })


-- ============================
-- Functions
-- ============================

-- Check if backspace is possible
function _G.CheckBackspace()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Escape special characters in search patterns
local function EscapeSpecialChars(pattern)
  return pattern:gsub('([\\/.*$^~[%]])', '\\%1')
end

-- Visual mode search with Ack
function _G.VisualSearchAck()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local selected_text = table.concat(lines, '\n')
  local escaped_text = EscapeSpecialChars(selected_text)
  vim.cmd('Ack! -Q ' .. escaped_text)
end

-- Toggle Go Test File
function _G.GoToggleTestFile()
  local current_file = vim.fn.expand('%:t')
  local target_file = ''
  if current_file:match('_test%.go$') then
    target_file = current_file:gsub('_test%.go$', '.go')
  else
    target_file = current_file:gsub('%.go$', '_test.go')
  end
  local target_path = vim.fn.expand('%:p:h') .. '/' .. target_file
  if vim.fn.filereadable(target_path) == 1 then
    vim.cmd('edit ' .. target_path)
  else
    print('Target file not found: ' .. target_path)
  end
end
vim.api.nvim_create_user_command('GoToggleTestFile', _G.GoToggleTestFile, {})

-- Go Testing Functions
local function GetGoPackagePath(filepath)
  return filepath:gsub('^.*/src/(.*)/[^/]+$', 'golang.a2z.com/%1')
end

local function GetTestName(line)
  return line:match('^func%s+Test(%w+)')
end

function _G.GoTestFile()
  local current_path = vim.fn.expand('%:p')
  local test_path = ''
  if current_path:match('_test%.go$') then
    test_path = current_path
  else
    test_path = current_path:gsub('%.go$', '_test.go')
  end
  local go_package = GetGoPackagePath(test_path)
  local lines = vim.fn.readfile(test_path)
  local test_names = {}
  for _, line in ipairs(lines) do
    local name = line:match('^func%s+Test(%w+)')
    if name then
      table.insert(test_names, 'Test' .. name)
    end
  end
  local test_pattern = table.concat(test_names, '|')
  print('Running tests in ' .. go_package)
  print(vim.fn.system('go test ' .. go_package .. ' -run "^(' .. test_pattern .. ')$"'))
end
vim.api.nvim_create_user_command('GoTestFile', _G.GoTestFile, {})

function _G.GoTestAtCursor()
  local current_path = vim.fn.expand('%:p')
  if not current_path:match('_test%.go$') then
    print('Not a test file')
    return
  end
  local test_func_line = vim.fn.search('func%s\\+Test', 'bW')
  if test_func_line == 0 then
    print('No test function found')
    return
  end
  local test_name = GetTestName(vim.fn.getline(test_func_line))
  local go_package = GetGoPackagePath(current_path)
  print('Running test ' .. test_name .. ' in ' .. go_package)
  print('go test ' .. go_package .. ' -run ^Test' .. test_name .. '$')
end
vim.api.nvim_create_user_command('GoTestAtCursor', _G.GoTestAtCursor, {})

-- ============================
-- Autocommands
-- ============================

vim.api.nvim_create_augroup('vimrc_settings', { clear = true })

-- Reload buffer if file changes
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'vimrc_settings',
  pattern = '*',
  command = 'checktime',
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'vimrc_settings',
  pattern = '*',
  command = [[:%s/\s\+$//e]],
})

-- Prettier for TypeScript
vim.api.nvim_create_autocmd('FileType', {
  group = 'vimrc_settings',
  pattern = 'typescript',
  command = 'setlocal formatprg=prettier\\ --parser\\ typescript',
})

-- Autocomplete settings
vim.api.nvim_create_autocmd('FileType', {
  group = 'vimrc_settings',
  pattern = 'css',
  command = 'setlocal omnifunc=csscomplete#CompleteCSS',
})

-- Tab settings for specific filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = 'vimrc_settings',
  pattern = 'javascript,typescript',
  command = 'setlocal tabstop=2 shiftwidth=2 sts=0 expandtab',
})

-- Toggle cursor line in insert mode
vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  group = 'vimrc_settings',
  pattern = '*',
  callback = function()
    vim.opt.cursorline = not vim.opt.cursorline:get()
  end,
})

-- =======================
-- PLUGIN CONFIGS
-- =======================

vim.g.ackprg = 'ag --vimgrep --smart-case --ignore mocks'
vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules --ignore build --ignore vendor -g ""'


vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHidden = 1

vim.g.smoothie_speed_exponentiation_factor = 1.1

