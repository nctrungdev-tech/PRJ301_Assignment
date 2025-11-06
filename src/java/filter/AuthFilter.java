package filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*") // chạy cho tất cả các request
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // Cho phép các trang không cần đăng nhập
        boolean loginRequest = uri.contains("/user/login.do") 
                            || uri.contains("/user/login_handler.do")
                            || uri.contains("/user/create.do")
                            || uri.contains("/user/create_handler.do")
                            || uri.endsWith(".css") 
                            || uri.endsWith(".js") 
                            || uri.endsWith(".jpg") 
                            || uri.endsWith(".png");

        if (loggedIn || loginRequest) {
            // Cho phép đi tiếp đến servlet
            chain.doFilter(request, response);
        } else {
            // Chưa đăng nhập → quay về login
            res.sendRedirect(req.getContextPath() + "/user/login.do");
        }
    }
}
