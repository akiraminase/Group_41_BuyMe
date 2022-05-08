import com.cs336.pkg.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class Bider {
    static ApplicationDB db;
	static Connection con;
	static Statement stmt;

    public Bider(){
        db = new ApplicationDB();
        con = db.getConnection();
        stmt = con.createStatement();
    }
    public static void bid(String username, String auctionID, String price){
        String insert = "INSERT INTO Bid VALUES (NULL, ?, ?, ?, NOW())";
        PreparedStatement ps = con.prepareStatement(insert);
        ps.setInt(1, Integer.parseInt(auctionID)) ;
        ps.setString(2, username) ;
        ps.setFloat(3, Float.valueOf(price)) ;
        ps.executeUpdate();
        //alert other buyers for higher bid
        SQLstr = "SELECT Username FROM bid WHERE Username != '"+username+"' AND auction_ID = "+auctionID+" ORDER BY Price DESC LIMIT 1;";
        result = stmt.executeQuery(SQLstr);
        result.next();
        String otherUsername = result.getString("Username");
        insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
        ps = con.prepareStatement(insert);
        ps.setString(1, otherUsername) ;
        ps.setString(2, "'There is a higher bid for Auction #"+auctionID+"'") ;
        ps.executeUpdate();
        //alert other buyers for higher bid than upper limit
        SQLstr = "SELECT Username FROM Auto_Bid WHERE auction_ID = "+auctionID+" AND Upper_Limit < "+price+" AND Username != '"+username+"';";
        result = stmt.executeQuery(SQLstr);
        while(result.next()){
            otherUsername = result.getString("Username");
            insert = "INSERT INTO Alert VALUES (NULL, ?, ?, NOW())";
            ps = con.prepareStatement(insert);
            ps.setString(1, otherUsername) ;
            ps.setString(2, "'There is a higher bid exceeding your upper limit for Auction #"+auctionID+"'") ;
            ps.executeUpdate();
        }
        //place all autobid by recurisvely use bid
        SQLstr = "SELECT Username, ("+price+"+Increment) AS price FROM Auto_Bid WHERE auction_ID = "+auctionID+" AND Upper_Limit > ("+price+"+Increment) AND Username != '"+username+"';";
        result = stmt.executeQuery(SQLstr);
        while(result.next()){
            otherUsername = result.getString("Username");
            price = result.getString("price");
            bid(otherUsername, auctionID, price);
        }
        return;
    }
}
