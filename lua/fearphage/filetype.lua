vim.filetype.add({
  filename = {
    ['Jenkinsfile'] = 'groovy',
  },

  pattern = {
    ['Dockerfile.*'] = 'dockerfile',
  },
})
