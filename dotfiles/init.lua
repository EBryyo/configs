vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set space key to leader
vim.g.mapleader = " "

-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('alec-gibson/nvim-tetris')

Plug('nvim-tree/nvim-tree.lua')

Plug('nvim-treesitter/nvim-treesitter')

Plug('neovim/nvim-lspconfig')

Plug('nvim-treesitter/nvim-treesitter-context')

Plug('p00f/clangd_extensions.nvim')

Plug('nvim-telescope/telescope.nvim', {tag = '0.1.8'})

Plug('nvim-lua/plenary.nvim')

Plug('folke/tokyonight.nvim')

vim.call('plug#end')


-- Preferences
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showmode = false
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
vim.opt.cindent = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.autoindent = true
vim.opt.ruler = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.cc = "81"
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "~" }
vim.opt.expandtab = true 

-- Theme
vim.cmd.colorscheme("tokyonight-night")

-- PLUGINS
require'alec-gibson/nvim-tetris'.setup()

-- Treesitter and Treesitter context
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "java", "sql"},
    -- Install parsers synchronously (only applied to ensure_installed)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have tree-sitter CLI installed locally
    auto_install = false,
    -- List of parsers to ignore installing (or "all")
    ignore_install = { },
    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
    highlight = {
    enable = false,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the tex filetype, you need to include latex in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
        return true
        end
    end,
    -- Setting this to true will run :h syntax and tree-sitter at the same time.
    -- Set this to true if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
},
}

require'nvim-tree'.setup()

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- LSP
-- Mappings.
-- See :help vim.diagnostic.* for documentation on any of the below functions

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See :help vim.lsp.* for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    vim.keymap.set('n', '<leader>h', function() vim.cmd [[ClangdSwitchSourceHeader]] end, bufopts)

    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
    --vim.api.nvim_create_autocmd({"TextChanged", "InsertLeave", "BufEnter"}, {callback = require("clangd_extensions.inlay_hints").set_inlay_hints})

    local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

    vim.keymap.set("n", "<leader>lh", function()
        if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
            vim.api.nvim_create_autocmd("InsertEnter", { group = group, buffer = buf,
            callback = require("clangd_extensions.inlay_hints").disable_inlay_hints
        })
        vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, { group = group, buffer = buf,
            callback = require("clangd_extensions.inlay_hints").set_inlay_hints
        })
        else
            vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
        end
        end, { buffer = buf, desc = "[l]sp [h]ints toggle" })
    end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local lspconfig = require("lspconfig")
require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Screen splitting keymaps
vim.keymap.set("n", "<leader>s", function()
        vim.cmd("vert belowright sb 1")
        end, {})

vim.keymap.set("n", "<leader>se", function()
        vim.cmd("vert belowright sb 1")
        builtin.find_files()
        end, {})

vim.keymap.set("n", "<leader>tm", function()
        vim.cmd("vert belowright sb 1")
        vim.cmd("terminal")
        end, {})

-- Buffer focus keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal exit keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {})

-- NvimTree keymap
vim.keymap.set("n", "<leader>t", function()
        vim.cmd("NvimTreeToggle")
        end, {})

-- Formatting
vim.api.nvim_create_autocmd("BufWritePre", {callback = function()
        if #vim.lsp.get_active_clients({bufnr = 0}) > 0 then
        vim.lsp.buf.format({async=false})
        end
        end})

-- Text highlighting on yank
vim.api.nvim_create_autocmd("TextYankPost", {callback = function()
        vim.highlight.on_yank({higroup='IncSearch', timeout=300})
        end})
