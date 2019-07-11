window.onload = function () {
	var chart = new CanvasJS.Chart("chartContainer1", {
		title:{
			text: "My First Chart in CanvasJS"              
		},
		data: [            
		{
			// Change type to "doughnut", "line", "splineArea", etc.
            type: "column",
            xValueType: "category_id",
            yValueFormatString: "####",
			dataPoints: $('#expenses-chart').data('expenses')
		}
		]
	});
	chart.render();
}
