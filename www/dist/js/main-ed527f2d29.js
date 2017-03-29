!function(e,t){var n=t(e,e.document);e.lazySizes=n,"object"==typeof module&&module.exports&&(module.exports=n)}(window,function(e,t){"use strict";if(t.getElementsByClassName){var n,i=t.documentElement,a=e.Date,o=e.HTMLPictureElement,r="addEventListener",s="getAttribute",u=e[r],c=e.setTimeout,l=e.requestAnimationFrame||c,d=e.requestIdleCallback,f=/^picture$/i,m=["load","error","lazyincluded","_lazyloaded"],p={},y=Array.prototype.forEach,v=function(e,t){return p[t]||(p[t]=new RegExp("(\\s|^)"+t+"(\\s|$)")),p[t].test(e[s]("class")||"")&&p[t]},z=function(e,t){v(e,t)||e.setAttribute("class",(e[s]("class")||"").trim()+" "+t)},h=function(e,t){var n;(n=v(e,t))&&e.setAttribute("class",(e[s]("class")||"").replace(n," "))},g=function(e,t,n){var i=n?r:"removeEventListener";n&&g(e,t),m.forEach(function(n){e[i](n,t)})},b=function(e,n,i,a,o){var r=t.createEvent("CustomEvent");return r.initCustomEvent(n,!a,!o,i||{}),e.dispatchEvent(r),r},C=function(t,i){var a;!o&&(a=e.picturefill||n.pf)?a({reevaluate:!0,elements:[t]}):i&&i.src&&(t.src=i.src)},A=function(e,t){return(getComputedStyle(e,null)||{})[t]},w=function(e,t,i){for(i=i||e.offsetWidth;i<n.minSize&&t&&!e._lazysizesWidth;)i=t.offsetWidth,t=t.parentNode;return i},E=function(){var e,n,i=[],a=function(){var t;for(e=!0,n=!1;i.length;)t=i.shift(),t[0].apply(t[1],t[2]);e=!1};return function(o){e?o.apply(this,arguments):(i.push([o,this,arguments]),n||(n=!0,(t.hidden?c:l)(a)))}}(),F=function(e,t){return t?function(){E(e)}:function(){var t=this,n=arguments;E(function(){e.apply(t,n)})}},q=function(e){var t,n=0,i=125,o=999,r=o,s=function(){t=!1,n=a.now(),e()},u=d?function(){d(s,{timeout:r}),r!==o&&(r=o)}:F(function(){c(s)},!0);return function(e){var o;(e=e===!0)&&(r=66),t||(t=!0,o=i-(a.now()-n),0>o&&(o=0),e||9>o&&d?u():c(u,o))}},M=function(e){var t,n,i=99,o=function(){t=null,e()},r=function(){var e=a.now()-n;i>e?c(r,i-e):(d||o)(o)};return function(){n=a.now(),t||(t=c(r,i))}},N=function(){var o,l,d,m,p,w,N,x,R,_,$,B,S,T,W,D=/^img$/i,L=/^iframe$/i,O="onscroll"in e&&!/glebot/.test(navigator.userAgent),P=0,j=0,H=0,I=-1,Q=function(e){H--,e&&e.target&&g(e.target,Q),(!e||0>H||!e.target)&&(H=0)},G=function(e,n){var a,o=e,r="hidden"==A(t.body,"visibility")||"hidden"!=A(e,"visibility");for(R-=n,B+=n,_-=n,$+=n;r&&(o=o.offsetParent)&&o!=t.body&&o!=i;)r=(A(o,"opacity")||1)>0,r&&"visible"!=A(o,"overflow")&&(a=o.getBoundingClientRect(),r=$>a.left&&_<a.right&&B>a.top-1&&R<a.bottom+1);return r},J=function(){var e,a,r,u,c,f,m,y,v;if((p=n.loadMode)&&8>H&&(e=o.length)){a=0,I++,null==T&&("expand"in n||(n.expand=i.clientHeight>500?500:400),S=n.expand,T=S*n.expFactor),T>j&&1>H&&I>2&&p>2&&!t.hidden?(j=T,I=0):j=p>1&&I>1&&6>H?S:P;for(;e>a;a++)if(o[a]&&!o[a]._lazyRace)if(O)if((y=o[a][s]("data-expand"))&&(f=1*y)||(f=j),v!==f&&(N=innerWidth+f*W,x=innerHeight+f,m=-1*f,v=f),r=o[a].getBoundingClientRect(),(B=r.bottom)>=m&&(R=r.top)<=x&&($=r.right)>=m*W&&(_=r.left)<=N&&(B||$||_||R)&&(d&&3>H&&!y&&(3>p||4>I)||G(o[a],f))){if(te(o[a]),c=!0,H>9)break}else!c&&d&&!u&&4>H&&4>I&&p>2&&(l[0]||n.preloadAfterLoad)&&(l[0]||!y&&(B||$||_||R||"auto"!=o[a][s](n.sizesAttr)))&&(u=l[0]||o[a]);else te(o[a]);u&&!c&&te(u)}},K=q(J),U=function(e){z(e.target,n.loadedClass),h(e.target,n.loadingClass),g(e.target,X)},V=F(U),X=function(e){V({target:e.target})},Y=function(e,t){try{e.contentWindow.location.replace(t)}catch(n){e.src=t}},Z=function(e){var t,i,a=e[s](n.srcsetAttr);(t=n.customMedia[e[s]("data-media")||e[s]("media")])&&e.setAttribute("media",t),a&&e.setAttribute("srcset",a),t&&(i=e.parentNode,i.insertBefore(e.cloneNode(),e),i.removeChild(e))},ee=F(function(e,t,i,a,o){var r,u,l,d,p,v;(p=b(e,"lazybeforeunveil",t)).defaultPrevented||(a&&(i?z(e,n.autosizesClass):e.setAttribute("sizes",a)),u=e[s](n.srcsetAttr),r=e[s](n.srcAttr),o&&(l=e.parentNode,d=l&&f.test(l.nodeName||"")),v=t.firesLoad||"src"in e&&(u||r||d),p={target:e},v&&(g(e,Q,!0),clearTimeout(m),m=c(Q,2500),z(e,n.loadingClass),g(e,X,!0)),d&&y.call(l.getElementsByTagName("source"),Z),u?e.setAttribute("srcset",u):r&&!d&&(L.test(e.nodeName)?Y(e,r):e.src=r),(u||d)&&C(e,{src:r})),E(function(){e._lazyRace&&delete e._lazyRace,h(e,n.lazyClass),(!v||e.complete)&&(v?Q(p):H--,U(p))})}),te=function(e){var t,i=D.test(e.nodeName),a=i&&(e[s](n.sizesAttr)||e[s]("sizes")),o="auto"==a;(!o&&d||!i||!e.src&&!e.srcset||e.complete||v(e,n.errorClass))&&(t=b(e,"lazyunveilread").detail,o&&k.updateElem(e,!0,e.offsetWidth),e._lazyRace=!0,H++,ee(e,t,o,a,i))},ne=function(){if(!d){if(a.now()-w<999)return void c(ne,999);var e=M(function(){n.loadMode=3,K()});d=!0,n.loadMode=3,K(),u("scroll",function(){3==n.loadMode&&(n.loadMode=2),e()},!0)}};return{_:function(){w=a.now(),o=t.getElementsByClassName(n.lazyClass),l=t.getElementsByClassName(n.lazyClass+" "+n.preloadClass),W=n.hFac,u("scroll",K,!0),u("resize",K,!0),e.MutationObserver?new MutationObserver(K).observe(i,{childList:!0,subtree:!0,attributes:!0}):(i[r]("DOMNodeInserted",K,!0),i[r]("DOMAttrModified",K,!0),setInterval(K,999)),u("hashchange",K,!0),["focus","mouseover","click","load","transitionend","animationend","webkitAnimationEnd"].forEach(function(e){t[r](e,K,!0)}),/d$|^c/.test(t.readyState)?ne():(u("load",ne),t[r]("DOMContentLoaded",K),c(ne,2e4)),K(o.length>0)},checkElems:K,unveil:te}}(),k=function(){var e,i=F(function(e,t,n,i){var a,o,r;if(e._lazysizesWidth=i,i+="px",e.setAttribute("sizes",i),f.test(t.nodeName||""))for(a=t.getElementsByTagName("source"),o=0,r=a.length;r>o;o++)a[o].setAttribute("sizes",i);n.detail.dataAttr||C(e,n.detail)}),a=function(e,t,n){var a,o=e.parentNode;o&&(n=w(e,o,n),a=b(e,"lazybeforesizes",{width:n,dataAttr:!!t}),a.defaultPrevented||(n=a.detail.width,n&&n!==e._lazysizesWidth&&i(e,o,a,n)))},o=function(){var t,n=e.length;if(n)for(t=0;n>t;t++)a(e[t])},r=M(o);return{_:function(){e=t.getElementsByClassName(n.autosizesClass),u("resize",r)},checkElems:r,updateElem:a}}(),x=function(){x.i||(x.i=!0,k._(),N._())};return function(){var t,i={lazyClass:"lazyload",loadedClass:"lazyloaded",loadingClass:"lazyloading",preloadClass:"lazypreload",errorClass:"lazyerror",autosizesClass:"lazyautosizes",srcAttr:"data-src",srcsetAttr:"data-srcset",sizesAttr:"data-sizes",minSize:40,customMedia:{},init:!0,expFactor:1.5,hFac:.8,loadMode:2};n=e.lazySizesConfig||e.lazysizesConfig||{};for(t in i)t in n||(n[t]=i[t]);e.lazySizesConfig=n,c(function(){n.init&&x()})}(),{cfg:n,autoSizer:k,loader:N,init:x,uP:C,aC:z,rC:h,hC:v,fire:b,gW:w,rAF:E}}}),!function(e){function t(t){function n(){function t(e,t,n){return!(!e&&!t)&&(console.warn(n),!0)}function n(){return!!c&&t(i,a,u)}var i=e.webkitRequestAnimationFrame,a=e.requestAnimationFrame,o=screen.width<=768,r=!(i&&a),s=!e.performance,u="setTimeout is being used as a substitiue forrequestAnimationFrame due to a bug within iOS 6 builds",c=r&&o&&s;return n()}function i(e){clearTimeout(e)}function a(e){var t=Date.now(),n=Math.max(v+16,t);return setTimeout(function(){e(v=n)},n-t)}function o(){return Array.prototype.filter?(l=e["request"+p]||e[m.filter(function(t){return void 0!==e[t+y]?t:void 0})+y]||a,n()?a:l):a}function r(){function t(t,n){for(var i;n<t.length;n++)if(e[t[n]]){i=e[t[n]];break}return i}var a=[];return Array.prototype.map?(m.map(function(e){return["Cancel","CancelRequest"].map(function(t){a.push(e+t+p)})}),d=e["cancel"+p]||t(a,0)||i,n()?i:d):i}function s(){return g?a:o()}function u(){return r()}function c(){g?(e.requestAnimationFrame=a,e.cancelAnimationFrame=i):(e.requestAnimationFrame=o(),e.cancelAnimationFrame=r())}var l,d,f,m=["moz","webkit"],p="AnimationFrame",y="Request"+p,v=0,z=e.mozRequestAnimationFrame,h=e.mozCancelAnimationFrame,g=z&&!h;switch(Date.now||(Date.now=function(){return(new Date).getTime()}),t){case"request":case"":f=s();break;case"cancel":f=u();break;case"native":c();break;default:throw new Error("RequestFrame parameter is not a type.")}return f}"object"==typeof module&&"object"==typeof module.exports?module.exports=exports=t:"function"==typeof define&&define.amd?define(function(){return t}):"object"==typeof e&&(e.requestFrame=t)}(window);var $m=jQuery;"function"==typeof svg4everybody&&svg4everybody(),"function"==typeof requestFrame&&requestFrame("native"),"function"==typeof FastClick&&FastClick.attach(document.body),function(){"use strict";function e(){o=r.width(),o<600?(u="phone",a!==u&&(t=n=!1,i=!0)):o<1025?(u="tablet",a!==u&&(t=i=!1,n=!0)):(u="desktop",a!==u&&(t=!0,n=i=!1)),a=u,c=!1}var t,n,i,a,o,r=($m(document.body),$m(window)),s=$m(document.documentElement),u=($m(document),Modernizr.touch||document.documentElement.hasOwnProperty("ontouchstart"),""),c=!1;e(),"function"==typeof runforceFeed&&runforceFeed(),window.onresize=function(){c||(requestAnimationFrame(e),c=!0)},s.addClass("lastet")}();