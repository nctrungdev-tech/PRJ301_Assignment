package controllers;

import DAO.UserFacade;
import entity.Users;
import utils.EmailUtils;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.Base64;

@WebServlet(name = "UserController", urlPatterns = {"/user"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB
public class UserController extends HttpServlet {

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
        UserFacade uf = new UserFacade();

        switch (op) {
            case "login":
                String email = request.getParameter("email");
                String password = request.getParameter("password");  // ← Đổi từ passwordHash

                Users user = uf.login(email, password);  // ← Truyền password (plain text)
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
                } else {
                    request.setAttribute("message", "Please check your email and password.");
                    request.getRequestDispatcher("/user/login.do").forward(request, response);
                }
                break;

            case "guest":
                Users guest = new Users();
                guest.setUserID(0);
                guest.setFullName("Guest User");
                guest.setEmail("guest@demo.com");
                guest.setRoled("Guest");

                HttpSession guestSession = request.getSession();
                guestSession.setAttribute("user", guest);
                request.getRequestDispatcher("/product/index.do").forward(request, response);
                break;

            case "cancel":
                request.getRequestDispatcher("/product/index.do").forward(request, response);
                break;

            default:
                request.setAttribute("message", "Invalid action.");
                request.getRequestDispatcher("/user/login.do").forward(request, response);
                break;
        }

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "An error occurred: " + e.getMessage());
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
                    String avatarData = null;

                    String errorMessage = "";
                    if (fullName == null || fullName.isEmpty() || fullName.length() < 8 || fullName.length() > 50)
                        errorMessage += "Full name must be between 8 and 50 characters.<br/>";
                    if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"))
                        errorMessage += "Email is invalid.<br/>";
                    if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}"))
                        errorMessage += "Phone number must be 10 digits long.<br/>";
                    if (address == null || address.isEmpty())
                        errorMessage += "Address cannot be empty.<br/>";
                    if (passwordHash == null || passwordHash.isEmpty() || passwordHash.length() < 6)
                        errorMessage += "Password must be at least 6 characters long.<br/>";

                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/user/create.do").forward(request, response);
                        return;
                    }

                    // Xử lý avatar
                    try {
                        Part filePart = request.getPart("avatarData");
                        if (filePart != null && filePart.getSize() > 0) {
                            byte[] fileBytes = new byte[(int) filePart.getSize()];
                            filePart.getInputStream().read(fileBytes);
                            avatarData = Base64.getEncoder().encodeToString(fileBytes);
                        }
                    } catch (Exception e) {
                        System.out.println("Avatar upload optional: " + e.getMessage());
                    }

                    Users user = new Users();
                    user.setFullName(fullName);
                    user.setEmail(email);
                    user.setPasswordHash(passwordHash);
                    user.setPhone(phone);
                    user.setAddress(address);
                    user.setRoled("Customer"); // Mặc định là Customer
                    if (avatarData != null) {
                        user.setAvatarBase64(avatarData);
                    }

                    UserFacade uf = new UserFacade();
                    uf.create(user);
                    
                    // GỬI EMAIL ĐĂNG KÝ THÀNH CÔNG
                    boolean emailSent = EmailUtils.sendRegistrationEmail(
                        email, 
                        fullName, 
                        String.valueOf(user.getUserID())
                    );
                    
                    if (emailSent) {
                        request.setAttribute("message", "Congratulations. You have successfully registered! A confirmation email has been sent to your email address.");
                    } else {
                        request.setAttribute("message", "Congratulations. You have successfully registered! (Email sending failed, please check your email settings)");
                    }
                    
                    request.getRequestDispatcher("/user/create.do").forward(request, response);
                    break;

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
            HttpSession session = request.getSession(false);
            Users loggedInUser = null;

            // Lấy user đang login từ session
            if (session != null) {
                loggedInUser = (Users) session.getAttribute("user");
            }

            // Kiểm tra nếu không có user login
            if (loggedInUser == null) {
                request.setAttribute("message3", "You must login first!");
                request.getRequestDispatcher("/user/login.do").forward(request, response);
                return;
            }

            UserFacade uf = new UserFacade();

            switch (op) {
                case "update":
                    int userId = Integer.parseInt(request.getParameter("userID"));
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String passwordHash = request.getParameter("passwordHash");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String avatarData = null;

                    // PHÂN QUYỀN:
                    // Admin không được update users
                    if (loggedInUser.getRoled().equals("Admin")) {
                        request.setAttribute("message3", "Admin cannot update user profiles!");
                        request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                        return;
                    }

                    // Customer chỉ được update thông tin của chính mình
                    if (loggedInUser.getRoled().equals("Customer") && loggedInUser.getUserID() != userId) {
                        request.setAttribute("message3", "You can only update your own profile!");
                        request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                        return;
                    }

                    String errorMessage = "";
                    if (fullName == null || fullName.isEmpty() || fullName.length() < 8 || fullName.length() > 50)
                        errorMessage += "Full name must be between 8 and 50 characters.<br/>";
                    if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"))
                        errorMessage += "Email is invalid.<br/>";
                    if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}"))
                        errorMessage += "Phone number must be 10 digits long.<br/>";
                    if (address == null || address.isEmpty())
                        errorMessage += "Address cannot be empty.<br/>";
                    if (passwordHash == null || passwordHash.isEmpty() || passwordHash.length() < 6)
                        errorMessage += "Password must be at least 6 characters long.<br/>";

                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                        return;
                    }

                    // Xử lý avatar
                    try {
                        Part filePart = request.getPart("avatarData");
                        if (filePart != null && filePart.getSize() > 0) {
                            byte[] fileBytes = new byte[(int) filePart.getSize()];
                            filePart.getInputStream().read(fileBytes);
                            avatarData = Base64.getEncoder().encodeToString(fileBytes);
                        }
                    } catch (Exception e) {
                        System.out.println("Avatar upload optional: " + e.getMessage());
                    }

                    Users user = new Users();
                    user.setUserID(userId);
                    user.setFullName(fullName);
                    user.setEmail(email);
                    user.setPasswordHash(passwordHash);
                    user.setPhone(phone);
                    user.setAddress(address);
                    if (avatarData != null) {
                        user.setAvatarBase64(avatarData);
                    }

                    uf.update(user);

                    // GỬI EMAIL THÔNG BÁO CẬP NHẬT PROFILE
                    boolean emailSent = EmailUtils.sendRegistrationEmail(
                        email, 
                        fullName, 
                        String.valueOf(userId)
                    );
                    
                    if (emailSent) {
                        request.setAttribute("message", "Congratulations. You have successfully updated! A confirmation email has been sent to your email address.");
                    } else {
                        request.setAttribute("message", "Congratulations. You have successfully updated! (Email sending failed)");
                    }

                    // Cập nhật session
                    session.setAttribute("user", user);

                    request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                    break;

                case "cancel":
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
                    break;

                default:
                    request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                    break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message3", "Error while processing request!");
            request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "UserController Servlet";
    }
}