/*
	@module 		= experimental
	@created		=	Jun 1 2013
	@desc			=	this file contains custom js functions of experimental module
*/

var Experimental = {
	getMainContent: function(contentVariable){
		// for making first character styled
			var firstCharacter = contentVariable.trim().substr(1);
			jQuery(".filter-content").html(firstCharacter); 
	},
	// getMainContentEnds here
	// making current tab active
	getActiveTab:function(paramAction,paramController){
		var paramVariable = (paramAction=="index")? paramController:paramAction;
		jQuery(document).ready(function($){
			$("."+paramVariable).addClass("current_page_parent");
		});

	},
	//event = event is the trigger to fire ajax i.e click,change e.t.c
	//actionId = through event will fire
	//url = url for ajax action
	//method = method of sending data
	//idToLoader = where you want to loade loader and data
	//nameOfPartial = partial name to show
	getAjaxData:function(event,actionId,url,method,idToLoader,nameOfPartial,loaderIdOrClass,subTabId,subTabPartial,pagination,data){
		jQuery(document).on(event,actionId,function(){
		var subTab = (subTabId.length==0)? "":"&subTabId="+subTabId+"&subTabPartial="+subTabPartial
		//variable value taker
		jQuery(loaderIdOrClass).addClass("ajax-loader");
		var valueTaker = (typeof(jQuery(this).attr("value"))=="undefined")? "" : jQuery(this).attr("value");
		var paginationVar = (pagination.length==0)? "&page=" : "&page="+valueTaker;
	
		if(valueTaker.length > 0){
			valueTaker = jQuery(".activity-filter").val();	
		}
		if(typeof(data)!=="undefined")
		{
			data ='&'+data
		}else{
			data ='&'
		}
		jQuery.ajax({
			type:method,
			url:url,
			data:"queryData="+valueTaker+"&idLoad="+idToLoader+"&nameOfPartial="+nameOfPartial+paginationVar+subTab + data,
			dataType:"script",
			error:function(errorObject){
				alert(errorObject.toSource());

			},
			success:function(successObject){
				jQuery(loaderIdOrClass).removeClass("ajax-loader");
				jQuery("#"+idToLoader).fadeIn('slow');
				//alert(successObject);
				//jQuery(classToShow).html(eval(successObject));
			}
		});
	});

	},
	getParentComment:function(eventIdOrClass){
		// function starts from here
		jQuery(eventIdOrClass).click(function(){
			var valueTaker = jQuery(this).attr("id");
			jQuery(this).parent(".reply-comment").find("span").slideDown("slow");
			jQuery(this).parent(".reply-comment").find("span > form > input:eq(0)").val(valueTaker);
		});
		// funtion ends to here
	}
	
}
