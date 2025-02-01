require("vimrieder.set")
require("vimrieder.remap")
require("vimrieder.packer")

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- vim.opt.guifont = { "DejaVu Sans Mono", "h12" }
vim.opt.guifont = { "Go Mono Nerd Font Complete Mono", "h12" }

require("symbols-outline").setup()

-- setup codecomaption with anthropic
--[[
require("codecompanion").setup({
  strategies = {
    chat = {
      --adapter = "anthropic",
      adapter = "ollama",
    },
    inline = {
      -- adapter = "anthropic",
      adapter = "ollama",
    }
  },
  ollama = function()
    return require("codecompanion.adapters").extend("ollama", {
        env = {
          url  = "http://localhost:31480",
   	   }
 })
 end,
})
]]--

require("codecompanion").setup({
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        env = {
          url = "http://localhost:31480",
          --api_key = "",
        },
        --[[ headers = {
          ["Content-Type"] = "application/json",
          ["Authorization"] = "Bearer ${api_key}",
        },
        ]]--
        parameters = {
          sync = true,
        },
      })
    end,
  },
})
