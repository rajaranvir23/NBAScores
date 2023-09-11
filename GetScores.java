import java.net.http.HttpClient;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Scores")
public class GetScores extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	try {
    		String gameDate = request.getParameter("gameDate");
    		URL url = new URL("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard?dates=" + gameDate);
        	
        	HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer content = new StringBuffer();
            
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            
            response.getWriter().write(content.toString());
            in.close();
            con.disconnect();
    	} catch (Exception e) {
    		System.out.println("Error: " + e.getMessage());
    	}
    	
    }
}
