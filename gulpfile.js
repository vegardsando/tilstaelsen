/*!
 * gulp
 * $ npm install gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-jshint gulp-concat gulp-uglify gulp-imagemin gulp-notify gulp-rename gulp-livereload gulp-cache del --save-dev
 */

"use strict";

var gulp			= require("gulp"),
	fs 				= require("fs"),
	colors			= require("chalk"),
	browserSync		= require("browser-sync"),
	del				= require("del"),
	ncu 			= require('npm-check-updates'),
	loadPlugins 	= require('gulp-load-plugins')({DEBUG: false});

// Directories
var START 	= startfolders(["www","public","public_html"]),
	SRC 	= START + "/static",
	DIST 	= START + "/dist",
	REV		= START + "/.REV";

// sjekk om .key og .crt eksisterer, da blir Browsersync lagt til med ssl
var sslBrowserSync = false,
	sslCredentials = checkCredentials(["/Users/bruker1/mamp_ssl/craft.dev.key"]);

// Files that shoild be moved
var MOVE = {
	"fonts"	: [ SRC + "/fonts/**"],
	"php"	: [ SRC + "/php/**", "!" + SRC + "/php/admin/*"],
	"js/vendor": [ SRC + "/js/vendor/**"],
	"css/vendor": [ SRC + "/css/vendor/**"]
};

// Images that should be prosessed
var IMAGES = {
	"img" : [ SRC + "/img/*"]
};

// JS files we"ll be using
var JS = {
	"main" 	: [ SRC + "/js/_inc/*.js", SRC + "/js/main.js"],
	"initial" 	: [ SRC + "/js/initial.js"]
};

// CSS files we"ll be using
var CSS = {
	"main"	: [ SRC + "/css/main.scss"],
	"initial"	: [ SRC + "/css/initial.scss"]
};


// Styles
var css_running = false;
gulp.task("css", function(done) {
	var size = Object.size(CSS),
		counter = size;
	if (size === 0) { done(); }
	css_running = true;

	for (var key in CSS) {
		gulp.src(CSS[key])
			.pipe(loadPlugins.plumber({ errorHandler: onError }))
			.pipe(loadPlugins.sass({outputStyle: "compressed"}))
			.pipe(loadPlugins.combineMq({beautify: false}))
			//.pipe(loadPlugins.less())
			.pipe(loadPlugins.rename(key+".css"))
			.pipe(loadPlugins.autoprefixer("last 2 version", "safari 5", "e i9", "opera 12.1", "ios 6", "android 4"))
			//.pipe(gulp.dest(REV + "/css"))
			.pipe(loadPlugins.cssnano())
			//.pipe(loadPlugins.rename({ suffix: ".min" }))
			.pipe(gulp.dest(REV + "/css"))
			.on('end', function() {
				counter--;
				if (size > 1) loadPlugins.util.log(colors.blue("css") + colors.magenta(" (" + (size - counter) +"/"+size+")") + " ferdig");
				if (counter === 0) {
					done();
					css_running = false;
					gulp.start("rev");
				}
			});
	}

});

// Scripts
var scripts_running = false;
gulp.task("scripts", function(done) {
	var size = Object.size(JS),
		counter = size;
	if (size === 0) { done(); }
	scripts_running = true;

	for (var key in JS) {
		gulp.src(JS[key])
			.pipe(loadPlugins.plumber({ errorHandler: onError }))
			.pipe(loadPlugins.concat(key+".js"))
			//.pipe(gulp.dest(DIST + "/js"))
			.pipe(loadPlugins.uglify())
			//.pipe(rename({ suffix: ".min" }))
			.pipe(gulp.dest(REV+ "/js"))
			.on('end', function() {
				counter--;
				if (size > 1) loadPlugins.util.log(colors.blue("scripts") + colors.magenta(" (" + (size - counter) +"/"+size+")") + " ferdig");
				if (counter === 0) {
					done();
					scripts_running = false;
					gulp.start("rev");
				}
			});
	}

});

// Make faveicons
var FAVICON_DATA_FILE = START+'/favicon/faviconData.json';

