module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jst"

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffee:
      compile:
        options:
          join: true
        files:
          "assets/compiled/application.js": [
            "assets/javascripts/config/**/*.coffee",
            "assets/javascripts/app.coffee",
            "assets/javascripts/base/**/*.coffee",
            "assets/javascripts/components/**/*.coffee",
            "assets/javascripts/entities/**/*.coffee",
            "assets/javascripts/apps/**/*.coffee"
          ]

    jst:
      compile:
        options:
          processName: (path) ->
            # Remove "app/assets" from the JST keys.
            split = path.split("/")
            split.slice(2, split.length).join("/")
        files:
          "assets/compiled/templates.js": [ "assets/javascripts/**/*.html" ]

    less:
      compile:
        options: { cleancss: true }
        files:
          "assets/compiled/application.css": [ "assets/stylesheets/**/*.less" ]

    concat:
      javascripts:
        files:
          "public/application.js": [
            "vendor/javascripts/jquery-1.10.2.min.js",
            "vendor/javascripts/lodash.min.js",
            "vendor/javascripts/backbone-min.js",
            "vendor/javascripts/backbone.marionette.min.js",
            "assets/compiled/templates.js"
            "assets/compiled/application.js"
          ]

      stylesheets:
        files:
          "public/application.css": [
            "vendor/stylesheets/bootstrap.min.css",
            "vendor/stylesheets/font-awesome.min.css",
            "assets/compiled/application.css"
          ]

    watch:
      stylesheets:
        files: "assets/stylesheets/**/*"
        tasks: ["compile:stylesheets"]

      javascripts:
        files: "assets/javascripts/**/*.coffee"
        tasks: ["compile:javascripts"]

      templates:
        files: "assets/javascripts/**/*.html"
        tasks: ["compile:javascripts"]

      watch:
        files: "Gruntfile.coffee"
        tasks: ["default"]


  grunt.event.on "watch", (action, filepath, target) ->
    grunt.log.writeln("#{target}: #{filepath} has #{action}")

  grunt.registerTask "compile:javascripts", ["coffee:compile", "jst:compile", "concat:javascripts"]
  grunt.registerTask "compile:stylesheets", ["less:compile", "concat:stylesheets"]
  grunt.registerTask "default",             ["compile:javascripts", "compile:stylesheets"]
