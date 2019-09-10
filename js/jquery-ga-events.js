if (typeof jQuery != 'undefined') {
  jQuery(document).ready(function($) {
	var filetypes = /\.(zip|pdf|doc.*|xls.*|ppt.*|pps.*|csv)$/i;
	var baseHref = '';
	if (jQuery('base').attr('href') != undefined) baseHref = jQuery('base').attr('href');

	jQuery('a').on('click', function(event) {
	  var el = jQuery(this);
	  var track = true;
	  var href = (typeof(el.attr('href')) != 'undefined' ) ? el.attr('href') :"";
	  var isThisDomain = href.match(document.domain.split('.').reverse()[2] + '.' + document.domain.split('.').reverse()[1] + '.' + document.domain.split('.').reverse()[0]);
	  if (!href.match(/^javascript:/i)) {
		var elEv = []; elEv.value=0, elEv.non_i=false;
		if (href.match(/^mailto\:/i)) {
		  elEv.category = "email";
		  elEv.action = "click";
		  elEv.label = href.replace(/^mailto\:/i, '');
		  elEv.loc = href;
		}
		else if (href.match(filetypes)) {
		  var extension = (/[.]/.exec(href)) ? /[^.]+$/.exec(href) : undefined;
		  elEv.category = "documents";
		  if (extension[0] == "doc" || extension[0] == "docx") {
			elEv.action = "Word";
		  }
		  else if (extension[0] == "xls" || extension[0] == "xlsx") {
			elEv.action = "Excel";
		  }
		  else if (extension[0] == "ppt" || extension[0] == "pptx" || extension[0] == "pps" || extension[0] == "ppsx") {
			elEv.action = "PowerPoint";
		  }
		  else elEv.action = extension[0];
		  elEv.label = href.replace(/ /g,"-");
		  elEv.loc = baseHref + href;
		}
		else if (href.match(/^https?\:/i) && !isThisDomain) {
		  elEv.category = "external";
		  elEv.action = "click";
		  elEv.label = href.replace(/^https?\:\/\//i, '');
		  elEv.non_i = true;
		  elEv.loc = href;
		}
		else track = false;

		if (track) {
		  ga('send', 'event', elEv.category.toLowerCase(), elEv.action.toLowerCase(), elEv.label.toLowerCase(), elEv.value, elEv.non_i);
		  if ( el.attr('target') == undefined || el.attr('target').toLowerCase() != '_blank') {
			setTimeout(function() { location.href = elEv.loc; }, 400);
			return false;
	  }
	}
	  }
	});
  });
}