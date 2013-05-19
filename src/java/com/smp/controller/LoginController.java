/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.entity.LoginTab;
import com.smp.manager.LoginManager;
import com.smp.session.LoginTabFacade;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 *
 * @author smp-06
 */
@WebServlet(name = "Login", urlPatterns = {"/Login", "/Logout", "/ChangePassword"})
public class LoginController extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    LoginManager loginManager;
    @EJB
    LoginTabFacade loginTabFacade;
    HttpSession session;
    int validationFlag = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DateFormat dateFormat = new SimpleDateFormat("MMM dd , yyyy");

        try {
            String path = request.getServletPath();
            if (path.equals("/Login")) {
                String name = request.getParameter("userName");
                String password = request.getParameter("password");
                int flag = loginManager.validateUser(name, password);
                if (flag == 1) {
                    List<LoginTab> loginTabList = new ArrayList<LoginTab>();
                    loginTabList = loginManager.find(name, password);
                    LoginTab loginTab = loginTabList.get(0);
                    Date lastLoginDate = loginTab.getLastloginDt();
                    if (lastLoginDate == null) {                      
                        lastLoginDate = new Date();
                    }

                    loginTab.setLastloginDt(new Date());
                    loginTabFacade.edit(loginTab);
                    System.out.println("username in login controller" + loginTabList.get(0).getFirstName());
                    session = request.getSession(true);
                    session.setAttribute("userid", name);
                     session.setAttribute("application", "NEWDMS");
                    session.setAttribute("userrole", loginTabList.get(0).getUserrole());
                    session.setAttribute("division", loginTabList.get(0).getDivision());
                    session.setAttribute("lastLoginDate", dateFormat.format(lastLoginDate));
//                     File f =new File("/home/smp-06/"+name+".log");
//                     FileHandler fh=null;
//                     if(!f.exists())
//                     {
//                     f.createNewFile();
//                     }
//                     fh=new FileHandler("/home/smp-06/"+name+".log", true);
//                     Logger l=Logger.getLogger(name);
//                    LogRecord logRecord=new LogRecord(Level.INFO, "Login with "+name +" from "+request.getRemoteAddr());
//                    fh.publish(logRecord);
//
//                     l.addHandler(fh);
//                     fh.close();
                    response.sendRedirect(request.getContextPath() + "/SearchController");
                } else {
                    validationFlag = 1;
                    request.setAttribute("validationFlag", validationFlag);
                    request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                }
            } else if (path.equals("/Logout")) {
                session.removeAttribute("userid");
                session.removeAttribute("userrole");
                session.removeAttribute("division");
                session.removeAttribute("NEWDMS");
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath()+"/NEWDMS");
            } else if (path.equals("/ChangePassword")) {
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                String userId = (String) session.getAttribute("userid");

                int changePassFlag = 1;
                try {
                    changePassFlag = loginManager.changePassword(userId, oldPassword, newPassword, confirmPassword);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("changePassFlag", changePassFlag);
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/common/ch_pass.jsp").forward(request, response);
            }

        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
