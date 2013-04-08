$(document).ready(function(){
  // on focus action
  var varValueTaker;
  $(".search-tag").focus(function(){
    varValueTaker = $(this).val();
    var varTakeAlt = $(this).attr("alt");
    if(varValueTaker==varTakeAlt){
      $("#search-container").fadeOut("slow");
      $(this).val("");
    }
  });
  // on blur action
  $(".search-tag").blur(function(){
    var varValueTakerBlur = $(this).val();
    var varTakeAlt = $(this).attr("alt");
    if(varValueTakerBlur==""){
      if(varValueTaker==varValueTaker)
        $(this).val(varTakeAlt);
        $("#search-container").fadeOut("slow");
    } 

  });
  // action runs at the time of key press
  $(".search-tag").keypress(function(){
    $("#search-container").fadeIn("slow");
    // set time out function to get exact search keyword
    setTimeout(function(){
      var ajaxValueData = $("#search-ajax").val();
      // ajax action
      $.ajax({
        method:"GET",
        data:"q="+ajaxValueData,
        url:"/search_ajax",
        success:function(successArray){
          var evalArray = eval(successArray);
          // if condition in case of null values
          if(evalArray.length != 0){
            var stringPassed='';
            var stringKeyId='';
            $.each(evalArray,function(key,value){
              $.each(evalArray[key],function(key1,value1){
                if(key1=="title")
                  stringPassed+="<span class='text-style-drop'><a href='javascript:void(0)' alt='"+evalArray[key]._id+"' class='my-drop'>"+value1+"</a></span></br>";
                if(key1=="_id")
                  stringKeyId+=value1+","
              });
            });
            $("#search-container").html(stringPassed);
            $("#hidden_keys").val(stringKeyId);
            $(this).bind("click");
          }
          // to show result not found
          else{
            $("#search-container").html("<span class='text-style-drop'>No result found!</span>");
          }
        }
      });
      // if condition for null ends here
    },400);
    
  });
  // event to select search result from the drop down
  $(".my-drop").live("click",function(){
    var valueTaker = $(this).html();
    $("#search-ajax").val(valueTaker);
    var altTagTaker = $(this).attr("alt");
    $("#hidden_keys").val(altTagTaker+",");
    $("#search-container").html("").fadeOut('fast','linear');
  });

});
