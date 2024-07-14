return {
  'laytan/cloak.nvim',
  opts = {
    patterns = {
      -- { file_pattern = { '*.yml', '*.yaml' }, cloak_pattern = { ':.+', '-.+' } },
      {
        cloak_pattern = {
          '(api.*):.+',
          '(key.*):.+',
          '(pass.*):.+',
          '(secret.*):.+',
          '(token.*):.+',
        },
        file_pattern = {
          '*config*.yaml',
          '*settings*.yaml',
        },
        replace = '%1: ',
      },
      { file_pattern = '.env*', cloak_pattern = '=.+' },
    },
  },
}
