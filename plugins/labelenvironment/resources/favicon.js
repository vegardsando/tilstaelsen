function addFavicon() {
	var canvas = document.createElement('canvas'),
		ctx,
		img = document.createElement('img'),
		link = document.createElement('link'),
		low_env = window.environmentName.toLowerCase(),
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
			ctx.fillText(window.environmentName[0], 6, 16);
			link.href = canvas.toDataURL('image/png');
			document.getElementsByTagName('head')[0].appendChild(link);
		};

		img.onload = makeFav;
		img.src = '/favicon.ico';
	}
}
addFavicon();
