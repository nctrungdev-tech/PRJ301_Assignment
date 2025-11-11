/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import DAO.OrderFacade;
import DAO.ProductFacade;
import entity.Cart;
import entity.Item;
import entity.OrderDetails;
import entity.Orders;
import entity.Products;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TLStore
 */
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

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
            case "checkout":
                checkout(request, response);
                break;
            case "search":
                search(request, response);
                break;
            case "category":
                category(request, response);
                break;
            case "product":
                product(request, response);
                break;
            case "store":
                store(request, response);
                break;
            case "store_handler":
                store_handler(request, response);
                break;
            case "price":
                price(request, response);
                break;
            
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductFacade pf = new ProductFacade();

        List<Products> listN = pf.getNewProduct();
        List<List<Products>> List18Sold = pf.getTop18Sold();

        request.setAttribute("listN", listN);
        request.setAttribute("list1", List18Sold.size() > 0 ? List18Sold.get(0) : new ArrayList<>());
        request.setAttribute("list2", List18Sold.size() > 1 ? List18Sold.get(1) : new ArrayList<>());
        request.setAttribute("list3", List18Sold.size() > 2 ? List18Sold.get(2) : new ArrayList<>());
        request.setAttribute("list4", List18Sold.size() > 3 ? List18Sold.get(3) : new ArrayList<>());
        request.setAttribute("list5", List18Sold.size() > 4 ? List18Sold.get(4) : new ArrayList<>());
        request.setAttribute("list6", List18Sold.size() > 5 ? List18Sold.get(5) : new ArrayList<>());
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void checkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy tham chiếu của đối tượng session

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void search(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        int categoryID = Integer.parseInt(request.getParameter("category"));
        ProductFacade pf = new ProductFacade();
        List<Products> list = pf.searchByNameAndCategory(search, categoryID);

        request.setAttribute("list", list);
        request.setAttribute("search", search);
        request.setAttribute("categoryID", categoryID);
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

    }
    
    protected void price(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        ProductFacade pf = new ProductFacade();
        List<Products> list = null;
        String op = request.getParameter("op");
        switch(op){
            case "asc":
                request.setAttribute("name", "Product list ascending");
                list= pf.getPriceAsc();
                break;
            case "desc":
                request.setAttribute("name", "Product list descending");
                list= pf.getPriceDesc();
                break;
        }


        request.setAttribute("list", list);

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

    }

    protected void category(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        ProductFacade pf = new ProductFacade();
        List<Products> listC = pf.getProductByCategoryId(categoryId);

        request.setAttribute("listC", listC);

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

    }

    protected void product(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //lấy tham chiếu của đối tượng session
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductFacade pf = new ProductFacade();
            Products product = pf.read(id);
            request.setAttribute("product", product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void store(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductFacade pf = new ProductFacade();
    List<List<Products>> List18Sold = pf.getTop18Sold();
    request.setAttribute("list1", List18Sold.size() > 0 ? List18Sold.get(0) : new ArrayList<>());

    // Chỉ lấy sản phẩm mặc định nếu không có tham số nào từ request
    if (request.getParameter("min") == null && request.getParameter("max") == null) {
        List<Products> defaultProducts = pf.getProductStore(4, 0, 3000); // Tải 6 sản phẩm đầu tiên
        request.setAttribute("allProducts", defaultProducts);
    }
    request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void store_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //int category = Integer.parseInt(request.getParameter("category"));
        //đổi thằng String thành int cho dễ chạy thằng category
        String[] selectedCategoryParams = request.getParameterValues("category");
        int[] selectedCategories = null;
        if (selectedCategoryParams != null) {
            selectedCategories = new int[selectedCategoryParams.length];
            for (int i = 0; i < selectedCategoryParams.length; i++) {
                selectedCategories[i] = Integer.parseInt(selectedCategoryParams[i]);
            }
        }
        double min = Double.parseDouble(request.getParameter("min"));
        double max = Double.parseDouble(request.getParameter("max"));

        ProductFacade pf = new ProductFacade();
        //top3 selling
        List<List<Products>> List18Sold = pf.getTop18Sold();
        request.setAttribute("list1", List18Sold.size() > 0 ? List18Sold.get(0) : new ArrayList<>());
        //screen store
        List<Products> allProducts = new ArrayList<>();
        if (selectedCategories != null) {
            // Duyệt qua các category đã chọn
            for (int category : selectedCategories) {
                List<Products> listS = pf.getProductStore(category, min, max);
                allProducts.addAll(listS);
            }
        }
    
        // Lưu danh sách sản phẩm tổng hợp vào request
        request.setAttribute("allProducts", allProducts);

        request.setAttribute("min", min);
        request.setAttribute("max", max);
        request.setAttribute("selectedCategories", selectedCategories);
        request.getRequestDispatcher("/product/store.do").forward(request, response);
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
