/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.manager.ConsumerManager;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ConsumerController", urlPatterns = {"/InsertConsumer", "/deleteConsumerPdf", "/viewConsumerPdf"})
public class ConsumerController extends HttpServlet {

    @EJB
    ConsumerManager consumerManager;
    String cons_no;
    String sec;
    String cons_nm1;
    String cons_nm2;
    String con_tp;
    String cons_ctg;
    String flat_type;
    String flat_no;
    String blk_no;
    double plot_size;
    int pipe_size;
    String reg_no;
    String conn_dt;
    String esti_no;
    double esti_amt;
    double secu;
    String esti_dt;
    double esti1_amt;
    double nodue_amt;
    String nodue_dt;
    String trans_nm;
    String trf;
    String trans_con_tp;
    String trans_cons_ctg;
    String trans_flat_type;
    String s_reg_no;
    String s_con_dt;
    String s_est_no;
    int s_est_amt;
    int s_secu;
    int s_est_pamt;
    String s_est_pdt;
    int s_nodue_amt;
    String s_nodue_dt;
    String pos_dt;
    String comp_dt;
    String cal_date;
    int intsec_no;
    int t = 0;
    String id;
    FileInputStream fis = null;
    BufferedInputStream bis = null;
    ServletOutputStream sos = null;
    ByteArrayOutputStream baos = null;
    String path;
    int ch;
    File file;
    int i = 0;
    int x;
    String sector;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String division = (String) session.getAttribute("division");
        try {
            if (request.getServletPath().equals("/InsertConsumer")) {
                if (!request.getParameter("cons_no").equals("")) {
                    cons_no = request.getParameter("cons_no1")+request.getParameter("cons_no");
                    System.out.println("insertconsumer"+cons_no);
                } else {
                    cons_no = null;
                }
                sector = request.getParameter("sec");

//                if(cons_no != null&& cons_no != "")
//                {
//                    int l=(int)cons_no.charAt(7);
//                    if(l>=65 && l<=90)
//                         x=Integer.parseInt(cons_no.substring(0,2));
//                    else
//                        x=Integer.parseInt(cons_no.substring(0,3));
//                     sector=Integer.toString(x);
//                    System.out.println("sector^^^^^^^^^^^^^^^^^"+sector);
//                    if(x<10){
//                        sector=Integer.toString(x);
//                        sector="0"+sector;
//                    }
//                }
                if (!request.getParameter("cons_nm1").equals("")) {
                    cons_nm1 = request.getParameter("cons_nm1").toUpperCase();

                } else {
                    cons_nm1 = null;
                }
                if (!request.getParameter("cons_nm2").equals("")) {
                    cons_nm2 = request.getParameter("cons_nm2").toUpperCase();

                } else {
                    cons_nm2 = null;


                }
                if (!request.getParameter("con_tp").equals("")) {
                    con_tp = request.getParameter("con_tp");

                } else {
                    con_tp = null;


                }
                if (!request.getParameter("cons_ctg").equals("")) {
                    cons_ctg = request.getParameter("cons_ctg");

                } else {
                    cons_ctg = null;


                }
                if (!request.getParameter("flat_type").equals("")) {
                    flat_type = request.getParameter("flat_type").toUpperCase();

                } else {
                    flat_type = null;


                }
                if (!request.getParameter("flat_no").equals("")) {
                    flat_no = request.getParameter("flat_no");

                } else {
                    flat_no = null;


                }
                if (!request.getParameter("blk_no").equals("")) {
                    blk_no = request.getParameter("blk_no");

                } else {
                    blk_no = null;


                }
                if (!request.getParameter("plot_size").equals("")) {
                    plot_size = Double.parseDouble(request.getParameter("plot_size"));

                } else {
                    plot_size = 0.0;


                }
                if (!request.getParameter("pipe_size").equals("")) {
                    pipe_size = Integer.parseInt(request.getParameter("pipe_size"));

                } else {
                    pipe_size = 0;


                }
                if (!request.getParameter("reg_no").equals("")) {
                    reg_no = request.getParameter("reg_no");

                } else {
                    reg_no = null;


                }
                if (!request.getParameter("conn_dt").equals("")) {
                    conn_dt = request.getParameter("conn_dt");

                } else {
                    conn_dt = "null";


                }
                if (!request.getParameter("esti_no").equals("")) {
                    esti_no = request.getParameter("esti_no");

                } else {
                    esti_no = null;


                }
                if (!request.getParameter("esti_amt").equals("")) {
                    esti_amt = Double.parseDouble(request.getParameter("esti_amt"));

                } else {
                    esti_amt = 0.0;


                }
                if (!request.getParameter("secu").equals("")) {
                    secu = Double.parseDouble(request.getParameter("secu"));

                } else {
                    secu = 0.0;


                }
                if (!request.getParameter("esti_dt").equals("")) {
                    esti_dt = request.getParameter("esti_dt");

                } else {
                    esti_dt = "null";


                }
                if (!request.getParameter("esti1_amt").equals("")) {
                    esti1_amt = Double.parseDouble(request.getParameter("esti1_amt"));

                } else {
                    esti1_amt = 0.0;


                }
                if (!request.getParameter("nodue_amt").equals("")) {
                    nodue_amt = Double.parseDouble(request.getParameter("nodue_amt"));

                } else {
                    nodue_amt = 0.0;


                }
                if (!request.getParameter("nodue_dt").equals("")) {
                    nodue_dt = request.getParameter("nodue_dt");

                } else {
                    nodue_dt = "null";

                    //Sewer details

                }
                if (!request.getParameter("s_reg_no").equals("")) {
                    s_reg_no = request.getParameter("s_reg_no");

                } else {
                    s_reg_no = null;


                }
                if (!request.getParameter("s_con_dt").equals("")) {
                    s_con_dt = request.getParameter("s_con_dt");

                } else {
                    s_con_dt = "null";


                }
                if (!request.getParameter("s_est_no").equals("")) {
                    s_est_no = request.getParameter("s_est_no");

                } else {
                    s_est_no = null;



                }
                if (!request.getParameter("s_est_amt").equals("")) {
                    s_est_amt = (Integer.parseInt(request.getParameter("s_est_amt")));

                } else {
                    s_est_amt = 0;



                }
                if (!request.getParameter("s_secu").equals("")) {
                    s_secu = (Integer.parseInt(request.getParameter("s_secu")));

                } else {
                    s_secu = 0;


                }
                if (!request.getParameter("s_est_pdt").equals("")) {
                    s_est_pdt = request.getParameter("s_est_pdt");

                } else {
                    s_est_pdt = "null";


                }
                if (!request.getParameter("s_est_pamt").equals("")) {
                    s_est_pamt = (Integer.parseInt(request.getParameter("s_est_pamt")));

                } else {
                    s_est_pamt = 0;


                }
                if (!request.getParameter("s_nodue_amt").equals("")) {
                    s_nodue_amt = (Integer.parseInt(request.getParameter("s_nodue_amt")));

                } else {
                    s_nodue_amt = 0;


                }
                if (!request.getParameter("s_nodue_dt").equals("")) {
                    s_nodue_dt = request.getParameter("s_nodue_dt");

                } else {
                    s_nodue_dt = "null";


                }
                if (!request.getParameter("pos_dt").equals("")) {
                    pos_dt = request.getParameter("pos_dt");

                } else {
                    pos_dt = "null";


                }
                if (!request.getParameter("comp_dt").equals("")) {
                    comp_dt = request.getParameter("comp_dt");

                } else {
                    comp_dt = "null";
                }
                if (!request.getParameter("trans_nm").equals("")) {
                    trans_nm = request.getParameter("trans_nm").toUpperCase();

                } else {
                    trans_nm = null;


                }
                trans_con_tp = (String) request.getParameter("t_con_type");
                if (trans_con_tp == null) {
                    trans_con_tp = "";

                }
                trans_cons_ctg = (String) request.getParameter("t_con_ctg");
                if (trans_cons_ctg == null) {
                    trans_cons_ctg = "";


                }
                if (!request.getParameter("t_flat_type").equals("")) {
                    trans_flat_type = request.getParameter("t_flat_type");

                } else {
                    trans_flat_type = null;

                }
                if (trans_nm != null && trans_flat_type != null) {
                    trf = (trans_con_tp + trans_flat_type + trans_cons_ctg).toUpperCase();
                } else {
                    trf = null;


                }
                if (!request.getParameter("cal_date").equals("")) {
                    cal_date = request.getParameter("cal_date");

                } else {
                    cal_date = "null";
                }
                String createdBy = (String) session.getAttribute("userid");
                Date createdDate = new Date();
                String userRole=(String) session.getAttribute("userrole");
                consumerManager.setConsumerDetail(division, cons_no, sector, cons_nm1, cons_nm2, con_tp, cons_ctg, flat_type, flat_no, blk_no, plot_size, pipe_size, reg_no, conn_dt, esti_no, esti_amt, secu, esti_dt, esti1_amt, nodue_amt, nodue_dt, pos_dt, comp_dt, trans_nm, trf, cal_date, createdBy, createdDate,userRole);
                consumerManager.setSewerDetail(division, cons_no, s_reg_no, s_con_dt, s_est_no, s_est_amt, s_secu, s_est_pdt, s_est_pamt, s_nodue_amt, s_nodue_dt, createdBy, createdDate);
                t = 2;
                request.setAttribute("t", t);
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/chl_mst/new_mst.jsp").forward(request, response);
            } else if (request.getServletPath().equals("/viewConsumerPdf")) {
                try {

                    fis = null;
                    bis = null;
                    baos = null;
                    sos = null;
                    i = 0;
                    sec = request.getParameter("sec").trim();

                    cons_no = request.getParameter("cons_no");


                    path = "/home/smp/Desktop/1" + "/SEC_" + sec.trim() + "/" + cons_no + ".tif";

                    file = new File(path);
                    int size = (int) file.length();
                    if (size > Integer.MAX_VALUE) {
                    }
                    if (file.exists()) {
                        fis = new FileInputStream(path);
                        bis = new BufferedInputStream(fis);
                        response.setContentLength(size);
                        response.setContentType("application/pdf");
                        sos = response.getOutputStream();
                        while ((ch = bis.read()) != -1) {
                            sos.write((byte) ch);
                        }
                        sos.flush();
                    } else {
                        t = 3;
                        request.setAttribute("t", t);
                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);
                }


            } else if (request.getServletPath().equals("/deleteConsumerPdf")) {

                try {
                    sec = request.getParameter("sec").trim();

                    cons_no = request.getParameter("cons_no");

                    path = "/home/smp/Desktop/1" + "/SEC_" + sec.trim() + "/" + cons_no + ".tif";

                    file = new File(path);
                    if (!file.exists()) {
                        t = 3;
                        request.setAttribute("t", t);
                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                        return;
                    }

                    if (!file.canWrite()) {
                        t = 4;
                        request.setAttribute("t", t);
                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                        return;

                    }
                    if (file.isDirectory()) {
                        String[] files = file.list();
                        if (files.length > 0) {
                            t = 5;
                            request.setAttribute("t", t);
                        }
                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                        return;
                    }

                    boolean success = file.delete();

                    if (!success) {
                        t = 6;
                        request.setAttribute("t", t);
                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                        return;
                    } else {
                        t = 7;
                        request.setAttribute("t", t);

                        request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);

                        return;

                    }

                } catch (Exception ex) {
                    System.out.println(ex);

                    t = 6;
                    request.setAttribute("t", t);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?&cons_no=" + cons_no).forward(request, response);


                }
            }


        } catch (Exception e) {
            t = 1;
            request.setAttribute("t", t);
            request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/chl_mst/new_mst.jsp").forward(request, response);

            System.out.println(e);
        } finally {
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
