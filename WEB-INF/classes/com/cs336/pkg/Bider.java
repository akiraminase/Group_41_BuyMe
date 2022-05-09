package com.cs336.pkg;

import com.cs336.pkg.*;
import java.io.*;
import java.util.*;
import java.sql.*;

public class Bider {
    ApplicationDB db;
	Connection con;
	Statement stmt;

    public Bider() throws SQLException{
        db = new ApplicationDB();
        con = db.getConnection();
        stmt = con.createStatement();
    }
    
}
