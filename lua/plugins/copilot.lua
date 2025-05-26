return {
  'zbirenbaum/copilot.lua',
  event = 'VeryLazy',
  opts = {
    filetypes = {
      env = false,
      ['*'] = true,
      ['.'] = true,
    },
    panel = {
      layout = {
        position = 'left',
      },
    },
  },
  should_attach = function(_, bufname)
    local logger = require('copilot.logger')

    logger.warn('copilot should_attach', bufname, string.match(bufname, 'securerc'))
    if string.match(bufname, 'env') then
      logger.warn('not attaching, buffer is /env/')
      return false
    end

    if string.match(bufname, 'securerc') then
      logger.warn('not attaching, buffer is /securerc/')
      return false
    end
  end,
}
