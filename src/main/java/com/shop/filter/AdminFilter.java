package com.shop.filter;

import com.shop.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/admin/*", "/deleteProduct", "/addProduct"}) // ការពារ URL ទាំងនេះ
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // ពិនិត្យមើលថាតើមាន Login ហើយត្រូវជា ADMIN ឬទេ
        if (user != null && "ADMIN".equalsIgnoreCase(user.getRole())) {
            chain.doFilter(request, response); // អនុញ្ញាតឲ្យឆ្លងកាត់
        } else {
            // បើគ្មានសិទ្ធិទេ បង្វែរទៅ Login ឬទំព័រ Products
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }
}