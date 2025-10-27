/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author VINH HIEN
 */
public class Shipping {
    private int shippingID;
    private int userID;
    private String receiverName;
    private String phone;
    private String address;
    private String status;
    private String notes;

    public Shipping() {
    }

    public Shipping(int shippingID, int userID, String receiverName, String phone, String address, String status, String notes) {
        this.shippingID = shippingID;
        this.userID = userID;
        this.receiverName = receiverName;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.notes = notes;
    }

    public int getShippingID() {
        return shippingID;
    }

    public void setShippingID(int shippingID) {
        this.shippingID = shippingID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    

    
    
}
