package utils;

import java.util.Properties;
import java.util.List;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Thư viện: https://mvnrepository.com/artifact/com.sun.mail/javax.mail
 * Tao mật khẩu ứng dụng: https://myaccount.google.com/apppasswords
 */
public class EmailUtils {
    
    // Thông tin tài khoản email dùng để gửi (thay đổi thông tin này)
    private static final String EMAIL_USERNAME = "ducphat02012004@gmail.com";
    private static final String EMAIL_PASSWORD = "fyyv qzrt sczm ndbs";
    
    // Cấu hình SMTP server
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String WEBSITE_URL = "http://localhost:8080/LaptopStore";
    
    /**
     * Gửi email thông báo đăng ký thành công
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param fullName Tên đầy đủ của người dùng
     * @param userID ID người dùng
     * @return true nếu gửi email thành công, false nếu có lỗi
     */
    public static boolean sendRegistrationEmail(String toEmail, String fullName, String userID) {
        try {
            Session session = createSession();
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to Our Website - Registration Successful");
            
            String htmlContent = createRegistrationEmailContent(fullName, userID);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi email xác thực tài khoản với token
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param fullName Tên đầy đủ của người dùng
     * @param token Token xác thực
     * @return true nếu gửi email thành công, false nếu có lỗi
     */
    public static boolean sendVerificationEmail(String toEmail, String fullName, String token) {
        try {
            Session session = createSession();
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Account Verification Required");
            
            String verificationLink = WEBSITE_URL + "/verify?token=" + token;
            String htmlContent = createVerificationEmailContent(fullName, verificationLink);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi email thông tin đơn hàng
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param fullName Tên đầy đủ của người dùng
     * @param orderID ID đơn hàng
     * @param items Danh sách sản phẩm (format: "Sản phẩm 1 x2 - 500.000đ")
     * @param totalPrice Tổng tiền
     * @param status Trạng thái đơn hàng
     * @return true nếu gửi email thành công, false nếu có lỗi
     */
    public static boolean sendOrderEmail(String toEmail, String fullName, String orderID, 
                                         List<String> items, double totalPrice, String status) {
        try {
            Session session = createSession();
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Order Confirmation - Order #" + orderID);
            
            String htmlContent = createOrderEmailContent(fullName, orderID, items, totalPrice, status);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gửi email cập nhật trạng thái đơn hàng
     * 
     * @param toEmail Địa chỉ email người nhận
     * @param fullName Tên đầy đủ của người dùng
     * @param orderID ID đơn hàng
     * @param status Trạng thái mới
     * @param message Thông điệp thêm
     * @return true nếu gửi email thành công, false nếu có lỗi
     */
    public static boolean sendOrderStatusEmail(String toEmail, String fullName, String orderID, 
                                               String status, String message) {
        try {
            Session session = createSession();
            
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(EMAIL_USERNAME));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Order Status Update - Order #" + orderID);
            
            String htmlContent = createOrderStatusEmailContent(fullName, orderID, status, message);
            msg.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(msg);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Tạo session SMTP
     */
    private static Session createSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });
    }
    
    /**
     * Xây dựng nội dung HTML cho email đăng ký thành công
     */
    private static String createRegistrationEmailContent(String fullName, String userID) {
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <title>Registration Successful</title>\n"
                + "    <style>\n"
                + "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }\n"
                + "        .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f9f9f9; }\n"
                + "        .header { background-color: #744DA9; color: white; padding: 20px; text-align: center; }\n"
                + "        .content { padding: 20px; background-color: white; border-radius: 5px; }\n"
                + "        .button { display: inline-block; padding: 10px 20px; background-color: #744DA9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }\n"
                + "        .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }\n"
                + "    </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"container\">\n"
                + "        <div class=\"header\">\n"
                + "            <h1>Welcome to Our Website!</h1>\n"
                + "        </div>\n"
                + "        <div class=\"content\">\n"
                + "            <h2>Hello, " + fullName + "!</h2>\n"
                + "            <p>Thank you for registering with our website. Your account has been successfully created.</p>\n"
                + "            <p><strong>Your User ID:</strong> " + userID + "</p>\n"
                + "            <p>You can now login to your account and start exploring our services.</p>\n"
                + "            <a href=\"" + WEBSITE_URL + "/user/login.do\" class=\"button\">Login to Your Account</a>\n"
                + "            <p>If you have any questions, please contact our support team.</p>\n"
                + "            <p>Best regards,<br>The Team</p>\n"
                + "        </div>\n"
                + "        <div class=\"footer\">\n"
                + "            <p>This is an automated message, please do not reply to this email.</p>\n"
                + "            <p>&copy; 2025 Your Company. All rights reserved.</p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";
    }
    
    /**
     * Xây dựng nội dung HTML cho email xác thực tài khoản
     */
    private static String createVerificationEmailContent(String fullName, String verificationLink) {
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <title>Verify Your Account</title>\n"
                + "    <style>\n"
                + "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }\n"
                + "        .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f9f9f9; }\n"
                + "        .header { background-color: #744DA9; color: white; padding: 20px; text-align: center; }\n"
                + "        .content { padding: 20px; background-color: white; border-radius: 5px; }\n"
                + "        .button { display: inline-block; padding: 10px 20px; background-color: #744DA9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }\n"
                + "        .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }\n"
                + "    </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"container\">\n"
                + "        <div class=\"header\">\n"
                + "            <h1>Verify Your Account</h1>\n"
                + "        </div>\n"
                + "        <div class=\"content\">\n"
                + "            <h2>Hello, " + fullName + "!</h2>\n"
                + "            <p>To complete your registration, please verify your email address by clicking the button below:</p>\n"
                + "            <a href=\"" + verificationLink + "\" class=\"button\">Verify Your Account</a>\n"
                + "            <p>If the button doesn't work, copy and paste this link:</p>\n"
                + "            <p><a href=\"" + verificationLink + "\">" + verificationLink + "</a></p>\n"
                + "            <p><strong>This verification link will expire in 24 hours.</strong></p>\n"
                + "            <p>If you did not sign up for an account, please ignore this email.</p>\n"
                + "            <p>Best regards,<br>The Team</p>\n"
                + "        </div>\n"
                + "        <div class=\"footer\">\n"
                + "            <p>This is an automated message, please do not reply to this email.</p>\n"
                + "            <p>&copy; 2025 Your Company. All rights reserved.</p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";
    }
    
    /**
     * Xây dựng nội dung HTML cho email xác nhận đơn hàng
     */
    private static String createOrderEmailContent(String fullName, String orderID, 
                                                   List<String> items, double totalPrice, String status) {
        StringBuilder itemsHtml = new StringBuilder();
        if (items != null && !items.isEmpty()) {
            itemsHtml.append("<ul style=\"background-color: #f5f5f5; padding: 15px; border-radius: 5px;\">\n");
            for (String item : items) {
                itemsHtml.append("    <li>").append(item).append("</li>\n");
            }
            itemsHtml.append("</ul>\n");
        }
        
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <title>Order Confirmation</title>\n"
                + "    <style>\n"
                + "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }\n"
                + "        .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f9f9f9; }\n"
                + "        .header { background-color: #28a745; color: white; padding: 20px; text-align: center; }\n"
                + "        .content { padding: 20px; background-color: white; border-radius: 5px; }\n"
                + "        .order-info { background-color: #e8f5e9; padding: 15px; border-radius: 5px; margin: 15px 0; }\n"
                + "        .total { font-size: 18px; font-weight: bold; color: #28a745; margin: 10px 0; }\n"
                + "        .button { display: inline-block; padding: 10px 20px; background-color: #744DA9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }\n"
                + "        .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }\n"
                + "    </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"container\">\n"
                + "        <div class=\"header\">\n"
                + "            <h1>Order Confirmation</h1>\n"
                + "        </div>\n"
                + "        <div class=\"content\">\n"
                + "            <h2>Hello, " + fullName + "!</h2>\n"
                + "            <p>Thank you for your order! We've received it and will process it shortly.</p>\n"
                + "            <div class=\"order-info\">\n"
                + "                <p><strong>Order ID:</strong> " + orderID + "</p>\n"
                + "                <p><strong>Status:</strong> " + status + "</p>\n"
                + "            </div>\n"
                + "            <h3>Order Items:</h3>\n"
                + itemsHtml.toString()
                + "            <div class=\"total\">\n"
                + "                Total Price: " + String.format("%.2f", totalPrice) + " VND\n"
                + "            </div>\n"
                + "            <p>You can track your order status on our website:</p>\n"
                + "            <a href=\"" + WEBSITE_URL + "/order/view?id=" + orderID + "\" class=\"button\">View Order Details</a>\n"
                + "            <p>If you have any questions, please contact our support team.</p>\n"
                + "            <p>Best regards,<br>The Team</p>\n"
                + "        </div>\n"
                + "        <div class=\"footer\">\n"
                + "            <p>This is an automated message, please do not reply to this email.</p>\n"
                + "            <p>&copy; 2025 Your Company. All rights reserved.</p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";
    }
    
    /**
     * Xây dựng nội dung HTML cho email cập nhật trạng thái đơn hàng
     */
    private static String createOrderStatusEmailContent(String fullName, String orderID, 
                                                        String status, String message) {
        String statusColor = getStatusColor(status);
        
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <title>Order Status Update</title>\n"
                + "    <style>\n"
                + "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; }\n"
                + "        .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f9f9f9; }\n"
                + "        .header { background-color: #017cba; color: white; padding: 20px; text-align: center; }\n"
                + "        .content { padding: 20px; background-color: white; border-radius: 5px; }\n"
                + "        .status-badge { display: inline-block; padding: 8px 15px; background-color: " + statusColor + "; color: white; border-radius: 20px; font-weight: bold; }\n"
                + "        .button { display: inline-block; padding: 10px 20px; background-color: #744DA9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }\n"
                + "        .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }\n"
                + "    </style>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <div class=\"container\">\n"
                + "        <div class=\"header\">\n"
                + "            <h1>Order Status Update</h1>\n"
                + "        </div>\n"
                + "        <div class=\"content\">\n"
                + "            <h2>Hello, " + fullName + "!</h2>\n"
                + "            <p>Your order status has been updated:</p>\n"
                + "            <p><strong>Order ID:</strong> " + orderID + "</p>\n"
                + "            <p>New Status: <span class=\"status-badge\">" + status + "</span></p>\n"
                + "            <p>" + message + "</p>\n"
                + "            <a href=\"" + WEBSITE_URL + "/order/view?id=" + orderID + "\" class=\"button\">View Order Details</a>\n"
                + "            <p>If you have any questions, please contact our support team.</p>\n"
                + "            <p>Best regards,<br>The Team</p>\n"
                + "        </div>\n"
                + "        <div class=\"footer\">\n"
                + "            <p>This is an automated message, please do not reply to this email.</p>\n"
                + "            <p>&copy; 2025 Your Company. All rights reserved.</p>\n"
                + "        </div>\n"
                + "    </div>\n"
                + "</body>\n"
                + "</html>";
    }
    
    /**
     * Lấy màu sắc theo trạng thái đơn hàng
     */
    private static String getStatusColor(String status) {
        switch (status.toLowerCase()) {
            case "pending":
                return "#ffc107";
            case "confirmed":
                return "#17a2b8";
            case "shipped":
                return "#007bff";
            case "delivered":
                return "#28a745";
            case "cancelled":
                return "#dc3545";
            default:
                return "#6c757d";
        }
    }
    
    public static void main(String[] args) {
        // Test gửi email đăng ký
        sendRegistrationEmail("lenhattung@gmail.com", "Lê Nhật Tùng", "1");
    }
}