module.exports = (grunt) ->
  grunt.config 'express',
    all:
      options:
        cmd: 'coffee'
        script: './server.coffee'
        port: 8002

  grunt.loadNpmTasks 'grunt-express-server'