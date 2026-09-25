package com.shop.filter;

import com.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // ១. អនុញ្ញាតឱ្យរត់ Public Request (Login, Register, CSS, JS, Images)
        boolean isPublicPath = path.equals("/login") 
                            || path.equals("/register") 
                            || path.startsWith("/css/") 
                            || path.startsWith("/js/") 
                            || path.startsWith("/images/");

        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // ២. បើមិនទាន់ Login ទេ -> Redirect ទៅកាន់ Login
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ៣. បើ User ធម្មតា (CUSTOMER) ព្យាយាមចូល Admin Routes -> ហាមឃាត់
        if (path.startsWith("/admin") && !"ADMIN".equalsIgnoreCase(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/products?error=unauthorized");
            return;
        }

        chain.doFilter(request, response);
    }
}