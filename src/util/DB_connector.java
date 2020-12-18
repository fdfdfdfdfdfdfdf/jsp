package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB_connector {

    private Connection conn;

    public DB_connector() {
        try {
            String dbURL="jdbc:mysql://localhost:3306/bbs?serverTimezone=UTC";
            String dbID="root";
            String dbPassword="root";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConn() {
        return conn;
    }

}
