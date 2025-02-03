vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set space key to leader
vim.g.mapleader = " "

-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- autoclose
Plug 'm4xshen/autoclose.nvim'

-- transparent
Plug('xiyaowong/transparent.nvim')

-- themes
Plug 'sunjon/stylish.nvim'
Plug('folke/tokyonight.nvim')

-- tree
Plug('nvim-tree/nvim-tree.lua')

-- parser/LSP/fuzzy finder
Plug('neovim/nvim-lspconfig')
Plug('p00f/clangd_extensions.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.8'})
Plug('nvim-lua/plenary.nvim')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug('hrsh7th/nvim-cmp')

vim.call('plug#end')


-- Preferences
vim.wo.relativenumber = true
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
-- autoclose
require'autoclose'.setup ({})
-- Treesitter and Treesitter context

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

require'nvim-tree'.setup()

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
    root_dir = lspconfig.util.root_pattern('compile_flags.txt', '.git', 'CMakeLists.txt'),
    on_attach = on_attach,
    flags = lsp_flags,
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Screen splitting keymaps

-- default split
vim.keymap.set("n", "<leader>s", function()
        vim.cmd("vsplit")
        end, {})
-- vertical split
vim.keymap.set("n", "<leader>sv", function()
        vim.cmd("vsplit")
        end, {})
-- horizontal split
vim.keymap.set("n", "<leader>sh", function()
        vim.cmd("split")
        end, {})
-- vertical split with explorer
vim.keymap.set("n", "<leader>se", function()
        vim.cmd("vsplit")
        builtin.find_files()
        end, {})
-- vertical split with terminal
vim.keymap.set("n", "<leader>tm", function()
        vim.cmd("vsplit")
        vim.cmd("terminal")
        end, {})

-- Buffer focus keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {})

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

--vim.cmd("vert belowright sb 1")
--vim.cmd("terminal")
