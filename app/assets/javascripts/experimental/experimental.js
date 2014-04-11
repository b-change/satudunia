/*
	@module 		= 	experimental
	@created		=	May 27 2013
	@desc			=	this file includes all the js used in experimental module
*/

//= require jquery-ui
//= require jquery_ujs
//= require 'experimental/plugins'
//= require 'experimental/custom'
//= require 'experimental/customFunction'
//= require tabber.js
//= require vendor/chosen.jquery.min.js
//= require vendor/ajax-chosen.js
//= require vendor/jquery.textarea.js
//= require vendor/jHtmlArea.js
//= require app/modules/editor.js
//= require 'experimental/jquery.validate'
//= require 'experimental/jquery.tipsy'
//= require 'experimental/addthis_widget.js'
//= require 'experimental/turnsocialTooltip.js'
//= require 'jquery.autosize.js'
//= require 'jquery.autosize.min.js'
//= require 'experimental/mcVideoPlugin'
//= require 'experimental/js-image-slider'


if (navigator.userAgent.indexOf('Mac OS X') != -1) {
  jQuery("body").addClass("mac-os");
} else {
  jQuery("body").addClass("pc");
}
