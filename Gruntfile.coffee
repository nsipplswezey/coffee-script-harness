module.exports = ->
  @initConfig
    coffee:
      main:
        src: 'index.coffee'
        dest: 'build/index.js'

    watch:
      files: ['spec/*.coffee','index.coffee']
      tasks: ['test']

    cafemocha:
      nodejs:
        src: ['spec/*.coffee']
        options:
          reporter: 'spec'

    coffeelint:
      components: ['Gruntfile.coffee', 'spec/*.coffee', 'index.coffee']
      options:
        'max_line_length':
          'level': 'ignore'

  @loadNpmTasks 'grunt-contrib-coffee'
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-cafe-mocha'
  @loadNpmTasks 'grunt-coffeelint'

  @registerTask 'test', () =>
    @task.run 'coffeelint'
    @task.run 'coffee'
    @task.run 'cafemocha'
    return

  @registerTask 'default', ['test']