gulp.task('favicon', function(done) {
	if (fs.existsSync(START +'/favicon.png')) {
		var bgColor = '#ffffff';
		loadPlugins.realFavicon.generateFavicon({
			masterPicture: START +'/favicon.png',
			dest: START+'/favicon',
			iconsPath: '/favicon',
			design: {
				ios: {
					pictureAspect: 'noChange'
				},
				desktopBrowser: {},
				windows: {
					pictureAspect: 'noChange',
					backgroundColor: bgColor,
					onConflict: 'override'
				},
				androidChrome: {
					pictureAspect: 'noChange',
					themeColor: bgColor,
					manifest: {
						name: 'Renholdsportalen',
						display: 'browser',
						orientation: 'notSet',
						onConflict: 'override',
						declared: true
					}
				},
				safariPinnedTab: {
					pictureAspect: 'blackAndWhite',
					threshold: 50,
					themeColor: bgColor
				}
			},
			settings: {
				compression: 1,
				scalingAlgorithm: 'Mitchell',
				errorOnImageTooSmall: false
			},
			markupFile: FAVICON_DATA_FILE
		}, function() {
			gulp.start(["check-for-favicon-update", "inject-favicon-markups"]);
			gulp.src(START + '/favicon/favicon.ico')
				.pipe(loadPlugins.plumber({ errorHandler: onError }))
				.pipe(gulp.dest(START));

			done();
		});
	} else {
		loadPlugins.util.log("\t"+ colors.red('favicon.png mangler i '+START+' mappen. Bør være 260 x 260'));
		done();
	}
});

// Images
gulp.task("images", function(done) {
	var size = Object.size(IMAGES);
	if (size === 0) { done(); }
	for (var key in IMAGES) {

		gulp.src(IMAGES[key])
			.pipe(loadPlugins.plumber({ errorHandler: onError }))
            .pipe(loadPlugins.imagemin([
				loadPlugins.imagemin.gifsicle({interlaced: true}),
				loadPlugins.imagemin.jpegtran({progressive: true}),
				loadPlugins.imagemin.optipng({optimizationLevel: 7}),
				loadPlugins.imagemin.svgo({plugins: [{removeViewBox: false}]})
			]))
			.pipe(gulp.dest(DIST + "/"+key+"/"))
			.on('end', function() {
				size--;
				if (size === 0) {done(); }
			});
	}
});

// Svg-symbols
gulp.task("svg-symbols", function () {
	return gulp.src(SRC + "/svg/symbols/*.{svg,svgz}")
		.pipe(loadPlugins.plumber({ errorHandler: onError }))
		.pipe(loadPlugins.svgmin())
		.pipe(loadPlugins.svgSymbols({templates: ['default-svg']}))
		.pipe(gulp.dest(DIST + "/svg"));
});

// Svg
gulp.task("svg", function () {
	return gulp.src([SRC + "/svg/**/*.{svg,svgz}", "!" + SRC + "/svg/symbols/*"])
		.pipe(loadPlugins.plumber({ errorHandler: onError }))
		.pipe(loadPlugins.svgmin())
		.pipe(gulp.dest(DIST + "/svg"));
});

// Clean
gulp.task("clean", function() {
	//loadPlugins.cache.clearAll();

	return del([DIST, REV]).then(function (paths) {
		if (paths.length) {
			loadPlugins.util.log("");
			loadPlugins.util.log("===================================== Deleted files/folders! =====================================");
			for (var path in paths) {
				loadPlugins.util.log("\t"+paths[path]);
			}
			loadPlugins.util.log("--------------------------------------------------------------------------------------------------");
			loadPlugins.util.log("");
		}
	});
});

// Move files
gulp.task("moveFiles", function(done) {
	var size = Object.size(MOVE);
	if (size === 0) { done(); }

	for (var key in MOVE) {
		gulp.src(MOVE[key])
			.pipe(loadPlugins.plumber({ errorHandler: onError }))
			.pipe(gulp.dest(DIST + "/"+key+"/"))
			.on('end', function() {
				size--;
				if (size === 0) {done(); }
			});
	}
});

// Add rev to files
gulp.task("rev", function() {
	if (!css_running && !scripts_running) {
		if (del([DIST+"/js/*", "!" + DIST + "/js/vendor", DIST+"/css/*", "!" + DIST + "/css/vendor"])) {
			return gulp.src(REV+'/**/*.{js,css}')
			.pipe(loadPlugins.plumber({ errorHandler: onError }))
			//.pipe(gulp.dest(DIST))
			.pipe(loadPlugins.rev())
			.pipe(gulp.dest(DIST))
			.pipe(browserSync.stream())
			.pipe(loadPlugins.rev.manifest("cachebust.json", {
				//merge: true
			}))
			.pipe(gulp.dest("./"));
		}
	} else {
		return false;
	}
});


// Add adminfiles
gulp.task("admin", function(done) {
	var size = 2;
	gulp.src(SRC +'/php/admin/admin.js')
		.pipe(loadPlugins.plumber({ errorHandler: onError }))
		.pipe(loadPlugins.uglify())
		.pipe(loadPlugins.rename("admin.min.js"))
		.pipe(gulp.dest(DIST + "/admin"))
		.on('end', function() {
			size--;
			if (size === 0) {done(); }
		});

	gulp.src(SRC +'/php/admin/admin.scss')
		.pipe(loadPlugins.plumber({ errorHandler: onError }))
		.pipe(loadPlugins.sass({outputStyle: "compressed"}))
		.pipe(loadPlugins.autoprefixer("last 2 version", "safari 5", "e i9", "opera 12.1", "ios 6", "android 4"))
		.pipe(loadPlugins.cssnano({discardComments: {removeAll: true}, zindex: false}))
		.pipe(loadPlugins.rename("admin.min.css"))
		.pipe(gulp.dest(DIST + "/admin"))
		.on('end', function() {
			size--;
			if (size === 0) {done(); }
		});
});

