/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.OrderFacade;
import DAO.UserFacade;
import entity.Orders;
import entity.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author VINH HIEN
 */
@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getAttribute("action").toString();
        switch (action) {         
            case "login":
                login(request, response);
                break;
            case "login_handler":
                login_handler(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "create":
                create(request, response);
                break;
            case "create_handler":
                create_handler(request, response);
                break;    
            case "editProfile":
                editProfile(request, response);
                break; 
            case "editProfile_handler":
                editProfile_handler(request, response);
                break;  
        }
    }
    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {       
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }
    protected void login_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "login":
                    String email = request.getParameter("email");
                    String passwordHash = request.getParameter("passwordHash");

                    UserFacade uf = new UserFacade();
                    Users user = uf.login(email, passwordHash);
                    if (user != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);
                        request.getRequestDispatcher("/product/index.do").forward(request, response);
                    } else {
                        request.setAttribute("message", "Please check your email and password.");
                        request.getRequestDispatcher("/user/login.do").forward(request, response);
                    }
                    break;
                case "cancel":
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", e.getMessage());
            request.getRequestDispatcher("/user/login.do").forward(request, response);
        }
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        request.getRequestDispatcher("/product/index.do").forward(request, response);
    }
    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }
    protected void create_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "create":
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String passwordHash = request.getParameter("passwordHash");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String errorMessage = "";
                    // Ràng buộc cho fullName
                    if (fullName == null || fullName.isEmpty() || fullName.length() < 8 || fullName.length() > 50) {
                        errorMessage += "Full name must be between 8 and 50 characters.<br/>";
                    }
                    // Ràng buộc cho email
                    if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                        errorMessage += "Email is invalid.<br/>";
                    }
                    // Ràng buộc cho phone
                    if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}")) {
                        errorMessage += "Phone number must be 10 digits long.<br/>";
                    }
                    // Ràng buộc cho address
                    if (address == null || address.isEmpty()) {
                        errorMessage += "Address cannot be empty.<br/>";
                    }
                    // Ràng buộc cho passwordHash
                    if (passwordHash == null || passwordHash.isEmpty() || passwordHash.length() < 6) {
                        errorMessage += "Password must be at least 6 characters long.<br/>";
                    }
                    // Nếu có lỗi, gửi lại thông báo
                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/user/create.do").forward(request, response);
                        return;
                    } else {
                        Users user = new Users();
                        user.setFullName(fullName);
                        user.setEmail(email);
                        user.setPasswordHash(passwordHash);
                        user.setPhone(phone);
                        user.setAddress(address);

                        UserFacade uf = new UserFacade();
                        uf.create(user);
                        request.setAttribute("message", "Congratulations. You have successfully registered!");
                        request.getRequestDispatcher("/user/create.do").forward(request, response);
                        break;
                    }
                case "cancel":
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message2", "Sorry. Registration failed!");
            request.getRequestDispatcher("/user/create.do").forward(request, response);
        }
    }
    protected void editProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }
    protected void editProfile_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "update":
                    int userId= Integer.parseInt(request.getParameter("userID"));
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String passwordHash = request.getParameter("passwordHash");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String errorMessage = "";
                    // Ràng buộc cho fullName
                    if (fullName == null || fullName.isEmpty() || fullName.length() < 8 || fullName.length() > 50) {
                        errorMessage += "Full name must be between 8 and 50 characters.<br/>";
                    }
                    // Ràng buộc cho email
                    if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                        errorMessage += "Email is invalid.<br/>";
                    }
                    // Ràng buộc cho phone
                    if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}")) {
                        errorMessage += "Phone number must be 10 digits long.<br/>";
                    }
                    // Ràng buộc cho address
                    if (address == null || address.isEmpty()) {
                        errorMessage += "Address cannot be empty.<br/>";
                    }
                    // Ràng buộc cho passwordHash
                    if (passwordHash == null || passwordHash.isEmpty() || passwordHash.length() < 6) {
                        errorMessage += "Password must be at least 6 characters long.<br/>";
                    }
                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                        return;
                    } else {
                        Users user = new Users();
                        user.setUserID(userId);
                        user.setFullName(fullName);
                        user.setEmail(email);
                        user.setPasswordHash(passwordHash);
                        user.setPhone(phone);
                        user.setAddress(address);

                        UserFacade uf = new UserFacade();
                        uf.update(user);
                        request.setAttribute("message", "Congratulations. You have successfully updated!");
                        request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                        break;
                    } 
                case "cancel":    
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message3", "Can't update User into database.");
            request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
