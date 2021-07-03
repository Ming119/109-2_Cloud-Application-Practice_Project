<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import='models.*, controllers.*, javax.servlet.http.*, java.util.*'%>

<!DOCTYPE html>

<html>
<%@ include file="WEB-INF/include/head.html"%>

<body class="bg-dark">
	<%@ include file="WEB-INF/include/navbar.jsp"%>

	<div class='container text-primary'>
		<div class='row'>
			<div class="col-1">
				<div class="dropdown">
					<button class="btn btn-dark dropdown-toggle" type="button"
						id="StockSymbol" data-bs-toggle="dropdown" aria-expanded="false">Stock</button>
					<ul class="dropdown-menu dropdown-menu-dark"
						aria-labelledby="dropdownMenuButton2">
						<li><h6 class="dropdown-header">Taiwan</h6></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">APWC</a></li>
						<li><a class="dropdown-item" href="#">CHT</a></li>
						<li><a class="dropdown-item" href="#">GIGM</a></li>
						<li><a class="dropdown-item" href="#"></a></li>
					</ul>
				</div>
			</div>

			<div class="col-1">
				<h3>
					<b>MSFT</b>
				</h3>
			</div>
			<div class="col-8">
				<h4>
					<b>43.2</b>
				</h4>
			</div>

			<!-- Button trigger modal -->
			<%
			if (user == null) {
					out.println("<a class='col-1 btn btn-success' type='button' href='Login'>BUY</a>");
					out.println("<a class='col-1 btn btn-danger' type='button' href='Login'>SELL</a>");
				} else {
					out.println(
							"<button type='button' class='col-1 btn btn-success' data-bs-toggle='modal'	data-bs-target='#BuyStock'>BUY</button>");
					out.println(
							"<button type='button' class='col-1 btn btn-danger' data-bs-toggle='modal' data-bs-target='#SellStock'>SELL</button>");
				}
			%>
		</div>


		<div id="controls row"
			style="width: 100%; margin-top: 2rem; margin-bottom: 2rem; overflow: hidden;">
			<div style="float: left; margin-left: 15px;">
				From: <input type="text" id="fromfield" class="amcharts-input" />
				To: <input type="text" id="tofield" class="amcharts-input" />
			</div>
			<div style="float: right; margin-right: 15px;">
				<button id="b1m" class="amcharts-input">1m</button>
				<button id="b3m" class="amcharts-input">3m</button>
				<button id="b6m" class="amcharts-input">6m</button>
				<button id="b1y" class="amcharts-input">1y</button>
				<button id="bytd" class="amcharts-input">YTD</button>
				<button id="bmax" class="amcharts-input">MAX</button>
			</div>
		</div>
		<div class='chartdiv row' style="height: 720px"></div>

	</div>


	<!-- Modal -->
	<div class="modal fade" id="BuyStock" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class='modal-dialog'>
			<div class="modal-content bg-dark text-white">

				<form Action="Buy" method="POST" onsubmit="return buyFromSubmit()">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">Buy Stock</h5>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<div class="input-group mb-3">
							<span class="input-group-text">Symbol</span><input type="text"
								class="form-control" value="MSFT" name="stock" id="buySymbol"
								readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Price</span> <span
								class="input-group-text">$</span><input type="text"
								class="form-control" value=43.2 name="price" id="buyPrice"
								readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Shares</span> <input type="number"
								value=1000 class="form-control" name="share" id="buyShare">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Fee</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" id='buyFee' name="fee" readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Tax</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" value=0 readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Total</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" id='buyTotal' name="total"
								readonly="readonly">
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<input type="submit" class="btn btn-success" value='Confirm'></input>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="SellStock" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class='modal-dialog'>
			<div class="modal-content bg-dark text-white">

				<form action='Sell' method='POST' onsubmit="return sellFromSubmit()">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">Sell Stock</h5>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<div class="input-group mb-3">
							<span class="input-group-text">Symbol</span><input type="text"
								class="form-control" value="MSFT" name="stock" id="sellSymbol"
								readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Price</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" value=43.2 id="sellPrice" name="price"
								readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Shares</span> <input type="number"
								value=1000 class="form-control" id="sellShare" name="share">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Fee</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" id="sellFee" name="fee" readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Tax</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" id="sellTax" name="tax" readonly="readonly">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">Total</span> <span
								class="input-group-text">$</span> <input type="text"
								class="form-control" id='sellTotal' name="total"
								readonly="readonly">
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<input type="submit" class="btn btn-success" value="Confirm"></input>
					</div>
				</form>

			</div>
		</div>
	</div>
	<!-- End of Modal -->

	<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/themes/dark.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

	<script type="text/javascript" charset="utf-8">
		var bPrice = document.getElementById("buyPrice").value;
		var bShare = document.getElementById("buyShare").value;
		var sPrice = document.getElementById("sellPrice").value;
		var sShare = document.getElementById("sellShare").value;
		var bFee = Math.round(bPrice * bShare * 0.14) / 100;
		var sFee = Math.round(sPrice * sShare * 0.14) / 100;
		var sTax = Math.round(sPrice * sShare * 0.3) / 100;

		document.getElementById("buyFee").value = bFee;
		document.getElementById("buyTotal").value = Math
				.round(((bPrice * bShare) + bFee) * 100) / 100;
		document.getElementById("sellFee").value = sFee;
		document.getElementById("sellTax").value = sTax;
		document.getElementById("sellTotal").value = Math
				.round(((sPrice * sShare) - sFee - sTax) * 100) / 100;

		document.getElementById("buyShare").addEventListener(
				'change',
				function() {
					var bPrice = document.getElementById("buyPrice").value;
					var bShare = document.getElementById("buyShare").value;
					var bFee = Math.round(bPrice * bShare * 0.14) / 100;

					document.getElementById("buyFee").value = bFee;
					document.getElementById("buyTotal").value = Math
							.round(((bPrice * bShare) + bFee) * 100) / 100;
				});

		document
				.getElementById("sellShare")
				.addEventListener(
						'change',
						function() {
							var sPrice = document.getElementById("sellPrice").value;
							var sShare = document.getElementById("sellShare").value;
							var sFee = Math.round(sPrice * sShare * 0.14) / 100;
							var sTax = Math.round(sPrice * sShare * 0.3) / 100;

							document.getElementById("sellFee").value = sFee;
							document.getElementById("sellTax").value = sTax;
							document.getElementById("sellTotal").value = Math
									.round(((sPrice * sShare) - sFee - sTax) * 100) / 100;
						});

		function buyFromSubmit() {
			var bTotal = document.getElementById("buyTotal").value;
			var points = parseFloat(document.getElementById("points").textContent);

			if (bTotal > points) {
				alert('Failed! Insufficient balance.\nYou have only ' + points
						+ ' in your balance.');
				return false;
			} else {
				return true;
			}
		};

		function sellFromSubmit() {
	<%int holdShare = 0;
			if (trades != null) {
				for (Trade t : trades)
					if (t.GetStock().equals("MSFT"))
						holdShare += t.GetShare();
			}%>
		var sShare = document.getElementById("sellShare").value;

			if (sShare >
	<%=holdShare%>
		) {
				alert('Failed! Insufficient stock holding.\nYou have only '
						+
	<%=holdShare%>
		+ ' shares.');
				return false;
			} else {
				return true;
			}
		};
	</script>

	<script>
		am4core.useTheme(am4themes_dark);
		am4core.useTheme(am4themes_animated);

		var chart = am4core.create("chartdiv", am4charts.XYChart);
		chart.padding(0, 15, 0, 15);

		// chart.dataSource.url = "WEB-INF/assets/Stock-GIGM.csv";
		chart.dataSource.url = "https://www.amcharts.com/wp-content/uploads/assets/stock/MSFT.csv"; // demo
		chart.dataSource.parser = new am4core.CSVParser();
		chart.dataSource.parser.options.useColumnNames = true;
		chart.dataSource.parser.options.reverse = true;

		// the following line makes value axes to be arranged vertically.
		chart.leftAxesContainer.layout = "vertical";

		// uncomment this line if you want to change order of axes
		//chart.bottomAxesContainer.reverseOrder = true;

		var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
		dateAxis.renderer.grid.template.location = 0;
		dateAxis.renderer.ticks.template.length = 8;
		dateAxis.renderer.ticks.template.strokeOpacity = 0.1;
		dateAxis.renderer.grid.template.disabled = true;
		dateAxis.renderer.ticks.template.disabled = false;
		dateAxis.renderer.ticks.template.strokeOpacity = 0.2;
		dateAxis.renderer.minLabelPosition = 0.01;
		dateAxis.renderer.maxLabelPosition = 0.99;
		dateAxis.keepSelection = true;
		dateAxis.minHeight = 30;

		dateAxis.groupData = true;
		dateAxis.minZoomCount = 5;

		// these two lines makes the axis to be initially zoomed-in
		// dateAxis.start = 0.7;
		// dateAxis.keepSelection = true;

		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.tooltip.disabled = true;
		valueAxis.zIndex = 1;
		valueAxis.renderer.baseGrid.disabled = true;
		// height of axis
		valueAxis.height = am4core.percent(65);

		valueAxis.renderer.gridContainer.background.fill = am4core
				.color("#000000");
		valueAxis.renderer.gridContainer.background.fillOpacity = 0.05;
		valueAxis.renderer.inside = true;
		valueAxis.renderer.labels.template.verticalCenter = "bottom";
		valueAxis.renderer.labels.template.padding(2, 2, 2, 2);

		//valueAxis.renderer.maxLabelPosition = 0.95;
		valueAxis.renderer.fontSize = "0.8em"

		var series = chart.series.push(new am4charts.CandlestickSeries());
		series.dataFields.dateX = "Date";
		series.dataFields.openValueY = "Open";
		series.dataFields.valueY = "Close";
		series.dataFields.lowValueY = "Low";
		series.dataFields.highValueY = "High";
		series.clustered = false;
		series.tooltipText = "open: {openValueY.value}\nlow: {lowValueY.value}\nhigh: {highValueY.value}\nclose: {valueY.value}";
		series.name = "MSFT";
		series.defaultState.transitionDuration = 0;

		var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis2.tooltip.disabled = true;
		// height of axis
		valueAxis2.height = am4core.percent(35);
		valueAxis2.zIndex = 3
		// this makes gap between panels
		valueAxis2.marginTop = 30;
		valueAxis2.renderer.baseGrid.disabled = true;
		valueAxis2.renderer.inside = true;
		valueAxis2.renderer.labels.template.verticalCenter = "bottom";
		valueAxis2.renderer.labels.template.padding(2, 2, 2, 2);
		//valueAxis.renderer.maxLabelPosition = 0.95;
		valueAxis2.renderer.fontSize = "0.8em"

		valueAxis2.renderer.gridContainer.background.fill = am4core
				.color("#000000");
		valueAxis2.renderer.gridContainer.background.fillOpacity = 0.05;

		var series2 = chart.series.push(new am4charts.ColumnSeries());
		series2.dataFields.dateX = "Date";
		series2.clustered = false;
		series2.dataFields.valueY = "Volume";
		series2.yAxis = valueAxis2;
		series2.tooltipText = "{valueY.value}";
		series2.name = "Series 2";
		// volume should be summed
		series2.groupFields.valueY = "sum";
		series2.defaultState.transitionDuration = 0;

		chart.cursor = new am4charts.XYCursor();

		var scrollbarX = new am4charts.XYChartScrollbar();

		var sbSeries = chart.series.push(new am4charts.LineSeries());
		sbSeries.dataFields.valueY = "Close";
		sbSeries.dataFields.dateX = "Date";
		scrollbarX.series.push(sbSeries);
		sbSeries.disabled = true;
		scrollbarX.marginBottom = 20;
		chart.scrollbarX = scrollbarX;
		scrollbarX.scrollbarChart.xAxes.getIndex(0).minHeight = undefined;

		/**
		 * Set up external controls
		 */

		// Date format to be used in input fields
		var inputFieldFormat = "yyyy-MM-dd";

		document.getElementById("b1m").addEventListener("click", function() {
			var max = dateAxis.groupMax["day1"];
			var date = new Date(max);
			am4core.time.add(date, "month", -1);
			zoomToDates(date);
		});

		document.getElementById("b3m").addEventListener("click", function() {
			var max = dateAxis.groupMax["day1"];
			var date = new Date(max);
			am4core.time.add(date, "month", -3);
			zoomToDates(date);
		});

		document.getElementById("b6m").addEventListener("click", function() {
			var max = dateAxis.groupMax["day1"];
			var date = new Date(max);
			am4core.time.add(date, "month", -6);
			zoomToDates(date);
		});

		document.getElementById("b1y").addEventListener("click", function() {
			var max = dateAxis.groupMax["day1"];
			var date = new Date(max);
			am4core.time.add(date, "year", -1);
			zoomToDates(date);
		});

		document.getElementById("bytd").addEventListener("click", function() {
			var max = dateAxis.groupMax["day1"];
			var date = new Date(max);
			am4core.time.round(date, "year", 1);
			zoomToDates(date);
		});

		document.getElementById("bmax").addEventListener("click", function() {
			var min = dateAxis.groupMin["day1"];
			var date = new Date(min);
			zoomToDates(date);
		});

		dateAxis.events.on("selectionextremeschanged", function() {
			updateFields();
		});

		dateAxis.events.on("extremeschanged", updateFields);

		function updateFields() {
			var minZoomed = dateAxis.minZoomed
					+ am4core.time.getDuration(
							dateAxis.mainBaseInterval.timeUnit,
							dateAxis.mainBaseInterval.count) * 0.5;
			document.getElementById("fromfield").value = chart.dateFormatter
					.format(minZoomed, inputFieldFormat);
			document.getElementById("tofield").value = chart.dateFormatter
					.format(new Date(dateAxis.maxZoomed), inputFieldFormat);
		}

		document.getElementById("fromfield").addEventListener("keyup",
				updateZoom);
		document.getElementById("tofield")
				.addEventListener("keyup", updateZoom);

		var zoomTimeout;
		function updateZoom() {
			if (zoomTimeout) {
				clearTimeout(zoomTimeout);
			}
			zoomTimeout = setTimeout(function() {
				var start = document.getElementById("fromfield").value;
				var end = document.getElementById("tofield").value;
				if ((start.length < inputFieldFormat.length)
						|| (end.length < inputFieldFormat.length)) {
					return;
				}
				var startDate = chart.dateFormatter.parse(start,
						inputFieldFormat);
				var endDate = chart.dateFormatter.parse(end, inputFieldFormat);

				if (startDate && endDate) {
					dateAxis.zoomToDates(startDate, endDate);
				}
			}, 500);
		}

		function zoomToDates(date) {
			var min = dateAxis.groupMin["day1"];
			var max = dateAxis.groupMax["day1"];
			dateAxis.keepSelection = true;
			//dateAxis.start = (date.getTime() - min)/(max - min);
			//dateAxis.end = 1;

			dateAxis.zoom({
				start : (date.getTime() - min) / (max - min),
				end : 1
			});
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
		crossorigin="anonymous">
		
	</script>
</body>
</html>