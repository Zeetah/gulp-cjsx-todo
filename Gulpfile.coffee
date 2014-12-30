gulp          = require 'gulp'
gutil         = require 'gulp-util'
cjsx          = require 'gulp-cjsx'
browserify    = require 'gulp-browserify'
connect       = require 'gulp-connect'
clean         = require 'gulp-clean'
watch         = require 'gulp-watch'


gulp.task 'clean', ->
  gulp.src('dist/**/*', {read: false})
    .pipe(clean())

  gulp.src('tmp/**/*', {read: false})
    .pipe(clean())


gulp.task 'cjsx', ['clean'], ->
  gulp.src('./src/*.cjsx')
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./tmp/'))


gulp.task 'build', ->
  gulp.src('tmp/app.js')
    .pipe(browserify({
      insertGlobals: true
      debug: true
    }))
    .pipe(gulp.dest('./dist'))
    .pipe(connect.reload())


gulp.task 'copy-static', ['clean'], ->
  gulp.src('./index.html')
    .pipe(gulp.dest('./dist'))


gulp.task 'copy-libs', ['clean'], ->
  gulp.src('./bower_components/react/react.min.js')
    .pipe(gulp.dest('./dist/libs'))

  gulp.src('./bower_components/jquery/dist/jquery.min.js')
    .pipe(gulp.dest('./dist/libs'))

  gulp.src('./bower_components/lodash/dist/lodash.min.js')
    .pipe(gulp.dest('./dist/libs'))


gulp.task 'watch', ['default', 'connect'], ->
  gulp.src('src/**/*.cjsx')
    .pipe(watch('src/**/*.cjsx'))
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./tmp/'))
  
  gulp.watch('tmp/**/*', ['build'])

  gulp.src('./index.html')
    .pipe(watch('./index.html'))
    .pipe(gulp.dest('./dist'))
    .pipe(connect.reload())


gulp.task 'connect', ->
  connect
    .server
      root: 'dist'
      livereload: true


gulp.task 'default', ['cjsx', 'copy-static', 'copy-libs'], ->
  gulp.run('build')
