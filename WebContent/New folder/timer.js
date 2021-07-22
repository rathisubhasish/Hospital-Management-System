var counter = 0;
function setup(){
	noCanvas();
	
	var timer = select("#timer");
	timer.html("0");
	
	function timeIt(){
		counter++;
		timer.html(counter);
	}
	setInterval(timeIt,1000);
}