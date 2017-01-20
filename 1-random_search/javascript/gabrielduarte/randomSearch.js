var array = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5];

function randomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomSearch(array, iteration) {
	var lowest = null;
	var maxIndex = array.length - 1;

	for (var i = 0; i < iteration; i++) {
		var randomIndex = randomInt(0, maxIndex);
		lowest = ((array[randomIndex] < lowest) || (lowest == null)) ? array[randomIndex] : lowest;

		// Demo on HTML page
		document.body.innerHTML += ('<p>' + lowest + '</p>');
	}

	// Show answer on Demo HTML page
	document.body.innerHTML += ('<p style="color:blue;">Final: ' + lowest + '</p>');
	return lowest;
}

randomSearch(array, 5);