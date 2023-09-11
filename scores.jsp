<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NBA Scores</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
        	
        	document.querySelector("#dateSelector").addEventListener('change', onDateChange)
        	
        	
            $("#btn-get-data").on("click", (e) => getDateClick(e, t = "20230510"));
        	
        	
        	function getDateClick(e, newDate = "20230510") {
            	let date = newDate;
            	
                $.ajax({
                    url: "http://localhost:8081/NBAScores/Scores?gameDate=" + newDate,
                    type: "GET",
                    dataType: "json",
                    success: function(data) {
                        $("#data-container").text();
                        
                        console.log(data)
                        
                        const team1 = data.events[0].competitions[0].competitors[0].team.name
                        
                        const score = data.events[0].competitions[0].competitors[0].score
                        const team2 = data.events[0].competitions[0].competitors[1].team.name
                        const score2 = data.events[0].competitions[0].competitors[1].score
                        $('[data-id="teamName1"]').text(team1)
                        $('[data-id="teamScore1"]').text(score)
                        $('[data-id="teamName2"]').text(team2)
                        $('[data-id="teamScore2"]').text(score2)
                        
                        
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log("Error: " + textStatus);
                    }
                });
            }
            
            function onDateChange(e) {
            	const date = e.target.value;
            	// remove dashes and return newly formatted date
            	const formattedDate = date.toString().replace(/-/g, "");
            	
            	
            	
            	return getDateClick(e, formattedDate)
            	
            }
        });
    </script>
</head>
<body>
    <h1>NBA Scores</h1>
    
   <button id="btn-get-data">Call API</button>
   <div id="data-container"></div>
   <input id="dateSelector" type="date" />
   <h2 data-id="teamName1"></h2>
   <span data-id="teamScore1"></span>
    <h2 data-id="teamName2"></h2>
   <span data-id="teamScore2"></span>
   
</body>
</html>
