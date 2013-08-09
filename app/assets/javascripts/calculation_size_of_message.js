$(document).ready(function() {
	if ( $("#message").val() ){
		elem = $("#message").val()
		rest = 240 - elem.length
		$("#size_of_message").html(rest)
	}
	
	function maxLength(str, obj){
		if (str.length > 240) {
			str = str.substring(0,240)
			obj.value = str
		}
	}
	
	$("#message").keyup(function() {
		obj = this
		maxLength(obj.value, obj)
		rest = 240 - this.value.length
		$("#size_of_message").html(rest)
	})
	
	$(".msg_from_hr").click(function(event){
		rest = 240 - this.value.length
		$("#size_of_message").html(rest)
		$("#for_size_of_message").css("display", "block")
		$("#for_size_of_message").css("top", (event.pageY - 40) )
		$("#for_size_of_message").css("left", 564 )
	})
	$(".msg_from_hr").focusout(function(){
		$("#for_size_of_message").css("display", "none")
	})
	$(".msg_from_hr").keyup(function(){
		obj = this
		maxLength(obj.value, obj)
		rest = 240 - this.value.length
		$("#size_of_message").html(rest)
	})
})