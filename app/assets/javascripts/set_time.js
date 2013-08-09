$(document).ready(function(){
	function aZ(numb) {
		if (numb < 10) {
			numb = "0" + numb
			return numb
		}
		return numb
	}
	time_to_send = document.getElementById("time_to_send")
	if (time_to_send) {
		date = new Date()
		yyyy = date.getYear() + 1900
		mm = date.getMonth() + 1
		mm = aZ(mm)
		dd = date.getDate()
		dd = aZ(dd)
		hh = date.getHours()
		hh = aZ(hh)
		min = date.getMinutes()
		min = aZ(min)
		form_date = yyyy + "-" + mm + "-" + dd + " " + hh + ":" + min
		time_to_send.value = form_date
	}
})