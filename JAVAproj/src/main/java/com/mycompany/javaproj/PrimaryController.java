package com.mycompany.javaproj;

import java.io.IOException;
import java.net.URL;
import java.text.NumberFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import static javafx.application.Platform.exit;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.TextField;

public class PrimaryController implements Initializable {

    @FXML
    private TextField lblArrival, lblDeparture, lblNight, lblPrice;

    long price_per_night = 120;

    @FXML
    public void Calculation(ActionEvent event) {

        try {
            if (lblArrival.getText() == null || lblArrival.getText().trim().isEmpty()
                    || lblDeparture.getText() == null || lblDeparture.getText().trim().isEmpty()) {
                showAlert("Error", "Arrival and Departure dates cannot be empty.");
                // Exit the method if fields are blank
            } else {

                String Arrivaldate = lblArrival.getText();
                String Departuredate = lblDeparture.getText();
                DateTimeFormatter formate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate parseDateArrival = LocalDate.parse(Arrivaldate, formate);
                LocalDate parseDateDeparture = LocalDate.parse(Departuredate, formate);
                LocalDate today = LocalDate.now();

                if (!(parseDateArrival.isBefore(today) || parseDateDeparture.isBefore(today))) {  // if arrival and departure date is in past exit the code

                    if (!(parseDateDeparture.isBefore(parseDateArrival))) { // if entered date is before than arrival return exit

                        //System.out.println("SUCCESS");
                        long daysBetween = ChronoUnit.DAYS.between(parseDateArrival, parseDateDeparture);

                        //System.out.println(daysBetween);
                        long price = daysBetween * price_per_night;
                        NumberFormat nf = NumberFormat.getCurrencyInstance();

                        //System.out.println(nf.format(price));
                        String sprice = nf.format(price);
                        String sdaysBetween = Long.toString(daysBetween);

                        lblNight.setText(sdaysBetween);
                        lblPrice.setText(sprice);

                    } else {
                        showAlert("Error", "Departure date must be after the Arrival date.");
                    }
                } else {
                    showAlert("Error", "Dates must be after today's date.");
                }
            }

            //int finalDate = parseDateArrival - parseDateDeparture;
        }
        catch (DateTimeParseException x) {
            Logger.getLogger(PrimaryController.class.getName()).log(Level.SEVERE, null, x);
            showAlert("Error", " " + x);
        }
        catch (Exception ex) {
            Logger.getLogger(PrimaryController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        LocalDate date = LocalDate.now();
        LocalDate date2 = date.plusDays(3);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String FormateString = date.format(formatter);
        String FormateString2 = date2.format(formatter);

        long dayscal = ChronoUnit.DAYS.between(date, date2);

        //System.out.println(daysBetween);
        long priceI = dayscal * price_per_night;
        NumberFormat nf = NumberFormat.getCurrencyInstance();

        // System.out.println(nf.format(priceI));
        String sprice = nf.format(priceI);
        String sdaysBetween = Long.toString(dayscal);

        lblNight.setText(sdaysBetween);
        lblPrice.setText(sprice);
        lblArrival.setText(FormateString);
        lblDeparture.setText(FormateString2);

        //lblDeparture.getOnMouseClicked(Clear);
    }

    @FXML
    public void Bookit(ActionEvent event) {
    try {
        if (lblArrival.getText() == null || lblArrival.getText().trim().isEmpty()
                || lblDeparture.getText() == null || lblDeparture.getText().trim().isEmpty()) {
            showAlert("Error", "Arrival and Departure dates cannot be empty.");
            // Exit the method if fields are blank
        } else {

            String Arrivaldate = lblArrival.getText();
            String Departuredate = lblDeparture.getText();
            DateTimeFormatter formate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate parseDateArrival = LocalDate.parse(Arrivaldate, formate);
            LocalDate parseDateDeparture = LocalDate.parse(Departuredate, formate);
            LocalDate today = LocalDate.now();
            
                if (!(parseDateDeparture.isBefore(today) || parseDateArrival.isBefore(today))) {  // if arrival and departure date is in past exit the code

                    if (!(parseDateDeparture.isBefore(parseDateArrival))) { // if entered date is before than arrival return exit

                        System.out.println("SUCCESS");
                        long daysBetween = ChronoUnit.DAYS.between(parseDateArrival, parseDateDeparture);

                        System.out.println(daysBetween);
                        long price = daysBetween * price_per_night;
                        NumberFormat nf = NumberFormat.getCurrencyInstance();

                        System.out.println(nf.format(price));
                        String sprice = nf.format(price);
                        String sdaysBetween = Long.toString(daysBetween);

                        HotelReservation reservation = new HotelReservation(parseDateArrival, parseDateDeparture, (int) daysBetween, (double) price);
                        boolean success = HotelDB.AddReservation(reservation);

                        if (success) {
                            //showAlert("Success", "Reservation has been sucessfully added");
                            App.setRoot("secondary");
                            //Clear();    
                        } else {
                            showAlert("Error", "Error while adding Reservation");
                        }

                        lblNight.setText(sdaysBetween);
                        lblPrice.setText(sprice);

                    } else {
                        showAlert("Error", "Departure date must be after the Arrival date.");
                    }
                } else {
                    showAlert("Error", "Dates must be after today's date.");
                }
            }

        }
        catch (DateTimeParseException x) {
            Logger.getLogger(PrimaryController.class.getName()).log(Level.SEVERE, null, x);
            showAlert("Error", " " + x);
        }
        catch (Exception ex) {
            showAlert("Error", "ERROR in Bookit");
        }

    }

    @FXML
    public void Clear() {

        lblNight.setText("");
        lblPrice.setText("");
        lblArrival.setText("");
        lblDeparture.setText("");
    }

    @FXML
    public void Exit(ActionEvent event) {
        exit();
    }

    private void showAlert(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }

}
