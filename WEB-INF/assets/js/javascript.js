



document.getElementById("buyShare").addEventListener('change', function () {
	var buyPrice = document.getElementById("buyPrice").value;
	var buyShare = document.getElementById("buyShare").value;
	var fee = math.round(buyPrice*buyShare*0.01) / 100;
							
	document.getElementById("buyFee").value = fee;
});
						
document.getElementById("sellShare").addEventListener('change', function () {
	var sellPrice = document.getElementById("sellPrice").value;
	var sellShare = document.getElementById("sellShare").value;
	var fee = Math.round(sellPrice*sellShare*0.01) / 100;
	var tax = Math.round(sellPrice*sellShare*0.03) / 100;
							
	document.getElementById("sellFee").value = fee;
	document.getElementById("sellTax").value = tax;
});