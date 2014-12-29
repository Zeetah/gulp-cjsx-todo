gulp          = require 'gulp'
gutil         = require 'gulp-util'
cjsx          = require 'gulp-cjsx'

gulp.task 'cjsx', ->
  gulp.src('./src/*.cjsx')
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./dist/'))