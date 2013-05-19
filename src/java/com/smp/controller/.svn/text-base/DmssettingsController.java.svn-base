/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.entity.DiscountRate;
import com.smp.entity.HousingRate;
import com.smp.entity.LoginTab;
import com.smp.entity.Rates;
import com.smp.manager.DmssettingsManager;
import com.smp.session.DiscountRateFacade;
import com.smp.session.LoginTabFacade;
import com.smp.session.RatesFacade;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp
 */
@WebServlet(name = "DmssettingsController", urlPatterns = {"/setNewRate", "/insertHousingRate", "/populateHousingRate", "/editHousingRate", "/deleteHousingRate", "/showHousingRate", "/deleteUser", "/DmssettingsController", "/rates", "/insertRate", "/editRates", "/deleteRate", "/CreateUser", "/checkuser", "/viewUser", "/viewUserList", "/userList", "/editUser", "/searchType", "/searchCategory", "/searchDateFrom", "/pagination", "/SetDiscountRate", "/closeNewRate", "/discountRate", "/editDiscountRate", "/deleteDiscountRate", "/redirectEditPage"})
public class DmssettingsController extends HttpServlet {

    @EJB
    DmssettingsManager dmssettingsManager;
    @EJB
    RatesFacade ratesFacade;
    @EJB
    LoginTabFacade loginTabFacade;
    @EJB
    DiscountRateFacade discountRateFacade;
    HttpSession session;
    String connectionType;
    String connectionCategory;
    String flatType;
    String sector;
    String dateFrom;
    String dateTo;
    String minPlotSize;
    String maxPlotSize;
    String pipeSize;
    String rate;
    String connectionType_1;
    String connectionCategory_1;
    String sector_1;
    String flatType_1;
    String dateFrom_1;
    String dateTo_1;
    String plotSize_1;
    String pipeSize_1;
    String id;
    String user_id;
    String userid;
    String password;
    String cpassword;
    String firstname;
    String lastname;
    String userrole;
    String division;
    String createdby;
    String consumerNo;
    int flag = 0;
    int t = 0, t1 = 0, t2 = 0, t3 = 0, t4 = 0, t5 = 0, t6 = 0, t7 = 0;
    List<Rates> rateList = new ArrayList<Rates>();
    private String plotSize;
    String cons_no;
    String consumer_No;
    String userPassword;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            session = request.getSession();
            String xmlPath = getServletContext().getRealPath("") + "/NEWDMS/resources/jalutilXML/" + "jal.xml";
            String path = request.getServletPath();
            if (path.equals("/rates")) {
                connectionType_1 = request.getParameter("connectionType_1");
                connectionCategory_1 = request.getParameter("connectionCategory_1");
                flatType_1 = request.getParameter("flatType_1");
                sector_1 = request.getParameter("sector_1");
                dateFrom_1 = request.getParameter("dateFrom_1");
                plotSize_1 = request.getParameter("plotSize_1");
                pipeSize_1 = request.getParameter("pipeSize_1");
                rateList = new ArrayList<Rates>();
                rateList.clear();
                if (connectionType_1 == null) {
                    connectionType_1 = "";
                }
                if (connectionCategory_1 == null) {
                    connectionCategory_1 = "";
                }
                if (flatType_1 == null) {
                    flatType_1 = "";
                }
                if (sector_1 == null) {
                    sector_1 = "";
                }
                if (dateFrom_1 == null) {
                    dateFrom_1 = "";
                }

                if (plotSize_1 == null) {
                    plotSize_1 = "";
                }
                if (pipeSize_1 == null) {
                    pipeSize_1 = "";
                }
               // rateList = dmssettingsManager.searchByConnType(connectionType_1, connectionCategory_1, flatType_1, sector_1, dateFrom_1, plotSize_1, pipeSize_1);
                rateList=ratesFacade.findAll();
                session.setAttribute("rateList", rateList);
                if (!rateList.isEmpty()) {
                    session.setAttribute("rateListSize", rateList.size());
                } else {
                    session.setAttribute("rateListSize", 1);
                }

                List sectorsList = dmssettingsManager.sectorList(xmlPath);
                session.setAttribute("sectorsList", sectorsList);
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
                session.setAttribute("newRate", 0);
            } else if (path.equals("/setNewRate")) {
                session.setAttribute("newRate", 1);
//                getServletContext().setAttribute("s", 1);
//                getServletContext().setAttribute("e", 10);
            } else if (path.equals("/closeNewRate")) {

                session.setAttribute("newRate", 0);
            } else if (path.equals("/searchRates")) {
                session.setAttribute("rateList", rateList);

            } else if (path.equals("/editRates")) {
                id = request.getParameter("id");
                connectionType = request.getParameter("connectionType");
                connectionCategory = request.getParameter("connectionCategory");
                flatType = request.getParameter("flatType");
                sector = request.getParameter("sector");
                dateFrom = request.getParameter("dateFrom");
                minPlotSize = request.getParameter("minPlotSize");
                maxPlotSize = request.getParameter("maxPlotSize");
                pipeSize = request.getParameter("pipeSize");
                rate = request.getParameter("rate");
                connectionType_1 = request.getParameter("connectionType_1");
                connectionCategory_1 = request.getParameter("connectionCategory_1");
                dateFrom_1 = request.getParameter("dateFrom_1");
                plotSize_1 = request.getParameter("plotSize_1");
                pipeSize_1 = request.getParameter("pipeSize_1");
                rateList = new ArrayList<Rates>();
                rateList.clear();
                rateList = dmssettingsManager.editRates(id, connectionType, connectionCategory, flatType, sector, dateFrom, minPlotSize, maxPlotSize, pipeSize, rate, connectionType_1, connectionCategory_1, dateFrom_1, plotSize_1, pipeSize_1);
                session.setAttribute("newRate", 0);
                session.setAttribute("rateList", rateList);
                session.setAttribute("rateListSize", rateList.size());
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
                t4 = 1;
                session.setAttribute("t4", t4);

            } else if (path.equals("/insertRate")) {
                connectionType = request.getParameter("connectionType2");
                connectionCategory = request.getParameter("connectionCategory2");
                flatType = request.getParameter("flatType2");
                sector = request.getParameter("sector2");
                dateFrom = request.getParameter("dateFrom2");
                minPlotSize = request.getParameter("minPlotSize2");
                maxPlotSize = request.getParameter("maxPlotSize2");
                pipeSize = request.getParameter("pipeSize2");
                rate = request.getParameter("rate2");
                connectionType_1 = request.getParameter("connectionType_1");
                connectionCategory_1 = request.getParameter("connectionCategory_1");
                dateFrom_1 = request.getParameter("dateFrom_1");
                plotSize_1 = request.getParameter("plotSize_1");
                pipeSize_1 = request.getParameter("pipeSize_1");
                rateList = new ArrayList<Rates>();
                rateList.clear();
                rateList = dmssettingsManager.setRates(connectionType, connectionCategory, flatType, sector, dateFrom, minPlotSize, maxPlotSize, pipeSize, rate, connectionType_1, connectionCategory_1, dateFrom_1, plotSize_1, pipeSize_1);
                t3 = 1;
                session.setAttribute("t3", t3);

                session.setAttribute("newRate", 0);
                session.setAttribute("rateList", rateList);
                if (!rateList.isEmpty()) {
                    session.setAttribute("rateListSize", rateList.size());
                } else {
                    session.setAttribute("rateListSize", 1);
                }
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
            } else if (path.equals("/deleteRate")) {
                id = request.getParameter("id");
                connectionType_1 = request.getParameter("connectionType_1");
                connectionCategory_1 = request.getParameter("connectionCategory_1");
                flatType_1 = request.getParameter("flatType_1");
                sector_1 = request.getParameter("sector_1");
                dateFrom_1 = request.getParameter("dateFrom_1");
                plotSize_1 = request.getParameter("maxPlotSize_1");
                pipeSize_1 = request.getParameter("pipeSize_1");
                rateList = new ArrayList<Rates>();
                rateList.clear();
                rateList = dmssettingsManager.deleteRates(id, connectionType_1, connectionCategory_1, flatType_1, sector_1, dateFrom_1, plotSize_1, pipeSize_1);
                session.setAttribute("newRate", 0);
                session.setAttribute("rateList", rateList);
                if (!rateList.isEmpty()) {
                    session.setAttribute("rateListSize", rateList.size());
                } else {
                    session.setAttribute("rateListSize", 1);
                }
                // session.setAttribute("rateListSize", rateList.size());
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
                t5 = 1;
                session.setAttribute("t5", t5);
            } else if (path.equals("/searchType")) {
                connectionType = request.getParameter("connection_type");
                connectionCategory = request.getParameter("connection_category");
                flatType = request.getParameter("flat_type");
                sector = request.getParameter("sector");
                dateFrom = request.getParameter("date_from");
                plotSize = request.getParameter("plotSize");
                pipeSize = request.getParameter("pipe_size");
                rateList = new ArrayList<Rates>();
                rateList.clear();
                rateList = dmssettingsManager.searchByConnType(connectionType, connectionCategory, flatType, sector, dateFrom, plotSize, pipeSize);
                session.setAttribute("rateList", rateList);
                if (!rateList.isEmpty()) {
                    session.setAttribute("rateListSize", rateList.size());
                } else {
                    session.setAttribute("rateListSize", 1);
                }

                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
            } else if (path.equals("/CreateUser")) {
                createdby = (String) session.getAttribute("userid");
                userid = request.getParameter("userid");
                password = request.getParameter("password");
                firstname = request.getParameter("firstname");
                lastname = request.getParameter("lastname");
                userrole = request.getParameter("userrole");
                division = request.getParameter("division");
                dmssettingsManager.createUser(userid, password, firstname, lastname, userrole, createdby, division);
                t1 = 1;
                request.setAttribute("t1", t1);
                response.sendRedirect(request.getContextPath() + "/viewUser");
            } else if (path.equals("/checkuser")) {

                userid = request.getParameter("userid");
                flag = dmssettingsManager.checkUser(userid);
                out.println(flag);

            } else if (path.equals("/viewUser")) {

                List<LoginTab> userList = loginTabFacade.findAll();
                request.setAttribute("userList", userList);
                request.setAttribute("userLists", userList.size());
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/admin/view_user.jsp").forward(request, response);

            } else if (path.equals("/viewUserList")) {
                List<LoginTab> userList = loginTabFacade.findAll();
                request.setAttribute("userList", userList);
                request.setAttribute("userLists", userList.size());

            } else if (path.equals("/userList")) {
                userid = request.getParameter("id");
                session.setAttribute("userList", dmssettingsManager.getUserDetail(userid));
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/admin/edit.jsp").forward(request, response);

            } else if (path.equals("/editUser")) {
                System.out.println("edit user........");

               // createdby = (String) session.getAttribute("userid");
                userid = request.getParameter("userId");
                userPassword = request.getParameter("editPassword");
                firstname = request.getParameter("firstName");
                lastname = request.getParameter("lastName");
                userrole = request.getParameter("userRole");
                division = request.getParameter("division");
                dmssettingsManager.editUser(userid, userPassword, firstname, lastname, userrole, division);
                t = 1;
                session.setAttribute("t", t);
                response.sendRedirect(request.getContextPath()+"/viewUser");
                //request.getServletContext().getRequestDispatcher("/viewUser").forward(request, response);

            } else if (path.equals("/deleteUser")) {
                userid = request.getParameter("id");
                dmssettingsManager.deleteUser(userid);
                t2 = 1;
                session.setAttribute("t2", t2);
                request.getServletContext().getRequestDispatcher("/viewUser").forward(request, response);
            } else if (path.equals("/pagination")) {
                String start = request.getParameter("s");
                String end = request.getParameter("e");
                session.setAttribute("s", Integer.valueOf(start));
                session.setAttribute("e", Integer.valueOf(end));
            } else if (path.equals("/discountRate")) {
                List<DiscountRate> discountRateList = new ArrayList<DiscountRate>();
                discountRateList = discountRateFacade.findAll();
                getServletContext().setAttribute("discountRateList", discountRateList);
                response.sendRedirect(request.getContextPath()+"/NEWDMS/jsppages/dmssettings/setDiscountRate.jsp?discountrate=0");

            } else if (path.equals("/SetDiscountRate")) {

                dateFrom = request.getParameter("dateFrom");
                dateTo = request.getParameter("dateTo");
                rate = request.getParameter("rate");
                dmssettingsManager.setDiscountRate(dateFrom, dateTo, rate);
                t1 = 1;
                request.setAttribute("t1", t1);
                request.getServletContext().getRequestDispatcher("/discountRate").forward(request, response);

            } else if (path.equals("/editDiscountRate")) {

                id = request.getParameter("id");
                dateFrom = request.getParameter("date_From");
                dateTo = request.getParameter("date_To");
                rate = request.getParameter("Rate");
                dmssettingsManager.editDiscountRate(id, dateFrom, dateTo, rate);
                t6 = 1;
                request.setAttribute("t6", t6);
                request.getServletContext().getRequestDispatcher("/discountRate").forward(request, response);
            } else if (path.equals("/deleteDiscountRate")) {
                id = request.getParameter("id");
                dmssettingsManager.deleteDiscountRate(id);
                t7 = 1;
                request.setAttribute("t7", t7);
                request.getServletContext().getRequestDispatcher("/discountRate").forward(request, response);
            } else if (path.equals("/insertHousingRate")) {

                consumerNo = request.getParameter("consumerNo");
                dateFrom = request.getParameter("dateFrom");
                dateTo = request.getParameter("dateTo");
                rate = request.getParameter("rate");
                dmssettingsManager.insertHousingBill(consumerNo, dateFrom, dateTo, rate);
                request.getServletContext().getRequestDispatcher("/showHousingRate?consumerNo=" + consumerNo).forward(request, response);

            } else if (path.equals("/showHousingRate")) {
                consumerNo = request.getParameter("consumerNo");
                List<HousingRate> housingRate = dmssettingsManager.housingRateList(consumerNo);
                session.setAttribute("housingRateList", housingRate);
            } else if (path.equals("/populateHousingRate")) {

                cons_no = request.getParameter("cons_no");
                List<HousingRate> housingRate = dmssettingsManager.housingRateList(cons_no);
                session.setAttribute("housingRateList", housingRate);
            } else if (path.equals("/editHousingRate")) {

                id = request.getParameter("id");
                consumer_No = request.getParameter("consumer_No");
                dateFrom = request.getParameter("date_From");
                dateTo = request.getParameter("date_To");
                rate = request.getParameter("rates");
                dmssettingsManager.editHousingRate(id, dateFrom, dateTo, rate);
                request.getServletContext().getRequestDispatcher("/populateHousingRate?cons_no=" + consumer_No).forward(request, response);
            } else if (path.equals("/deleteHousingRate")) {

                id = request.getParameter("id");
                consumer_No = request.getParameter("consumer_No");
                dmssettingsManager.deleteHousingRate(id);
                request.getServletContext().getRequestDispatcher("/populateHousingRate?cons_no=" + consumer_No).forward(request, response);

            } else if (path.equals("/redirectEditPage")) {
                System.out.println("hello......... " + request.getParameter("userId"));
                LoginTab userList = loginTabFacade.find(request.getParameter("userId"));
                request.setAttribute("userList", userList);
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/admin/edit.jsp").forward(request, response);

            }


        } catch (Exception e) {
            t = 2;
            session.setAttribute("t", t);
            t1 = 2;
            request.setAttribute("t1", t1);
            t2 = 2;
            session.setAttribute("t2", t2);

            t3 = 2;
            session.setAttribute("t3", t3);
            t4 = 2;
            session.setAttribute("t4", t4);
            t5 = 2;
            session.setAttribute("t5", t5);
            t6 = 2;
            request.setAttribute("t6", t6);
            t7 = 2;
            request.setAttribute("t7", t7);
            e.printStackTrace();
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
