/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.entity.CessRate;
import com.smp.entity.InterestRates;
import com.smp.manager.InterestRateManager;
import com.smp.session.CessRateFacade;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.PersistenceContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.*;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "InterestRateController", urlPatterns = {"/InterestRateController", "/InsertInterestRate","/closeNewInterestRate","/EditInterestRate", "/DeleteInterestRate", "/CessRateController", "/InsertCessRate", "/EditCessRate", "/DeleteCessRate"})
public class InterestRateController extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    @EJB
    InterestRateManager interestRateManager;
    private String dateto;
    int t = 0;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession();
        try {
            String path = request.getServletPath();

            if (path.equals("/InterestRateController")) {
                List<InterestRates> rateList = interestRateManager.findRateList();
                session.setAttribute("interestRateList", rateList);
                response.sendRedirect(request.getContextPath()+"/NEWDMS/jsppages/dmssettings/setInterestRate.jsp?newInterestRate=0");

            } else if (path.equals("/InsertInterestRate")) {
                String datefrom = "";
                String dateto = "";
                datefrom = request.getParameter("date_From");
                dateto = request.getParameter("date_To");
                String rate = request.getParameter("rates");
                DateFormat formatter;
                Date dateFrom;
                Date dateTo;
                formatter = new SimpleDateFormat("dd/MM/yy");
                dateFrom = (Date) formatter.parse(datefrom);
                dateTo = (Date) formatter.parse(dateto);
                interestRateManager.createInterestRates(dateFrom, dateTo, Double.valueOf(rate));
                List<InterestRates> rateList = interestRateManager.findRateList();

                session.setAttribute("interestRateList", rateList);
                request.getServletContext().getRequestDispatcher("/InterestRateController").forward(request, response);
            } else if (path.equals("/EditInterestRate")) {
                String datefrom = "";
                String dateto = "";
                String id = request.getParameter("id");
                datefrom = request.getParameter("dateFrom");
                dateto = request.getParameter("dateTo");
                String rate = request.getParameter("rate");
                DateFormat formatter;
                Date dateFrom;
                Date dateTo;
                formatter = new SimpleDateFormat("dd/MM/yy");
                dateFrom = (Date) formatter.parse(datefrom);
                dateTo = (Date) formatter.parse(dateto);
                interestRateManager.editInterestRates(id, dateFrom, dateTo, Double.valueOf(rate));
                List<InterestRates> rateList = interestRateManager.findRateList();
                session.setAttribute("interestRateList", rateList);
                request.getServletContext().getRequestDispatcher("/InterestRateController").forward(request, response);
            } else if (path.equals("/DeleteInterestRate")) {
                String id = request.getParameter("id");
                interestRateManager.deleteInterestRates(id);
                List<InterestRates> rateList = interestRateManager.findRateList();
                session.setAttribute("interestRateList", rateList);
                request.getServletContext().getRequestDispatcher("/InterestRateController").forward(request, response);
            } else if(path.equals("/closeNewInterestRate")){
                response.sendRedirect(request.getContextPath()+"/NEWDMS/jsppages/dmssettings/setInterestRate.jsp?newInterestRate=0");
            }
            else if (path.equals("/CessRateController")) {
                List<CessRate> cessrateList = interestRateManager.findCessRateList();
                System.out.println("Size of cess rate list" + cessrateList.size());
                session.setAttribute("cessRateList", cessrateList);
                response.sendRedirect(request.getContextPath()+"/NEWDMS/jsppages/dmssettings/setCessRate.jsp?chl=0");
            } else if (path.equals("/InsertCessRate")) {
                System.out.println("I am inside insertcessrate");

                String datefrom = "";
                String dateto = "";
                String conType=request.getParameter("conType1");
                datefrom = request.getParameter("dateFrom1");
                dateto = request.getParameter("dateTo1");
                String pipeSize=request.getParameter("pipeSize1");
                String rate = request.getParameter("rate1");
                DateFormat formatter;
                Date dateFrom;
                Date dateTo;
                formatter = new SimpleDateFormat("dd/MM/yy");
                dateFrom = (Date) formatter.parse(datefrom);
                dateTo = (Date) formatter.parse(dateto);
                interestRateManager.createCessRate(conType,dateFrom, dateTo,pipeSize, Double.valueOf(rate));
                List<CessRate> cessrateList = interestRateManager.findCessRateList();
                 t = 2;
                request.setAttribute("t", t);

                session.setAttribute("cessRateList", cessrateList);
                request.getServletContext().getRequestDispatcher("/CessRateController").forward(request, response);
            } else if (path.equals("/EditCessRate")) {
                String datefrom = "";
                String dateto = "";
                String id = request.getParameter("id");
                String conType=request.getParameter("conType");
                datefrom = request.getParameter("dateFrom");
                dateto = request.getParameter("dateTo");
                String rate = request.getParameter("rate");
                String pipeSize=request.getParameter("pipeSize");
                DateFormat formatter;
                Date dateFrom;
                Date dateTo;
                formatter = new SimpleDateFormat("dd/MM/yy");
                dateFrom = (Date) formatter.parse(datefrom);
                dateTo = (Date) formatter.parse(dateto);
                interestRateManager.editCessRate(id,conType, dateFrom, dateTo,pipeSize, Double.valueOf(rate));
                List<CessRate> cessrateList = interestRateManager.findCessRateList();
                 t = 3;
                request.setAttribute("t", t);

                session.setAttribute("cessRateList", cessrateList);
                request.getServletContext().getRequestDispatcher("/CessRateController").forward(request, response);
            } else if (path.equals("/DeleteCessRate")) {
                String id = request.getParameter("id");
                interestRateManager.deleteCessRate(id);
                List<CessRate> cessrateList = interestRateManager.findCessRateList();
                 t = 4;
                request.setAttribute("t", t);
               
                session.setAttribute("cessRateList", cessrateList);
                request.getServletContext().getRequestDispatcher("/CessRateController").forward(request, response);

            } else {
                response.sendRedirect("index.jsp");
            }


        } catch (Exception e) {
             t = 1;
                request.setAttribute("t", t);

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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(InterestRateController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(InterestRateController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
