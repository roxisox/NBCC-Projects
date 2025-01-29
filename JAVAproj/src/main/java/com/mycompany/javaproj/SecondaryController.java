package com.mycompany.javaproj;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;

public class SecondaryController implements Initializable {

    @FXML 
    private ListView<String> lstView;
    
    @FXML
    private void switchToPrimary() throws IOException {
        App.setRoot("primary");
     }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        List<HotelReservation> reservations = HotelDB.GetReservations();
        
        for(HotelReservation reservation : reservations){
            lstView.getItems().add(reservation.toString());
        }
    }
    
    
}