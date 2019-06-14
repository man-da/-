var gulp = require('gulp'),
    sass = require('gulp-sass'),
    uglify = require('gulp-uglify'),
    cssMinify = require('gulp-clean-css'),
    concat = require('gulp-concat'),
    rename = require('gulp-rename'),
    header = require('gulp-header'),
    // eslint = require('gulp-eslint'),
    notify = require('gulp-notify');
/**
 * sass 编译
 */
function swallowError(error) {
    // If you want details of the error in the console
    console.error(error.toString());
    this.emit('end')
}
/**
 * eslint
 */
gulp.task('jslint',function(){
    return gulp.src(['./js/*.js']) //指定的校验路径
        .pipe(eslint({configFle:"./.eslintrc"})) //使用你的eslint校验文件
        .pipe(eslint.format())
});

/* 后台公用模板样式 */
gulp.task('mainSass', function () {
    return gulp.src('./sass/main.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(cssMinify({compatibility: "ie9"}))
        .pipe(concat('squirrel.min.css'))
        .pipe(header('/**\n * <%= file.relative %>\n * build at: <%= new Date() %>\n */\n'))
        .pipe(gulp.dest('./css'))
        .pipe(notify({ message: 'mainSass task complete' }));
});
gulp.task('sass-w',function () {
    gulp.watch('./sass/*.scss', ['mainSass']);
});

