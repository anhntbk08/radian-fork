module.exports = (grunt) ->
  _ = require 'lodash'

  grunt.config 'watch',
    coffee:
      files: [
        'assets/coffee/**/*.coffee'
      ]
      tasks: [
        'coffeelint'
        'coffee:dev'
      ]
      options:
        livereload: true
        spawn: false
    compass:
      files: [
        '<%= compass.devSASS.options.sassDir %>/**/*.sass']
      tasks: [
        
        'compass:devSASS']
    css:
      files: [
        'assets/css/*.css'
        'assets/img/*.{gif,png,svg}'
        'assets/img/**/*.jpg'
      ]
      options:
        livereload: true
    js:
      files: [
        'assets/js/**/*.js'
      ]
      tasks: [
        'jshint'
        'jscs'
      ]
      options:
        livereload: true
        spawn: false
    html:
      files: [
        'assets/partial/**/*.html'
        '*.html'
      ]
      options:
        livereload: true
    sprite:
      files: [
        'assets/img/**/*.png'
      ]
      tasks: [
        'sprite'
      ]
    

  changedFiles = {}
  onChange = _.debounce () ->
    changedCoffeeFiles = changedFiles['coffee']
    changedJSFiles = changedFiles['js']

    if changedCoffeeFiles
      grunt.config 'coffeelint.all', changedCoffeeFiles
      grunt.config 'coffee.dev.src', _.map changedCoffeeFiles, (file) ->
        file.replace 'assets/coffee/', ''
    if changedJSFiles
      grunt.config 'jshint.all', changedJSFiles
      grunt.config 'jscs.src', changedJSFiles
    
    changedFiles = {}
  , 200

  grunt.event.on 'watch', (action, file) ->
    ext = file.split('.').pop()

    if !changedFiles[ext]
      changedFiles[ext] = []

    changedFiles[ext].push file

    onChange()

  grunt.loadNpmTasks 'grunt-contrib-watch'
