var adminplacement = typeof adminplacement !== 'undefined' ? adminplacement : '';
var ENV = typeof ENV !== 'undefined' ? ENV : '';
var adminUser = typeof adminUser !== 'undefined' ? adminUser : false;
var manglerGA = typeof ga !== 'function' && typeof dataLayer === 'undefined' ? true : false;

visadminBar();

function visadminBar() {
	addStylesheet();
	addFavicon();
	adminBar();

	if (ENV != 'PROD') {
		addBrowserSync();
	} else {
		addTestDropdown();
	}

	if (adminUser) {
		console.log('%c You are an admin!', 'background: #f4b638; color: #222; font-weight: bold; padding: 5px; border-left: 3px solid #222;');
	}
}

function autoDBdump(force) {
	var force = typeof force !== 'undefined' ? '&force' : '';

	var r = new XMLHttpRequest();
	r.open("GET", "/static/php/admin/auto_db_dump.php?ENV="+ENV+force, true);
	r.onreadystatechange = function () {
		if (r.readyState != 4 || r.status != 200) return;
		json = JSON.parse(r.responseText);
		if (typeof json.html !== 'undefined') {
			id = "dump_"+(Math.random()*100);
			outer = document.createElement('div');
			outer.id = id;
			outer.innerHTML = json.html;
			document.body.appendChild(outer);
			setTimeout(function(){
				document.getElementById(id).remove();
			}, 3000);
		}
		if (typeof json.console  !== 'undefined') {
			if( json.code === 1) {
				var css = 'background: #1FBE7B; color: #fff;';
			} else if( json.code === 3) {
				var css = 'background: #e54545; color: #fff;';
			} else {
				var css = 'background: #e3e3e3; color: #222;';

			}
			console.info('%c' + json.console, css + 'padding: 5px; font-size: 10px; line-height: 20px;');
		}

		setTimeout(function(){
			autoDBdump();
		}, (5*60*1000));
	};
	r.send();
}

function adminBar() {
	document.body.innerHTML += '<div id="devmode" class="'+adminplacement+' '+ENV+'"><div id="devmode_adminbar"></div></div>';

	var r = new XMLHttpRequest();
	r.open("GET", "/static/php/admin/adminBar.php", true);
	r.onreadystatechange = function () {
		if (r.readyState != 4 || r.status != 200) return;
		autoDBdump();

		json = JSON.parse(r.responseText);
		if (typeof json.bar !== 'undefined') {
			document.getElementById('devmode_adminbar').innerHTML = '<button onclick="autoDBdump(true)" class="icon database" title="DB dump"></button>' + json.bar + document.getElementById('devmode_adminbar').innerHTML;
			addAssetsDownloadLink();
			addAdminLink();
		}
	};
	if (ENV != 'PROD') {
		r.send();
	} else {
		addAdminLink();
	}
}

var DeployRSSdiv = document.createElement("div");
DeployRSSdiv.id = "DeployRSS";
var DeployRSS_start = true;

function getDeployRSS($id) {
	if (!DeployRSS_start) return;
	document.body.appendChild(DeployRSSdiv);
	document.documentElement.className = document.documentElement.className.replace(/\b visDeployRSS\b/,'') + ' visDeployRSS';
	DeployRSSdiv.className = "vis";
	DeployRSS_start = false;
	document.getElementById("DeployRSS").innerHTML = "<div><center>Loading DeployHQ rss ...</center></div>";
	var r = new XMLHttpRequest();
	r.open("GET", "/static/php/admin/deployhq_rss.php?rss="+$id, true);
	r.onreadystatechange = function () {
		if (r.readyState != 4 || r.status != 200) return;
		DeployRSSdiv.innerHTML = r.responseText;
		DeployRSS_start = true;
	};
	r.send();
}

function closeDeployRSS() {
	DeployRSSdiv.className = "";
	DeployRSSdiv.innerHTML = "";
	document.documentElement.className = document.documentElement.className.replace(/\b visDeployRSS\b/,'');
}

