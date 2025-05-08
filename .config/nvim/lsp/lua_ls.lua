return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          '?.lua',
          '?/init.lua',
          'lua/?.lua',
          'lua/?/init.lua',
          '?/lua/?.lua',
          '?/lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('data') .. '/lazy',
        }
      },
      telemetry = {
        enable = false
      }
    }
  }
}
