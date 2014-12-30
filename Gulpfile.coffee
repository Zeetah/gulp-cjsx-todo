gulp          = require 'gulp'
gutil         = require 'gulp-util'
cjsx          = require 'gulp-cjsx'
connect       = require 'gulp-connect'
clean         = require 'gulp-clean'
watch         = require 'gulp-watch'


gulp.task 'clean', ->
  gulp.src('dist', {read: false})
    .pipe(clean())


gulp.task 'cjsx', ->
  gulp.src('./src/*.cjsx')
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./dist/'))


gulp.task 'copy-static', ->
  gulp.src('./index.html')
    .pipe(gulp.dest('./dist'))


gulp.task 'copy-libs', ->
  gulp.src('./bower_components/react/react.min.js')
    .pipe(gulp.dest('./dist/libs'))


gulp.task 'watch', ['default', 'connect'], ->
  gulp.src('src/**/*.cjsx')
    .pipe(watch('src/**/*.cjsx'))
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./dist/'))
    .pipe(connect.reload())

  gulp.src('./index.html')
    .pipe(watch('./index.html'))
    .pipe(gulp.dest('./dist'))
    .pipe(connect.reload())


gulp.task 'connect', ->
  connect
    .server
      root: 'dist'
      livereload: true


gulp.task 'default', ['clean', 'copy-static', 'cjsx', 'copy-libs']
