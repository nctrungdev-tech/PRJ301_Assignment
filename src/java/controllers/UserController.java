package controllers;

import DAO.OrderFacade;
import DAO.UserFacade;
import DAO.WalletFacade;
import entity.Users;
import entity.Wallet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "UserController", urlPatterns = {"/user"})
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
            case "wallet":
                wallet(request, response);
                break;
        }
    }

    // ======================= LOGIN ========================
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

                case "guest":
                    HttpSession guestSession = request.getSession();
                    guestSession.setAttribute("isGuest", true);
                    guestSession.setAttribute("user", null);
                    request.getRequestDispatcher("/product/index.do").forward(request, response);
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

    // ======================= CREATE (REGISTER) ========================
    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void create_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            if (!"create".equals(op)) {
                request.getRequestDispatcher("/product/index.do").forward(request, response);
                return;
            }

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("passwordHash");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            String agreePolicy = request.getParameter("agreePolicy");
            if (agreePolicy == null) {
                request.setAttribute("message3", "You must agree with the service policy.<br/>");
                request.getRequestDispatcher("/user/create.do").forward(request, response);
                return;
            }

            String errorMessage = "";
            if (fullName == null || fullName.isEmpty() || fullName.length() < 3 || fullName.length() > 50)
                errorMessage += "Full name must be between 3 and 50 characters.<br/>";
            if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"))
                errorMessage += "Email is invalid.<br/>";
            if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}"))
                errorMessage += "Phone number must be 10 digits long.<br/>";
            if (address == null || address.isEmpty())
                errorMessage += "Address cannot be empty.<br/>";
            if (password == null || password.isEmpty() || password.length() < 4)
                errorMessage += "Password must be at least 4 characters long.<br/>";

            if (!errorMessage.isEmpty()) {
                request.setAttribute("message3", errorMessage);
                request.getRequestDispatcher("/user/create.do").forward(request, response);
                return;
            }

            Users user = new Users();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPasswordHash(password);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoled("customer");

            UserFacade uf = new UserFacade();
            uf.create(user);

            request.setAttribute("message", "🎉 Congratulations! You have successfully registered!");
            request.getRequestDispatcher("/user/create.do").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message3", "⚠️ Registration failed. Please try again.");
            request.getRequestDispatcher("/user/create.do").forward(request, response);
        }
    }

    // ======================= EDIT PROFILE ========================
    protected void editProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void editProfile_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            if (!"update".equals(op)) {
                request.getRequestDispatcher("/product/index.do").forward(request, response);
                return;
            }

            int userId = Integer.parseInt(request.getParameter("userID"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("passwordHash");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            String errorMessage = "";
            if (fullName == null || fullName.isEmpty() || fullName.length() < 3 || fullName.length() > 50)
                errorMessage += "Full name must be between 3 and 50 characters.<br/>";
            if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"))
                errorMessage += "Email is invalid.<br/>";
            if (phone == null || phone.isEmpty() || !phone.matches("\\d{10}"))
                errorMessage += "Phone number must be 10 digits long.<br/>";
            if (address == null || address.isEmpty())
                errorMessage += "Address cannot be empty.<br/>";
            if (password != null && !password.isEmpty() && password.length() < 4)
                errorMessage += "Password must be at least 4 characters long.<br/>";

            if (!errorMessage.isEmpty()) {
                request.setAttribute("message3", errorMessage);
                request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                return;
            }

            UserFacade uf = new UserFacade();
            Users oldUser = uf.select(userId);
            if (oldUser == null) {
                request.setAttribute("message3", "User not found.");
                request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
                return;
            }

            Users user = new Users();
            user.setUserID(userId);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoled(oldUser.getRoled());

            if (password == null || password.isEmpty())
                user.setPasswordHash(oldUser.getPasswordHash());
            else
                user.setPasswordHash(password);

            uf.update(user);

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            request.setAttribute("message", "Profile updated successfully!");
            request.getRequestDispatcher("/user/editProfile.do").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("message3", "Can't update user.");
            request.getRequestDispatcher("/user/editProfile.do").forward(request, response);
        }
    }

    // ======================= WALLET ========================
    protected void wallet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/user/login.do");
                return;
            }

            String action = request.getParameter("action");
            if ("topup".equals(action)) {
                double amount = Double.parseDouble(request.getParameter("amount"));
                WalletFacade wf = new WalletFacade();
                wf.addMoney(user.getUserID(), amount);

                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true}");
                out.flush();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false}");
            out.flush();
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
        return "User Controller";
    }
}
