/*counter stepper function starts from here*/
$(document).ready(function(){
	var opts = {
		'counter-steper': {},
	};
	for (var n in opts)
		$("."+n).spinner(opts[n]);
	$("button").click(function(e){
		var ns = $(this).attr('class').match(/(s\d)\-(\w+)$/);
		if (ns != null)
			$('.'+ns[1]).spinner( (ns[2] == 'create') ? opts[ns[1]] : ns[2]);
	});
});
/*counter stepper function starts from here*/