function addStylesheet() {
	var head = document.getElementsByTagName('head')[0];
	var link = document.createElement('link');
	link.rel = 'stylesheet';
	link.href = '/dist/admin/admin.min.css?'+Date.now();
	head.appendChild(link);
}

function addFavicon() {
	var canvas = document.createElement('canvas'),
		ctx,
		img = document.createElement('img'),
		link = document.createElement('link'),
		low_env = ENV.toLowerCase(),
		farge = '#f4b638';

		link.rel = 'shortcut icon';
		link.type = 'image/png';
		link.sizes = '32x32';

	if (canvas.getContext) {

		var rels = document.querySelectorAll('[rel="icon"],[rel="shortcut icon"]');
		for (var i = 0; i < rels.length; ++i) {
			rels[i].rel = "#";
		}

		if (low_env === 'local') {
			farge = '#e54545';
		} else if (low_env === 'production' || low_env === 'prod') {
			farge = '#1fbe7b';
		}

		canvas.height = canvas.width = 32; // set the size
		ctx = canvas.getContext('2d');

		function makeFav() { // once the image has loaded
			ctx.drawImage(this, 6, 6, 26, 26);
			ctx.fillStyle = '#000';
			ctx.beginPath();
			ctx.globalAlpha=0.5;
			ctx.arc(13,13,11,0,2*Math.PI);
			ctx.fill();
			ctx.beginPath();
			ctx.fillStyle = farge;
			ctx.globalAlpha=1;
			ctx.arc(11,11,11,0,2*Math.PI);
			ctx.fill();
			ctx.font = '14px "helvetica", sans-serif';
			ctx.fillStyle = '#ffffff';
			ctx.fillText(ENV[0], 6, 16);
			link.href = canvas.toDataURL('image/png');
			document.getElementsByTagName('head')[0].appendChild(link);
		};

		img.onload = makeFav;
		img.src = '/favicon.ico';
	}
}

function sjekkGA () {
	if (ENV == 'PROD' && manglerGA) {
		console.log('%c Google Analytics mangler!', 'background: #e54545; color: #fff; padding: 5px;');
		document.getElementById('devmode_adminbar').innerHTML = '<span class="icon alert ga-mangler"> GA mangler</span>' + document.getElementById('devmode_adminbar').innerHTML;
	}
}

function addBrowserSync() {
	var script = document.createElement('script');
	script.async = true;
	script.setAttribute("id", "__bs_script__");
	script.src = '//HOST:3000/browser-sync/browser-sync-client.js'.replace("HOST", location.hostname);
	document.body.appendChild(script);
}

function addTestDropdown() {
	var home = location.protocol+'//'+location.hostname;
	var dropdown = document.createElement('div');
	dropdown.innerHTML = '<select name="Browsercheck" onchange="window.open( this.options[ this.selectedIndex ].value, \'_blank\')"><option disabled selected># Browsercheck</option><option value="https://developers.google.com/speed/pagespeed/insights/?url='+home+'">PageSpeed Insight</option><option value="https://gtmetrix.com/">GTmetrix</option><option value="http://www.webpagetest.org/">Webpagetest</option><option disabled ># SEO</option><option value="https://www.woorank.com/">Woorank</option><option value="http://realfavicongenerator.net/favicon_checker?site='+home+'&ignore_root_issues=on">Sjekk favicon</option></select>';
	document.getElementById('devmode_adminbar').appendChild(dropdown);
}

function addAdminLink() {
	var loggedIn = adminUser ? 'logged-in' : '';
	document.getElementById('devmode_adminbar').innerHTML = '<a href="/admin" target="_blank" class="icon login '+loggedIn+'" title="Admin '+ loggedIn +'"></a>' + document.getElementById('devmode_adminbar').innerHTML;
	sjekkGA();
}

function addAssetsDownloadLink() {
	if (!adminUser) { return; }
	document.getElementById('devmode_adminbar').innerHTML = '<a href="/dist/php/assets" target="_blank" class="icon assets" title="Last ned assets"></a>' + document.getElementById('devmode_adminbar').innerHTML;
}
