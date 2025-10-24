-- Install lazy if it is not already installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			{ 'j-hui/fidget.nvim', opts={} },
			'saghen/blink.cmp'
		},

		config = function()
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

			vim.diagnostic.config {
        		severity_sort = true,
        		float = { border = 'rounded', source = 'if_many' },
        		underline = { severity = vim.diagnostic.severity.ERROR },
        		signs = vim.g.have_nerd_font and {
        			text = {
        				[vim.diagnostic.severity.ERROR] = '󰅚 ',
        				[vim.diagnostic.severity.WARN] = '󰀪 ',
        				[vim.diagnostic.severity.INFO] = '󰋽 ',
        				[vim.diagnostic.severity.HINT] = '󰌶 ',
        			},
        		} or {},
        		virtual_text = {
        			source = 'if_many',
        			spacing = 2,
        			format = function(diagnostic)
        				local diagnostic_message = {
        					[vim.diagnostic.severity.ERROR] = diagnostic.message,
        					[vim.diagnostic.severity.WARN] = diagnostic.message,
        					[vim.diagnostic.severity.INFO] = diagnostic.message,
        					[vim.diagnostic.severity.HINT] = diagnostic.message,
        				}
        				return diagnostic_message[diagnostic.severity]
        			end,
        		},
	      	}

			local servers = {
				lua_ls = {
					settings = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},

				clangd = {},
				pyright = {},
				asm_lsp = {}
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
		    	ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
		    	automatic_installation = false,
		    	handlers = {
		    		function(server_name)
		    			local server = servers[server_name] or {}
		    			-- This handles overriding only values explicitly passed
		    			-- by the server configuration above. Useful when disabling
		    			-- certain features of an LSP (for example, turning off formatting for ts_ls)
		    			server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
		    			require('lspconfig')[server_name].setup(server)
		    		end,
		    	},
		    }
		end
	},

	{ 'SirVer/ultisnips', event = { 'InsertEnter' } },
	'lervag/vimtex'
})