// Watch
gulp.task("watch", function() {

	// Watch .scss files
	gulp.watch([SRC + "/css/**/*.scss"], ["css"]);

	// Watch .js files
	gulp.watch([SRC + "/js/**/*.js"], ["scripts"]);

	// Watch moving files
	var MOVEARRAY = [];
	for (var key in MOVE) { MOVEARRAY = MOVEARRAY.concat(MOVE[key]); }
	gulp.watch(MOVEARRAY, ["moveFiles"]);

	// Watch image files
	gulp.watch(SRC + "/img/**/*.{gif,png,jpeg,jpg}", ["images"]);

	// Watch svg files
	gulp.watch(SRC + "/svg/**/*.{svg,svgz}", ["svg-symbols", "svg"]);

	gulp.watch(["templates/**/*.{html,twig}", "{www,public}/*.{html,php}"]).on("change", browserSync.reload);

	// Watch favicon files
	gulp.watch(START+'/favicon.png', ["favicon"]);

	// Watch admin files
	gulp.watch(SRC + "/php/admin/*.{js,scss}", ["admin"]);
});

gulp.task("browser-sync", ["admin", "css", "scripts", "moveFiles", "images", "svg", "svg-symbols", "watch"], function() {

	return browserSync({
		logSnippet: false,
		https: sslCredentials,
		logPrefix: "Browser Sync"
	});
});

// Default task
gulp.task("default", function() {
	gulp.start("browser-sync");
});

gulp.task("cleanstart", ['clean'] , function() {
	gulp.start("default");
});

// Sjekk etter nye oppgraderinger til gulp
ncu.run({
	packageFile: 'package.json',
	// Any command-line option can be specified here.
	// These are set by default:
	// silent: true,
	// jsonUpgraded: true
	}).then(function(upgraded) {
		var size = 0, key;
	    for (key in upgraded) {
	        if (upgraded.hasOwnProperty(key)) size++;
	    }
		if (size) {
			loadPlugins.util.log("======================================= Gulp dependencies ========================================");
			for (var key in upgraded) {
				loadPlugins.util.log("\t"+ colors.red(upgraded[key]) +"\t" + key);
			}
			loadPlugins.util.log("--------------------------------------------------------------------------------------------------");
			loadPlugins.util.log("\t Run "+colors.blue("npm update")+" to upgrade without updating package.json");
			loadPlugins.util.log("\t Run "+colors.blue("ncu -u")+" to upgrade package.json");
			loadPlugins.util.log("\t Run "+colors.blue("ncu -a")+" to upgrade package.json too latest versions");
			loadPlugins.util.log("--------------------------------------------------------------------------------------------------");
		} else {
			loadPlugins.util.log(colors.blue("All dependencies are upgradeed :)"));
		}
});

function startfolders(startfolders) {
	var i = 0;
	while (startfolders[i]) {
		if( fs.existsSync(startfolders[i])){
			return startfolders[i];
			break;
		}
		i++;
	}
}

function checkCredentials(sslFile) {
	if(!sslBrowserSync) { return false; }

	var i = 0;
	while (sslFile[i]) {
		sslFile[i] = sslFile[i].replace(".key", "").replace(".crt", "");
		if(fs.existsSync(sslFile[i]+".key") && fs.existsSync(sslFile[i]+".crt")){
			var array = {
				key: sslFile[i]+".key",
				cert: sslFile[i]+".crt"
			};
			return array;
			break;
		}
		i++;
	}
	return false;
}

// error function for plumber
var onError = function (err) {
	loadPlugins.util.beep();
	loadPlugins.util.log(colors.red("============================================= ERROR! ============================================="));
	loadPlugins.util.log(colors.red(err));
	loadPlugins.util.log(colors.red("--------------------------------------------------------------------------------------------------"));
	this.emit("end");
};

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

gulp.task('check-for-favicon-update', function(done) {
	var currentVersion = JSON.parse(fs.readFileSync(FAVICON_DATA_FILE)).version;
	loadPlugins.realFavicon.checkForUpdates(currentVersion, function(err) {
		if (err) {
			throw err;
		}
	});
});

gulp.task('inject-favicon-markups', function() {
	gulp.src('./templates/_admin/_favicon.html')
		.pipe(loadPlugins.realFavicon.injectFaviconMarkups(JSON.parse(fs.readFileSync(FAVICON_DATA_FILE)).favicon.html_code))
		.pipe(gulp.dest('./templates/_admin/'));
});
