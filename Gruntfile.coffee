
module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      lib: 'lib'

    coffee:
      compile:
        expand: true
        cwd: 'src'
        src: '**/*.coffee'
        dest: 'lib'
        ext: '.js'

    watch:
      coffee:
        files: [ 'src/**/*.coffee' ]
        tasks: [ 'coffee' ]

    mochaTest:
      xunit:
        options:
          reporter: 'xunit'
          captureFile: 'spec.xml'
          require: [
            'coffee-script/register'
          ]
        src: ['spec/**/*.coffee']
      all:
        options:
          reporter: 'spec'
          require: [
            'coffee-script/register'
          ]
        src: ['spec/**/*.coffee']
      one:
        options:
          require: [
            'coffee-script/register'
          ]
        src: [ ]

  grunt.registerTask 'xunit', [ 'mochaTest:xunit' ]
  grunt.registerTask 'test', (name) ->
    switch name
      when undefined, 'all'
        grunt.task.run 'mochaTest:all'
      else
        if name.indexOf('/') isnt -1
          [ dirname, basename ] = name.split '/'
          path = "spec/#{dirname}/spec-#{basename}.coffee"
        else
          path = "spec/spec-#{name}.coffee"

        grunt.log.writeln "Testing #{path}"
        grunt.config.set 'mochaTest.one.src', [ path ]
        grunt.task.run [ 'mochaTest:one' ]

  grunt.registerTask 'compile', [ 'clean:lib', 'coffee' ]
  grunt.registerTask 'default', [ 'compile' ]
