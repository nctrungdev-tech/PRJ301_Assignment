/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.ProductFacade;
import entity.Products;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author VINH HIEN
 */
@WebServlet(name = "ManagerController", urlPatterns = {"/manager"})
public class ManagerController extends HttpServlet {

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
        String action = (String) request.getAttribute("action");
        switch (action) {
            case "index":
                index(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "update_handler":
                update_handler(request, response);
                break;
            case "create":
                create(request, response);
                break;
            case "create_handler":
                create_handler(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductFacade pf = new ProductFacade();
            List<Products> list = pf.select();
            request.setAttribute("list", list);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (Exception e) {
        }
    }

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy tham chiếu của đối tượng session

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void create_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "create":
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    double price = 0;
                    int stock = 0;
                    int categoryID = 0;
                    String imageURL = request.getParameter("imageURL");
                    int sold = 0;
                    int discount = 0;
                    String errorMessage = "";

                    // Ràng buộc cho name
                    if (name == null || name.trim().isEmpty()) {
                        errorMessage += "Name is invalid.<br/>";
                    }

                    // Ràng buộc cho description
                    if (description == null || description.trim().isEmpty()) {
                        errorMessage += "Description is invalid.<br/>";
                    }
                    // Chuyển đổi dữ liệu với xử lý ngoại lệ
                    try {
                        price = Double.parseDouble(request.getParameter("price"));
                        if (price < 0) {
                            errorMessage += "Price must be a non-negative number.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Price must be a valid number.<br/>";
                    }

                    try {
                        stock = Integer.parseInt(request.getParameter("stock"));
                        if (stock < 0) {
                            errorMessage += "Stock must be a non-negative integer.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Stock must be a valid integer.<br/>";
                    }

                    try {
                        categoryID = Integer.parseInt(request.getParameter("categoryID"));
                        if (categoryID <= 0 || categoryID > 4) {
                            errorMessage += "Category ID must be from 1 - 4.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Category ID must be a valid integer.<br/>";
                    }

                    // Kiểm tra URL ảnh (có thể mở rộng kiểm tra định dạng)
                    if (imageURL == null || imageURL.isEmpty()) {
                        errorMessage += "Image URL cannot be empty.<br/>";
                    } else if (!imageURL.startsWith("http")) {
                        errorMessage += "Image URL must be a valid URL.<br/>";
                    }

                    try {
                        sold = Integer.parseInt(request.getParameter("sold"));
                        if (sold < 0) {
                            errorMessage += "Sold quantity must be a non-negative integer.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Sold quantity must be a valid integer.<br/>";
                    }

                    try {
                        discount = Integer.parseInt(request.getParameter("discount"));
                        if (discount < 0 || discount > 100) {
                            errorMessage += "Discount must be between 0 and 100.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Discount must be a valid integer.<br/>";
                    }

                    // Nếu có lỗi, gửi lại thông báo
                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/manager/create.do").forward(request, response);
                        return;
                    } else {
                        //tao doi tuong toy
                        Products product = new Products();

                        product.setName(name);
                        product.setDescription(description);
                        product.setPrice(price);
                        product.setStock(stock);
                        product.setCategoryID(categoryID);
                        product.setImageURL(imageURL);
                        product.setSold(sold);
                        product.setDiscount(discount);

                        //insert toy vao db
                        ProductFacade pf = new ProductFacade();
                        pf.create(product);
                        request.setAttribute("message", "Congratulations. You have successfully created!");
                        request.getRequestDispatcher("/manager/create.do").forward(request, response);
                        // bo break de chay tiep cancel de quay ve trang index
                        break;
                    }

                case "cancel":
                    //c1
                    //request.getRequestDispatcher("/index.jsp").forward(request, response);
                    //c2
                    request.getRequestDispatcher("/manager/index.do").forward(request, response);
                    break;

            }

        } catch (Exception ex) {
            //in chi tiet ngoai le
            ex.printStackTrace();
            //luu thong bao loi vao request
            request.setAttribute("message3", "Sorry. Registration failed!");
            //create(request, response);
            //cho hien lai view creare.jsp
            request.getRequestDispatcher("/manager/create.do").forward(request, response);

        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy tham chiếu của đối tượng session
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            ProductFacade pf = new ProductFacade();
            Products product = pf.read(productID);
            request.setAttribute("product", product);
        } catch (Exception e) {
        }

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void update_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String op = request.getParameter("op");
            switch (op) {
                case "update":
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    double price = 0;
                    int stock = 0;
                    int categoryID = 0;
                    String imageURL = request.getParameter("imageURL");
                    int sold = 0;
                    int discount = 0;
                    String errorMessage = "";

                    // Ràng buộc cho name
                    if (name == null || name.trim().isEmpty()) {
                        errorMessage += "Name is invalid.<br/>";
                    }

                    // Ràng buộc cho description
                    if (description == null || description.trim().isEmpty()) {
                        errorMessage += "Description is invalid.<br/>";
                    }
                    // Chuyển đổi dữ liệu với xử lý ngoại lệ
                    try {
                        price = Double.parseDouble(request.getParameter("price"));
                        if (price < 0) {
                            errorMessage += "Price must be a non-negative number.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Price must be a valid number.<br/>";
                    }

                    try {
                        stock = Integer.parseInt(request.getParameter("stock"));
                        if (stock < 0) {
                            errorMessage += "Stock must be a non-negative integer.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Stock must be a valid integer.<br/>";
                    }

                    try {
                        categoryID = Integer.parseInt(request.getParameter("categoryID"));
                        if (categoryID <= 0 || categoryID > 4) {
                            errorMessage += "Category ID must be from 1 - 4.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Category ID must be a valid integer.<br/>";
                    }

                    // Kiểm tra URL ảnh (có thể mở rộng kiểm tra định dạng)
                    if (imageURL == null || imageURL.isEmpty()) {
                        errorMessage += "Image URL cannot be empty.<br/>";
                    } else if (!imageURL.startsWith("http")) {
                        errorMessage += "Image URL must be a valid URL.<br/>";
                    }

                    try {
                        sold = Integer.parseInt(request.getParameter("sold"));
                        if (sold < 0) {
                            errorMessage += "Sold quantity must be a non-negative integer.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Sold quantity must be a valid integer.<br/>";
                    }

                    try {
                        discount = Integer.parseInt(request.getParameter("discount"));
                        if (discount < 0 || discount > 100) {
                            errorMessage += "Discount must be between 0 and 100.<br/>";
                        }
                    } catch (NumberFormatException e) {
                        errorMessage += "Discount must be a valid integer.<br/>";
                    }

                    // Nếu có lỗi, gửi lại thông báo
                    if (errorMessage.length() > 0) {
                        request.setAttribute("message3", errorMessage);
                        request.getRequestDispatcher("/manager/update.do").forward(request, response);
                        return;
                    } else {
                        //tao doi tuong toy
                        Products product = new Products();
                        product.setProductID(productID);
                        product.setName(name);
                        product.setDescription(description);
                        product.setPrice(price);
                        product.setStock(stock);
                        product.setCategoryID(categoryID);
                        product.setImageURL(imageURL);
                        product.setSold(sold);
                        product.setDiscount(discount);

                        //insert toy vao db
                        ProductFacade pf = new ProductFacade();
                        pf.update(product);
                        request.setAttribute("message", "Congratulations. You have successfully updated!");
                        request.getRequestDispatcher("/manager/update.do").forward(request, response);
                        // bo break de chay tiep cancel de quay ve trang index
                        break;
                    }

                case "cancel":

                    request.getRequestDispatcher("/manager/index.do").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            //in chi tiet ngoai le
            ex.printStackTrace();
            //luu thong bao loi vao request
            request.setAttribute("message3", "Can't update User into database.");
            //cho hien lai view edit.jsp
            request.getRequestDispatcher("/manager/update.do").forward(request, response);

        }
    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int productID = Integer.parseInt(request.getParameter("productID"));
            //xoa toy
            ProductFacade pf = new ProductFacade();
            pf.delete(productID);
            request.getRequestDispatcher("/manager/index.do").forward(request, response);

        } catch (Exception ex) {
            //in chi tiet ngoai le
            ex.printStackTrace();

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
