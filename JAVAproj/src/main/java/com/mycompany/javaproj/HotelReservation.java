/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.javaproj;

import java.time.LocalDate;

/**
 *
 * @author patel
 */
public class HotelReservation {

    LocalDate arrival_date;
    LocalDate departure_date;
    int numNights;
    double price;

    public LocalDate getArrival_date() {
        return arrival_date;
    }

    public void setArrival_date(LocalDate arrival_date) {
        this.arrival_date = arrival_date;
    }

    public LocalDate getDeparture_date() {
        return departure_date;
    }

    public void setDeparture_date(LocalDate departure_date) {
        this.departure_date = departure_date;
    }

    public int getNumNights() {
        return numNights;
    }

    public void setNumNights(int numNights) {
        this.numNights = numNights;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public HotelReservation() {
    }

    public HotelReservation(LocalDate arrival_date, LocalDate departure_date, int numNights, double price) {
        this.arrival_date = arrival_date;
        this.departure_date = departure_date;
        this.numNights = numNights;
        this.price = price;
    }

    @Override
    public String toString() {
        return  " arrival = " + arrival_date + " , departure = " + departure_date + " , numNights = " + numNights + " , price = " + price + '}';
    }


}
