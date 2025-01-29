/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.javaproj;


import java.util.logging.Logger;
import java.lang.System.Logger.Level;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author patel
 */
public class HotelDB {

    public static void main(String[] args) {
    }
    
    public static Connection GetConnection() {
        try {
            Connection conn = null;
            String user = "root";
            String password = "";
            String dbURL = "jdbc:mysql://localhost:3306/hoteldb";
            
            conn = DriverManager.getConnection(dbURL, user, password);
            
            return conn;
        } //end getConnection
        catch (SQLException ex) {
            System.out.println("error " + ex);
        }
        return null;
    }
    
    public static boolean AddReservation(HotelReservation hr){
      String sql = "INSERT into reservations (arrival_date, departure_date, num_nights, price) VALUES (?,?,?,?)";
       try {
           Connection conn = GetConnection();
           PreparedStatement pstms = conn.prepareStatement(sql);
           
           pstms.setString(1, hr.getArrival_date().format(DateTimeFormatter.ISO_DATE));
           pstms.setString(2,hr.getDeparture_date().format(DateTimeFormatter.ISO_DATE));
           pstms.setString(3, Integer.toString(hr.getNumNights()));
           pstms.setString(4, Double.toString(hr.getPrice()));
           pstms.executeUpdate(); //commit to the database
            return true;
        } 
        catch(SQLException ex){
            Logger.getLogger(HotelDB.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        return false;
        
    }
    
    public static List<HotelReservation> GetReservations(){
        List<HotelReservation> list = new ArrayList<>();
        String sql = "select * from reservations";  
        
        try(Connection conn = GetConnection();
            Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)){
            
            HotelReservation hr = new HotelReservation();
          while (rs.next()) {
                
                hr.setArrival_date(rs.getDate("arrival_date").toLocalDate());
                hr.setDeparture_date(rs.getDate("departure_date").toLocalDate());
                hr.setNumNights(rs.getInt("num_nights"));
                hr.setPrice(rs.getDouble("price"));

                list.add(hr);
            }
        }
        catch(SQLException ex){
            Logger.getLogger(HotelDB.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        
        return list;
    }
}
