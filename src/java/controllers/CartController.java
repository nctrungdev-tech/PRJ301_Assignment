/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.ProductFacade;
import entity.Cart;
import entity.Item;
import entity.Products;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
            case "index":
                index(request, response);
                break;
            case "add":
                add(request, response);
                break;
            case "addWish":
                addWish(request, response);
                break;
            case "remove":
                //xoa cart
                remove(request, response);
                break;
            case "removeWish":
                removeWish(request, response);
                break;
            case "empty":
                //xoa sach cart
                empty(request, response);
                break;
            case "update":
                //cập nhật cart
                update(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            //đọc product
            ProductFacade pf = new ProductFacade();
            Products product = pf.read(id);
            //tao item 
            Item item = new Item(product, quantity);
            //lấy cart từ session
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                //nếu trong sesion chưa có cảrt thì tạo cart mới
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            //them item vao cart
            cart.add(item);

            int totalQuantity = 0;
            for (Item cartItem : cart.getItems()) {
                totalQuantity += cartItem.getQuantity();

            }
            cart.setTotalQuantity(totalQuantity);
            //cho hiện lại trang chủ
//            request.getRequestDispatcher("/cart/index.do").forward(request, response);
            response.getWriter().write(String.valueOf(totalQuantity));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void addWish(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            //đọc product
            ProductFacade pf = new ProductFacade();
            Products product = pf.read(id);
            //tao item 
            Item item = new Item(product, quantity);
            //lấy cart từ session
            HttpSession session = request.getSession();
            Cart cartWish = (Cart) session.getAttribute("cartWish");
            if (cartWish == null) {
                //nếu trong sesion chưa có cảrt thì tạo cart mới
                cartWish = new Cart();
                session.setAttribute("cartWish", cartWish);
            }
            //them item vao cart
            cartWish.add(item);

            int totalQuantity = 0;

            for (Item cartItem : cartWish.getItems()) {
                totalQuantity += cartItem.getQuantity();

            }
            cartWish.setTotalQuantity(totalQuantity);
            int count = cartWish.getCount();
            response.getWriter().write(String.valueOf(count));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void empty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //nếu trong sesion chưa có cảrt thì tạo cart mới
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        //xóa giỏ hàng
        cart.empty();
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
    }

    protected void remove(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //nếu trong sesion chưa có cảrt thì tạo cart mới
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        //xóa giỏ hàng
        cart.remove(id);
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
    }

    protected void removeWish(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Cart cartWish = (Cart) session.getAttribute("cartWish");
        if (cartWish == null) {
            //nếu trong sesion chưa có cảrt thì tạo cart mới
            cartWish = new Cart();
            session.setAttribute("cartWish", cartWish);
        }
        //xóa giỏ hàng
        cartWish.remove(id);
        int totalQuantity = 0;
        for (Item cartItem : cartWish.getItems()) {
            totalQuantity += cartItem.getQuantity();

        }
        cartWish.setTotalQuantity(totalQuantity);
        request.getRequestDispatcher("/product/index.do").forward(request, response);
    }
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy thông tin từ client
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        //lấy cart từ session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            //nếu trong session chưa có cart thì tạo cart mới
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        //cập nhật cart
        cart.update(id, quantity);
        //cho hiện trang /cart/index.do
        request.getRequestDispatcher("/cart/index.do").forward(request, response);
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
