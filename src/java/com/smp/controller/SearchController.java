/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.dms.BillUtility;
import com.smp.entity.Billrepository;
import com.smp.entity.Master;
import com.smp.entity.Master1;
import com.smp.entity.Master2;
import com.smp.entity.Master3;

import com.smp.entity.Sewerdetails;

import com.smp.jal.ConvertToDate;
import com.smp.manager.SearchManager;
import com.smp.session.Master1Facade;
import com.smp.session.Master2Facade;
import com.smp.session.Master3Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp-06
 */
@WebServlet(name = "SearchController", urlPatterns = {"/AuthoriseMasterChallan", "/searchMaster", "/searchChallan", "/ManagerController", "/AuthoriseController", "/AuthoriseChallan", "/SetValues", "/SearchController", "/GetBlocks", "/ConsumerDetails", "/UpdateConsumerDetails", "/DeleteConsumerDetails", "/UpdateSewerDetails", "/SelectSector", "/insertChallan", "/updateChallan", "/deleteChallan"})
public class SearchController extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    SearchManager searchManager;
    @EJB
    Master1Facade master1Facade;
    @EJB
    Master2Facade master2Facade;
    @EJB
    Master3Facade master3Facade;
    String flatNo;
    String block;
    String cons_no1;
    String startIndex;
    ConvertToDate convertToDate = new ConvertToDate();
    String bl_per_fr;
    String bl_per_to;
    String due_dt;
    String bill_amt;
    String surcharge;
    String paid_amt;
    String pay_date;
    String arrear;
    String credit;
    String recp_no;
    String dis_cd;
    String noc;
    String rmc;
    String chlsecu;
    String t_fee;
    String css;
    String bnk_cd;
    String br_nm;
    String row_id;
    String cons_no;
    String sec;
    String flat_no;
    String blk;
    int t = 0, t1 = 0, t2;
    Boolean flag = true;
    String id;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String division = (String) session.getAttribute("division");
        String username = (String) session.getAttribute("userid");
        BillUtility billUtility = new BillUtility();
        try {
            String path = request.getServletPath();
            String xmlPath = getServletContext().getRealPath("") + "/NEWDMS/resources/jalutilXML/" + "jal.xml";
            if (path.equals("/SearchController")) {

                List<String> sectorList = searchManager.getSectors(division, xmlPath);
                session.setAttribute("sectorList", sectorList);
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/search.jsp").forward(request, response);
            } else if (path.equals("/AuthoriseChallan")) {
                Master master = null;

                System.out.println(" AUTHORISE CHALLAN METHOD");
                flag = true;

                cons_no1 = request.getParameter("cons_no1").trim();
                id = request.getParameter("id").trim();

                Date createdDate = new Date();
                //   List masterList = new ArrayList();
                List challanList = new ArrayList();
                flag = searchManager.getAuthoriseChallans(division, cons_no1, id, username, createdDate);
                System.out.println(" flag=" + flag);
                challanList = em.createNamedQuery("Challan" + division + ".findByConsNo").setParameter("consNo", cons_no1).getResultList();

                List masterList = new ArrayList();
                masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", cons_no1).getResultList();
                if (!masterList.isEmpty()) {
                    master = (Master) masterList.get(0);
                }
                session.setAttribute("consumerDetail", master);
                session.setAttribute("challanDetail", challanList);



                if (flag == false) {
                    System.out.println("in else if flag=" + flag);
                    t1 = 3;
                    request.setAttribute("t1", t1);

                }
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp").forward(request, response);

            } else if (path.equals("/AuthoriseController")) {
                Master master = null;
                cons_no = request.getParameter("cons_no");
                Date createdDate = new Date();
                List masterList = new ArrayList();
                masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", cons_no).getResultList();

                //   Master master= (Master)em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
                if (!masterList.isEmpty()) {
                    master = (Master) masterList.get(0);
                    master.setStatus("A");
                    System.out.println(" flag=" + master.getStatus());

                    master.setAuthoriseBy(username);
                    System.out.println(" flag=" + master.getAuthoriseBy());

                    master.setAuthorizedDate(createdDate);
                    System.out.println(" flag=" + master.getAuthorizedDate());
                    if (division.equals("1")) {
                        master1Facade.edit((Master1) master);
                    } else if (division.equals("2")) {
                        master2Facade.edit((Master2) master);
                    } else if (division.equals("3")) {
                        master3Facade.edit((Master3) master);
                    }

                }
//                masterList = searchManager.getAuthoriseMasters(division, cons_no, username,createdDate);
                session.setAttribute("consumerDetail", master);
                // session.setAttribute("masterListSize", masterList.size());

                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp").forward(request, response);

            } else if (path.equals("/ManagerController")) {
                flag = true;
                if (request.getParameter("cons_no") == null || request.getParameter("cons_no").equals("")) {
                    cons_no = null;
                } else {
                    cons_no = request.getParameter("cons_no").trim();
                }

                if (request.getParameter("cons_no1") == null || request.getParameter("cons_no1").equals("")) {
                    cons_no1 = null;
                } else {
                    cons_no1 = request.getParameter("cons_no1").trim();
                }
                Date payDate;
                if (request.getParameter("pay_date") == null || request.getParameter("pay_date").equals("")) {
                    payDate = null;
                } else {
                    payDate = convertToDate.convertStringToDate(request.getParameter("pay_date"));

                }
                if (request.getParameter("id") == null || request.getParameter("id").equals("")) {
                    id = null;
                } else {
                    id = request.getParameter("id").trim();
                }
                Date createdDate = new Date();
                List masterList = new ArrayList();
                List challanList = new ArrayList();
                if (cons_no == null && (!(cons_no1 == null && payDate == null))) {
                    masterList = searchManager.getMasters(division);
                    System.out.println("consumer no in controller..." + cons_no1);
                    flag = searchManager.getAuthoriseChallans(division, cons_no1, id, username, createdDate);
                    System.out.println(" flag=" + flag);

                    String status = "UA";
                    challanList = em.createNamedQuery("Challan" + division + ".findByStatus").setParameter("status", status).getResultList();
                    System.out.println("consumer no in controller..." + challanList.get(0));


                } else if (cons_no1 == null && payDate == null && cons_no != null) {
                    challanList = searchManager.getChallans(division);
                    masterList = searchManager.getAuthoriseMasters(division, cons_no, username, createdDate);


                } else {
                    masterList = searchManager.getMasters(division);
                    challanList = searchManager.getChallans(division);

                }
                session.setAttribute("masterList", masterList);
                session.setAttribute("challanList", challanList);
                session.setAttribute("masterListSize", masterList.size());
                session.setAttribute("challanListSize", challanList.size());

                if (masterList.isEmpty()) {
                    t = 1;
                    request.setAttribute("t", t);
                    if (challanList.isEmpty()) {
                        t1 = 3;
                        request.setAttribute("t1", t1);
                    }
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/manager/authorise.jsp").forward(request, response);
                } else if (challanList.isEmpty()) {
                    t1 = 3;
                    request.setAttribute("t1", t1);
                    if (masterList.isEmpty()) {
                        t = 1;
                        request.setAttribute("t", t);
                    }
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/manager/authorise.jsp").forward(request, response);
                } else if (flag == false) {
                    System.out.println("in else if flag=" + flag);
                    t1 = 4;

                    request.setAttribute("t1", t1);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/manager/authorise.jsp").forward(request, response);

                } else {
                    t = 0;
                    t1 = 0;

                    request.setAttribute("t", t);
                    request.setAttribute("t1", t1);

                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/manager/authorise.jsp").forward(request, response);
                }


            } else if (path.equals("/AuthoriseMasterChallan")) {

                Date createdDate = new Date();
                List masterList = new ArrayList();
                List challanList = new ArrayList();

                masterList = searchManager.getMasters(division);
                challanList = searchManager.getChallans(division);

                session.removeAttribute("masterList");
                session.removeAttribute("challanList");
                session.removeAttribute("masterList");
                session.removeAttribute("masterListSize");
                session.removeAttribute("challanListSize");
                session.removeAttribute("masterPaginationSize");
                session.removeAttribute("challanPaginationSize");

                session.setAttribute("masterList", masterList);
                session.setAttribute("challanList", challanList);
                session.setAttribute("masterListSize", masterList.size());
                session.setAttribute("masterPaginationSize", masterList.size());
                session.setAttribute("challanListSize", challanList.size());
                session.setAttribute("challanPaginationSize", challanList.size());
                if (masterList.isEmpty()) {
                    t = 1;
                    request.setAttribute("t", t);
                    if (challanList.isEmpty()) {
                        t1 = 3;
                        request.setAttribute("t1", t1);
                    }
                    session.setAttribute("masterPaginationSize", 1);
                    response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/manager/authorise.jsp");
                } else if (challanList.isEmpty()) {
                    t1 = 3;
                    request.setAttribute("t1", t1);
                    if (masterList.isEmpty()) {
                        t = 1;
                        request.setAttribute("t", t);
                    }
                    session.setAttribute("challanPaginationSize", 1);
                    response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/manager/authorise.jsp");
                } else if (flag == false) {
                    System.out.println("in else if flag=" + flag);
                    t1 = 4;

                    request.setAttribute("t1", t1);
                    response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/manager/authorise.jsp");
                } else {
                    t = 0;
                    t1 = 0;

                    request.setAttribute("t", t);
                    request.setAttribute("t1", t1);

                    response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/manager/authorise.jsp");
                }

                //request.getServletContext().getRequestDispatcher("/jsppages/manager/authorise.jsp").forward(request, response);
            } else if (path.equals("/searchMaster")) {
                System.out.println("in search master");

                String sector = request.getParameter("sector");
//                String block = request.getParameter("block");
                List masterList = new ArrayList();
                masterList.clear();
                masterList = searchManager.searchByMaster(sector, division);
                // System.out.println("in search master list"+masterList.get(0));
                session.removeAttribute("masterList");
                session.setAttribute("masterList", masterList);
                session.setAttribute("masterListSize", masterList.size());
                if (!masterList.isEmpty()) {
                    session.setAttribute("masterPaginationSize", masterList.size());
                } else {
                    session.setAttribute("masterPaginationSize", 1);
                }
//                out.println(block);
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
            } else if (path.equals("/searchChallan")) {
                System.out.println("in search challan");

                String sector = request.getParameter("sector");
//                String block = request.getParameter("block");
                List challanList = new ArrayList();
                challanList.clear();
                challanList = searchManager.searchByChallan(sector, division);
                session.setAttribute("challanList", challanList);
                session.setAttribute("challanListSize", challanList.size());
                if (!challanList.isEmpty()) {
                    session.setAttribute("challanPaginationSize", challanList.size());
                } else {
                    session.setAttribute("challanPaginationSize", 1);
                }
//                 out.println(block);
                session.setAttribute("s", 1);
                session.setAttribute("e", 10);
            } else if (path.equals("/GetBlocks")) {
                String sector = request.getParameter("sector");
                session.removeAttribute("block");
                //System.out.println("time of select block" + session.getAttribute("block"));
                session.setAttribute("sector", sector);

                //System.out.println("time of select block" + session.getAttribute("sector"));
                String blockList = searchManager.getBlocks(division, sector);
                session.setAttribute("blocks", blockList);

                out.println(blockList);
            } else if (path.equals("/SetValues")) {
                //System.out.println("in /setvalues record");
                String value = request.getParameter("value");
                String item = request.getParameter("sym");
                // System.out.println("value-->"+value);
                // System.out.println("sym-->"+item);
                if (item.equals("s")) {
                    session.setAttribute("sector", value);
                } else if (item.equals("b")) {
                    session.setAttribute("block", value);
                    //System.out.println("block{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{----->"+ value);

                } else if (item.equals("con_t")) {

                    session.setAttribute("con_tp", value);
                    // System.out.println("coonection type{{{{{{{{{{{{{{{{{{{----->"+ value);

                } else if (item.equals("con_n_f")) {

                    session.setAttribute("cons_no_fr", value);
                    // System.out.println("consumer no from ----->"+ value);

                } else if (item.equals("con_n_t")) {

                    session.setAttribute("cons_no_to", value);
                    //System.out.println("consumer no from----->"+ value);
                } else if (item.equals("bill_to")) {

                    session.setAttribute("billdate", value);
                    //System.out.println("consumer no from----->"+ value);
                } else if (item.equals("bill_to1")) {

                    session.setAttribute("billdate1", value);
                    //System.out.println("consumer no from----->"+ value);
                } else if (item.equals("due")) {

                    session.setAttribute("duedate1", value);
                    //System.out.println("consumer no from----->"+ value);
                } else {
                }

            } else if (path.equals("/ConsumerDetails")) {
                List challanList = new ArrayList();
                String consumerNo = request.getParameter("cons_no").trim();
                Master master = searchManager.getConsumerDetails(division, consumerNo);
                session.setAttribute("consumerDetail", master);
                Sewerdetails sewerdetails = searchManager.getSewerDetails(division, consumerNo);
                session.setAttribute("sewerDetail", sewerdetails);
                challanList = searchManager.getChallanDetails(division, consumerNo);
                session.setAttribute("challanDetail", challanList);
                List<Billrepository> billrepositoryList = searchManager.getBills(division, consumerNo);
                session.setAttribute("billList", billrepositoryList);
                Calendar calculationDate = Calendar.getInstance();
                calculationDate.set(1990, 3, 1);
                if (calculationDate.after(billUtility.getCalDate(master.getNodueDt(), master.getCalDate()))) {
                    session.setAttribute("after1990", 1);
                } else {
                    session.setAttribute("after1990", 0);
                }
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp?newchl=0").forward(request, response);
            } else if (path.equals("/UpdateConsumerDetails")) {
                String consNo = request.getParameter("cons_no").trim();
                String consName1 = request.getParameter("cons_nm1").trim().toUpperCase();
                String sector = request.getParameter("sec").trim();
                String flatNo = request.getParameter("flat_no").trim();
                String blockNo = request.getParameter("blk_no").trim();
                String connectionType = "";

                if (request.getParameter("con_tp") == null || request.getParameter("con_tp").equals("")) {
                    connectionType = "";
                } else {
                    connectionType = request.getParameter("con_tp").trim().toUpperCase();
                }


                String connectionCategory = request.getParameter("cons_ctg");
                if (connectionCategory == null) {
                    connectionCategory = "";
                } else {
                    connectionCategory = connectionCategory.trim().toUpperCase();
                }
                String flatType = request.getParameter("flat_type").trim().toUpperCase();
                double plotSize = 0.0;
                if (!request.getParameter("plot_size").equals("")) {
                    plotSize = Double.parseDouble(request.getParameter("plot_size"));
                } else {
                    plotSize = 0.0;
                }
                double pipeSize = 0;
                if (!request.getParameter("pipe_size").equals("")) {
                    pipeSize = Double.parseDouble(request.getParameter("pipe_size"));
                } else {
                    pipeSize = 0;
                }
                String regNo = "";
                if (!request.getParameter("reg_no").equals("")) {
                    regNo = request.getParameter("reg_no").trim();
                } else {
                    regNo = null;
                }
                Date connectionDate;

                if (!request.getParameter("conn_dt").equals("")) {

                    connectionDate = convertToDate.convertStringToDate(request.getParameter("conn_dt"));
                } else {
                    connectionDate = null;
                }
                String estimationNo = "";
                if (!request.getParameter("esti_no").equals("")) {
                    estimationNo = request.getParameter("esti_no");
                } else {
                    estimationNo = null;
                }
                double estimationAmount = 0.0;
                if (!request.getParameter("esti_amt").equals("")) {
                    estimationAmount = Double.parseDouble(request.getParameter("esti_amt"));
                } else {
                    estimationAmount = 0.0;
                }
                double security = 0.0;
                if (!request.getParameter("secu").equals("")) {
                    security = Double.parseDouble(request.getParameter("secu"));
                } else {
                    security = 0.0;
                }


                Date estimationDate;

                if (!request.getParameter("esti_dt").equals("")) {
                    estimationDate = convertToDate.convertStringToDate(request.getParameter("esti_dt"));
                } else {
                    estimationDate = null;
                }
                double estimation1Amount = 0.0;
                if (!request.getParameter("esti1_amt").equals("")) {
                    estimation1Amount = Double.parseDouble(request.getParameter("esti1_amt"));
                } else {
                    estimation1Amount = 0.0;
                }
                double noDueAmount = 0.0;
                if (!request.getParameter("nodue_amt").equals("")) {
                    noDueAmount = Double.parseDouble(request.getParameter("nodue_amt"));
                } else {
                    noDueAmount = 0.0;
                }


                Date noDueDate;

                if (!request.getParameter("nodue_dt").equals("")) {
                    noDueDate = convertToDate.convertStringToDate(request.getParameter("nodue_dt"));
                } else {
                    noDueDate = null;
                }

                Date possessionDate;

                if (!request.getParameter("pos_date").equals("")) {
                    possessionDate = convertToDate.convertStringToDate(request.getParameter("pos_date"));
                } else {
                    possessionDate = null;
                }

                Date completionDate;

                if (!request.getParameter("comp_date").equals("")) {
                    completionDate = convertToDate.convertStringToDate(request.getParameter("comp_date"));
                } else {
                    completionDate = null;
                }

                String transferName = "";
                if (!request.getParameter("trans_nm").equals("")) {
                    transferName = request.getParameter("trans_nm").trim().toUpperCase();
                } else {
                    transferName = null;
                }
                String trf = "";
                if (!request.getParameter("trf").equals("")) {
                    trf = request.getParameter("trf").trim().toUpperCase();
                } else {
                    trf = null;
                }

                Date calculationDate;

                if (!request.getParameter("cal_date").equals("")) {
                    calculationDate = convertToDate.convertStringToDate(request.getParameter("cal_date"));
                } else {
                    calculationDate = null;
                }
                double id = 0.0;
                if (!request.getParameter("id").equals("")) {
                    id = Double.parseDouble(request.getParameter("id"));
                } else {
                    id = 0.0;
                }
                //String division = "jal1";
                String editedBy = (String) session.getAttribute("userid");
                String userRole = (String) session.getAttribute("userrole");
                Date editedDate = new Date();
                searchManager.updateConsumerDetail(division, consNo, consName1, connectionType, connectionCategory, flatType, flatNo, blockNo, sector, plotSize, pipeSize, regNo, connectionDate, estimationNo, estimationAmount, security, estimationDate, estimation1Amount, noDueAmount, noDueDate, transferName, trf, calculationDate, possessionDate, completionDate, id, editedBy, editedDate, userRole);
                List challanList = new ArrayList();
                String consumerNo = consNo;
                Master master = searchManager.getConsumerDetails(division, consumerNo);
                session.setAttribute("consumerDetail", master);
                Sewerdetails sewerdetails = searchManager.getSewerDetails(division, consumerNo);
                session.setAttribute("sewerDetail", sewerdetails);
                challanList = searchManager.getChallanDetails(division, consumerNo);
                session.setAttribute("challanDetail", challanList);
                t = 1;
                request.setAttribute("t", t);

                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/cons_details.jsp").forward(request, response);
            } else if (path.equals("/DeleteConsumerDetails")) {
                // String division = "jal1";
                if (request.getParameter("id") != null) {
                    double id = Double.valueOf(request.getParameter("id"));
                    searchManager.deleteConsumerDetail(division, id);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/search.jsp").forward(request, response);
                }
            } else if (path.equals("/SelectSector")) {
                // String division = "jal1";
                String sector = request.getParameter("sector");

                if (!request.getParameter("block").equals("")) {
                    block = request.getParameter("block");

                } else {
                    block = null;
                }
                if (!request.getParameter("flat_no").equals("")) {
                    flatNo = request.getParameter("flat_no");

                } else {
                    flatNo = null;
                }

                List<Master> masterList = new ArrayList<Master>();
                if (block == null && flatNo == null) {
                    masterList = searchManager.sectorSearch(division, sector);


                } else if (flatNo == null) {
                    masterList = searchManager.blockSearch(division, sector, block);
                } else {
                    masterList = searchManager.search(division, sector, block, flatNo);
                }
                session.setAttribute("masterList", masterList);

                session.setAttribute("masterListSize", masterList.size());
                session.setAttribute("division", division);
                if (masterList.isEmpty()) {
                    t = 1;
                    request.setAttribute("t", t);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/search_result.jsp").forward(request, response);
                } else {
                    t = 2;
                    request.setAttribute("t", t);
                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/Search/search_result.jsp").forward(request, response);
                }
            } else if (path.equals("/UpdateSewerDetails")) {
                // String division = "jal1";

                String consumerNo = request.getParameter("cons_no");
                String idStr = request.getParameter("id");

                String sRegNo = "";
                if (request.getParameter("s_reg_no") != null) {
                    sRegNo = request.getParameter("s_reg_no");

                } else {
                    sRegNo = null;

                }
                Date sConnDate;
                if (request.getParameter("s_con_dt") != null && !request.getParameter("s_con_dt").equals("")) {
                    sConnDate = convertToDate.convertStringToDate(request.getParameter("s_con_dt"));

                } else {
                    sConnDate = null;

                }
                String sEstimationNo = "";
                if (request.getParameter("s_est_no") != null) {
                    sEstimationNo = request.getParameter("s_est_no");

                } else {
                    sEstimationNo = null;


                }
                int sEstimationAmt = 0;
                if (request.getParameter("s_est_amt") != null && !request.getParameter("s_est_amt").equals("")) {
                    sEstimationAmt = (Integer.parseInt(request.getParameter("s_est_amt")));

                } else {
                    sEstimationAmt = 0;


                }
                int sSecurity = 0;
                if (request.getParameter("s_secu") != null && !request.getParameter("s_secu").equals("")) {
                    sSecurity = (Integer.parseInt(request.getParameter("s_secu")));

                } else {
                    sSecurity = 0;

                }
                Date sEstimationPaidDate;
                if (request.getParameter("s_est_pdt") != null && !request.getParameter("s_est_pdt").equals("")) {
                    sEstimationPaidDate = convertToDate.convertStringToDate(request.getParameter("s_est_pdt"));

                } else {
                    sEstimationPaidDate = null;

                }
                int sEstimationPaidAmt = 0;
                if (request.getParameter("s_est_pamt") != null && !request.getParameter("s_est_pamt").equals("")) {
                    sEstimationPaidAmt = (Integer.parseInt(request.getParameter("s_est_pamt")));

                } else {
                    sEstimationPaidAmt = 0;

                }
                int sNoDueAmt = 0;
                if (request.getParameter("s_nodue_amt") != null && !request.getParameter("s_nodue_amt").equals("")) {
                    sNoDueAmt = (Integer.parseInt(request.getParameter("s_nodue_amt")));

                } else {
                    sNoDueAmt = 0;

                }
                Date sNoDueDate;
                if (request.getParameter("s_nodue_dt") != null && !request.getParameter("s_nodue_dt").equals("")) {
                    sNoDueDate = convertToDate.convertStringToDate(request.getParameter("s_nodue_dt"));

                } else {
                    sNoDueDate = null;


                }
                double id = 0;
                if (idStr != null && !idStr.equals("") && !idStr.equals("null")) {
                    id = Double.parseDouble(idStr);
                    String editedBy = (String) session.getAttribute("userid");
                    Date editedDate = new Date();
                    searchManager.updateSewerDetail(division, id, consumerNo, sRegNo, sConnDate, sEstimationNo, sEstimationAmt, sSecurity, sEstimationPaidAmt, sEstimationPaidDate, sNoDueDate, sNoDueAmt, editedBy, editedDate);
                } else {
                    if ((Double) em.createNamedQuery("Sewerdetails" + division + ".findByMaxId").getResultList().get(0) != null) {
                        id = (Double) em.createNamedQuery("Sewerdetails" + division + ".findByMaxId").getResultList().get(0);
                    } else {
                        id = 1;
                    }
                    id = id + 1;
                    String createdBy = (String) session.getAttribute("userid");
                    Date createdDate = new Date();
                    searchManager.createSewerDetail(division, id, consumerNo, sRegNo, sConnDate, sEstimationNo, sEstimationAmt, sSecurity, sEstimationPaidAmt, sEstimationPaidDate, sNoDueDate, sNoDueAmt, createdBy, createdDate);
                }

                request.getServletContext().getRequestDispatcher("/ConsumerDetails").forward(request, response);
            } else if (path.equals("/insertChallan")) {
                row_id = request.getParameter("row_id");
                cons_no = request.getParameter("cons_no");
                flat_no = request.getParameter("flat_no");
                blk = request.getParameter("blk");
                sec = request.getParameter("sec");
                bl_per_fr = request.getParameter("bl_per_fr");
                bl_per_to = request.getParameter("bl_per_to");
                due_dt = request.getParameter("due_dt");
                bill_amt = request.getParameter("bill_amt");
                surcharge = request.getParameter("surcharge");
                paid_amt = request.getParameter("paid_amt");
                pay_date = request.getParameter("pay_date");
                arrear = request.getParameter("arrear");
                credit = request.getParameter("credit");
                recp_no = request.getParameter("recp_no");
                dis_cd = request.getParameter("dis_cd");
                noc = request.getParameter("noc");
                rmc = request.getParameter("rmc");
                chlsecu = request.getParameter("chlsecu");
                t_fee = request.getParameter("t_fee");
                css = request.getParameter("css");
                bnk_cd = request.getParameter("bnk_cd");
                br_nm = request.getParameter("br_nm");
                String createdBy = (String) session.getAttribute("userid");
                Date createdDate = new Date();
                String userRole = (String) session.getAttribute("userrole");
                searchManager.insertChallan(division, cons_no, flat_no, blk, sec, bl_per_fr, bl_per_to, due_dt, bill_amt, surcharge, paid_amt, pay_date, arrear, credit, recp_no, dis_cd, noc, rmc, chlsecu, t_fee, css, bnk_cd, br_nm, createdBy, createdDate, userRole);
                t1 = 1;
                request.setAttribute("t1", t1);
                request.getServletContext().getRequestDispatcher("/ConsumerDetails").forward(request, response);

            } else if (path.equals("/updateChallan")) {
                row_id = request.getParameter("row_id");
                bl_per_fr = request.getParameter("bl_per_fr");
                bl_per_to = request.getParameter("bl_per_to");
                due_dt = request.getParameter("due_dt");
                bill_amt = request.getParameter("bill_amt");
                surcharge = request.getParameter("surcharge");
                paid_amt = request.getParameter("paid_amt");
                pay_date = request.getParameter("pay_date");
                arrear = request.getParameter("arrear");
                credit = request.getParameter("credit");
                recp_no = request.getParameter("recp_no");
                dis_cd = request.getParameter("dis_cd");
                noc = request.getParameter("noc");
                rmc = request.getParameter("rmc");
                chlsecu = request.getParameter("chlsecu");
                t_fee = request.getParameter("t_fee");
                css = request.getParameter("css");
                bnk_cd = request.getParameter("bnk_cd");
                br_nm = request.getParameter("br_nm");
                String editedBy = (String) session.getAttribute("userid");
                Date editedDate = new Date();
                String userRole = (String) session.getAttribute("userrole");
                searchManager.editChallan(division, row_id, bl_per_fr, bl_per_to, due_dt, bill_amt, surcharge, paid_amt, pay_date, arrear, credit, recp_no, dis_cd, noc, rmc, chlsecu, t_fee, css, bnk_cd, br_nm, editedBy, editedDate, userRole);
                t = 1;
                request.setAttribute("t", t);
                request.getServletContext().getRequestDispatcher("/ConsumerDetails").forward(request, response);
            } else if (path.equals("/deleteChallan")) {
                row_id = request.getParameter("row_id");
                searchManager.deleteChallan(division, row_id);
                t2 = 1;
                request.setAttribute("t2", t2);
                request.getServletContext().getRequestDispatcher("/ConsumerDetails").forward(request, response);

            }

        } catch (Exception e) {
            e.printStackTrace();
            t1 = 2;
            request.setAttribute("t1", t1);
            t = 2;
            request.setAttribute("t", t);
            t2 = 2;
            request.setAttribute("t2", t2);
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
