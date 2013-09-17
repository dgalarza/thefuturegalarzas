module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-haml'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    compass:
      dev:
        options:
          sassDir: 'sass'
          cssDir: 'css'

    haml:
      dev:
        files: 'index.html': 'index.haml'

    coffee:
      dev:
        files:
          'scripts/application.js': 'scripts/application.coffee'

    connect:
      dev:
        options:
          port: '3000'
          base: '.'
          hostname: '*'

    watch:
      sass:
        files: 'sass/*'
        tasks: ['compass:dev']
      haml:
        files: '*.haml'
        tasks: ['haml:dev']
      coffee:
        files: 'scripts/*.coffee'
        tasks: ['coffee:dev']

  grunt.registerTask 'default', ['compass:dev', 'haml:dev', 'coffee:dev']

  grunt.registerTask 'dev', ['default', 'connect:dev', 'watch']
