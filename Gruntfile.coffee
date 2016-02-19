module.exports = (grunt) ->

    # These plugins provide necessary tasks.
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-gh-pages'

    # Project configuration.
    grunt.initConfig
        coffee:
            compile:
                options:
                    bare: true
                files:[
                    cwd: "src",
                    src: "**/*.coffee",
                    dest: "src",
                    expand: true,
                    ext: ".js"]

        jade:
            compile:
                options:
                    data: (dest, src)->
                        return require('./src/content.json')
                files:[
                    cwd: "src/page",
                    src: "**/*.jade",
                    dest: "build/",
                    expand: true,
                    ext: ".html"]

        stylus:
            compile:
                files:
                    'build/asset/style.css': 'src/style/*.styl'

        copy:
            asset:
                expand: true
                cwd: 'src/asset/'
                src: '**/*'
                dest: 'build/asset/'

            config:
                src: 'src/CNAME'
                dest: 'build/CNAME'

        clean:
            files: ['build/**/*', '!build']

        watch:
            asset:
                files: 'src/asset/**/*'
                tasks: ['copy:asset']

            style:
                files: '**/*.styl'
                tasks: ['stylus']

            jade:
                files: ['**/*.jade','**/*.json']
                tasks: ['jade']

        'gh-pages':
            options:
                base: 'build'
            src: ['**']

        # Default task.
        grunt.registerTask 'default', ['jade','copy','stylus']
        grunt.registerTask 'build', ['jade','copy','stylus']
        grunt.registerTask 'rebuild', ['clean','build']
        grunt.registerTask 'publish', ['rebuild','gh-pages']
