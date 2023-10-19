/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Le Chi Khiem - CE171515
 */
public class DBConnection {
    public static Connection connect() throws ClassNotFoundException, SQLException{
          Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
           Connection conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-836S4K7\\SQLEXPRESS:49510;databaseName=lab02;user=sa;password=khiem005101;encrypt=true;trustServerCertificate=true");
            return conn;  
    }
}
 