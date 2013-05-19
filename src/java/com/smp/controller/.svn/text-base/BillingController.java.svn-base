/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.smp.dms.BillDescription;
import com.smp.dms.BillUtility;
import com.smp.entity.Billrepository;
import com.smp.entity.Billrepository1;
import com.smp.entity.Billrepository2;
import com.smp.entity.Billrepository3;
import com.smp.entity.Master;

import com.smp.jal.ConvertToDate;
import com.smp.manager.BillingManager;
import com.smp.manager.DmssettingsManager;
import com.smp.manager.SearchManager;
import com.smp.session.Billrepository1Facade;
import com.smp.session.Billrepository2Facade;
import com.smp.session.Billrepository3Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpSession;

/**
 *
 * @author smp-06
 */
@WebServlet(name = "BillingController", urlPatterns = {"/BillingController", "/getCaldate", "/GroupHousingBill", "/LedgerController", "/CalculateBillForConsumer", "/CheckConsumer", "/CalculateBillForSector", "/CancelBill","/getBillPdf","/cancelBillPdf", "/printBill", "/LedgerForConsumer", "/LedgerForSector", "/a", "/l"})
public class BillingController extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    SearchManager searchManager;
    @EJB
    Billrepository1Facade billrepository1Facade;
    @EJB
    Billrepository2Facade billrepository2Facade;
    @EJB
    Billrepository3Facade billrepository3Facade;
    @EJB
    DmssettingsManager dmssettingsManager;
    ConvertToDate convertToDate = new ConvertToDate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String path = request.getServletPath();
        String xmlPath = getServletContext().getRealPath("") + "/NEWDMS/resources/jalutilXML/" + "jal.xml";
        HttpSession session = request.getSession();
        String division = (String) session.getAttribute("division");
        try {
            if (path.equals("/BillingController")) {
                List<String> sectorList = searchManager.getSectors(division, xmlPath);
                session.setAttribute("sectorList", sectorList);
                session.setAttribute("status", 0);
                session.setAttribute("flag", "1");
                session.removeAttribute("sector");
                session.removeAttribute("block");
                session.removeAttribute("con_tp");
                session.removeAttribute("cons_no_fr");
                session.removeAttribute("cons_no_to");
                session.removeAttribute("billdate");
                session.removeAttribute("duedate1");
                session.removeAttribute("disable");
                request.getServletContext().getRequestDispatcher("/a").forward(request, response);

            } else if (path.equals("/a")) {
                session.setAttribute("flag", session.getAttribute("flag"));
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/billing/billgen.jsp").forward(request, response);
            } else if (path.equals("/GroupHousingBill")) {
//                request.getServletContext().getRequestDispatcher("/jsppages/billing/groupHousingBill.jsp").forward(request, response);
                session.setAttribute("housingRateList", null);
                response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/billing/groupHousingBill.jsp#");
            } else if (path.equals("/CalculateBillForConsumer")) {

                String consumerNo = request.getParameter("cons_no").trim();
                String arrear = request.getParameter("arrear");
                String arrearupto = request.getParameter("arrearupto");
                String dateTo1 = request.getParameter("bill_to");
                String dueDate = request.getParameter("duedate");
                String nameTransfer = request.getParameter("transfer");
                String noc = request.getParameter("noc");
                String regular = request.getParameter("regular");
                String createdBy = (String) session.getAttribute("userid");
                Date createdDate = new Date();
                Calendar dateTo = Calendar.getInstance();
                Calendar dueDate1 = Calendar.getInstance();
                Calendar arrearupto1 = Calendar.getInstance();
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yy");
                if (dueDate != null) {
                    dueDate1 = convertToDate.convertStringToCLDate(dueDate);
                    //  dueDate1=formatter.parse(dueDate);
                }
                if (dateTo1 != null) {
                    dateTo = convertToDate.convertStringToCLDate(dateTo1);
                }

                if (arrearupto != null) {
                    arrearupto1 = convertToDate.convertStringToCLDate(arrearupto);
                }
                double arrear1 = 0.0;
                if (arrear != null) {
                    arrear1 = Double.parseDouble(arrear);
                }
                Integer[] idList = new Integer[1];
                int id;
                int status = 0;
                List<BillDescription> billDescriptions = new ArrayList<BillDescription>();
                List<Master> masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();

                BillingManager billingManager = new BillingManager(division, masterList, dateTo, dueDate1, arrear1, arrearupto1, em);
                Thread bill = new Thread(billingManager);
                bill.start();


                while (bill.isAlive()) {
                }

                billDescriptions = billingManager.getBillDescriptions();

                Date calDate = new Date();
                Date nodueDate = new Date();

                
                String cons_no = request.getParameter("cons_no");
                String bill_to = request.getParameter("bill_to");

//                List<Master> mastersList = new ArrayList<Master>();
//                mastersList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", cons_no).getResultList();
                int flagValue=0;
                if(masterList.get(0) != null && masterList.get(0).getConTp().equals("G"))
                {
                calDate = masterList.get(0).getNodueDt();
                nodueDate = masterList.get(0).getCalDate();
                BillUtility billUtility = new BillUtility();
                Calendar findcalDate = billUtility.getCalDate(nodueDate, calDate);
                flagValue = dmssettingsManager.checkHousingRates(cons_no, findcalDate, bill_to);
                }
                if (flagValue == 1) {
                    session.setAttribute("flagValue", flagValue);
                    response.sendRedirect(request.getContextPath() + "/NEWDMS/jsppages/billing/groupHousingBill.jsp#");
                    //request.getServletContext().getRequestDispatcher("/jsppages/billing/groupHousingBill.jsp#").forward(request, response);

                } else if (billDescriptions.get(0) != null) {

                    /****************************************************/
                    Billrepository billrepository = null;
                    List<Billrepository> brl = em.createNamedQuery("Billrepository" + division + ".findDuplicate").setParameter("consNo", billDescriptions.get(0).getConsNO()).setParameter("billFrom", billDescriptions.get(0).getBillFrom()).setParameter("billTo", billDescriptions.get(0).getBillTo()).setParameter("rebate", billDescriptions.get(0).getRebate()).setParameter("cessAmount", billDescriptions.get(0).getCessAmount()).setParameter("principal", billDescriptions.get(0).getPrincipal()).setParameter("interest", billDescriptions.get(0).getInterest()).setParameter("surcharge",billDescriptions.get(0).getSurcharge()).setParameter("security", billDescriptions.get(0).getSecurity()).setParameter("nocFee", billDescriptions.get(0).getNocFee()).setParameter("tFee", billDescriptions.get(0).getTransferFee()).setParameter("regularFee", billDescriptions.get(0).getRegularFee()).setParameter("discount", billDescriptions.get(0).getDiscount()).getResultList();
                    if (!brl.isEmpty()) {
                        billrepository = brl.get(0);
                        idList[0] = billrepository.getId().intValue();
                    } else {

                        BigDecimal bigDecimalId = (BigDecimal) em.createNamedQuery("Billrepository" + division + ".findByMaxId").getResultList().get(0);

                        if (bigDecimalId != null) {
                            id = bigDecimalId.intValue() + 1;
                        } else {
                            id = 1;
                        }
                        if (division.equals("1")) {
                            billrepository = new Billrepository1();
                        } else if (division.equals("2")) {
                            billrepository = new Billrepository2();
                        } else if (division.equals("3")) {
                            billrepository = new Billrepository3();
                        }
                        billrepository.setId(BigDecimal.valueOf(id));
                        billrepository.setBillFrom(billDescriptions.get(0).getBillFrom());
                        billrepository.setBillTo(billDescriptions.get(0).getBillTo());
                        billrepository.setCessAmount(BigDecimal.valueOf(billDescriptions.get(0).getCessAmount()));
                        billrepository.setConsNo(billDescriptions.get(0).getConsNO());
                        billrepository.setInterest(BigDecimal.valueOf(billDescriptions.get(0).getInterest()));
                        billrepository.setPrincipal(BigDecimal.valueOf(billDescriptions.get(0).getPrincipal()));
                        billrepository.setRate(BigDecimal.valueOf(billDescriptions.get(0).getRate()));
                        billrepository.setRebate(BigDecimal.valueOf(billDescriptions.get(0).getRebate()));
                        billrepository.setCreateBy(createdBy);
                        billrepository.setCreatedDate(createdDate);
                        billrepository.setDueDate(billDescriptions.get(0).getDueDate());
                        billrepository.setDiscount(billDescriptions.get(0).getDiscount());
                        billrepository.setSurcharge(0.0);
                        if (regular != null && !regular.equals("null")) {
                            billrepository.setRegularFee(300.0);
                            if (((billDescriptions.get(0).getRate() * 12) - masterList.get(0).getSecu().doubleValue()) > 0) {
                                billrepository.setSecurity((billDescriptions.get(0).getRate() * 12) - masterList.get(0).getSecu().doubleValue());

                            } else {
                                billrepository.setSecurity(0.0);

                            }
                        } else {
                            billrepository.setSecurity(0.0);
                            billrepository.setRegularFee(0.0);
                        }
                        if (nameTransfer != null && !nameTransfer.equals("null")) {
                            billrepository.setTFee(300.0);
                        }else{
                            billrepository.setTFee(0.0);
                        }
                        if (noc != null && !noc.equals("null")) {
                            billrepository.setNocFee(300.0);
                        }else{
                            billrepository.setNocFee(0.0);
                        }
                        if (division.equals("1")) {
                            Billrepository1 billrepository1 = new Billrepository1();
                            billrepository1 = (Billrepository1) billrepository;
                            billrepository1Facade.create(billrepository1);
                        } else if (division.equals("2")) {
                            Billrepository2 billrepository2 = new Billrepository2();
                            billrepository2 = (Billrepository2) billrepository;
                            billrepository2Facade.create(billrepository2);
                        } else if (division.equals("3")) {
                            Billrepository3 billrepository3 = new Billrepository3();
                            billrepository3 = (Billrepository3) billrepository;
                            billrepository3Facade.create(billrepository3);
                        }
                        /****************************************************/
                        idList[0] = id;
                    }
                    session.setAttribute("idList", idList);
                    String billFlag=request.getParameter("billFlag");
                    if(billFlag.equals("1"))
                    {
                    session.setAttribute("billGenFlag", "1");
                  
                    response.sendRedirect(request.getContextPath()+"/ConsumerDetails?cons_no="+consumerNo+"#bottom");
                    }else
                    {
                       request.getServletContext().getRequestDispatcher("/GeneratePdf?division=" + division +"&flag2=1").forward(request, response);
                        session.removeAttribute("idList");
                    }
                } else {
                    request.setAttribute("insufficientDetailFlag","1");
                    request.getServletContext().getRequestDispatcher("/ConsumerDetails?cons_no=" + consumerNo).forward(request, response);
                }
            }else if(path.equals("/getBillPdf")){
                request.getServletContext().getRequestDispatcher("/GeneratePdf?division=" + division +"&flag2=1").forward(request, response);
                session.removeAttribute("idList");
                session.removeAttribute("billGenFlag");
                
            }else if(path.equals("/cancelBillPdf")){
                session.removeAttribute("idList");
                session.removeAttribute("billGenFlag");
            }
            else if (path.equals("/printBill")) {
                String billNo = request.getParameter("billNo");
                Billrepository billrepository = (Billrepository) em.createNamedQuery("Billrepository" + division + ".findById").setParameter("id", BigDecimal.valueOf(Long.valueOf(billNo))).getResultList().get(0);
                Integer[] idList = new Integer[1];
                idList[0] = Integer.valueOf(billNo);
                session.setAttribute("idList", idList);
                request.getServletContext().getRequestDispatcher("/GeneratePdf?division=" + division +"&flag2=1").forward(request, response);
            } else if (path.equals("/CalculateBillForSector")) {
                session.setAttribute("flag", "0");
                String sector = session.getAttribute("sector").toString();

                //session.setAttribute("block", request.getParameter("block"));
                // String block = request.getParameter("block");

                //session.setAttribute("con_tp", request.getParameter("con_tp"));
                //String conType = request.getParameter("con_tp");
                //System.out.println("Conection Type-->" + conType);

                //session.setAttribute("cons_no_fr", request.getParameter("cons_no_fr"));
                //String consumerNoFrom = request.getParameter("cons_no_fr");

                //session.setAttribute("cons_no_to", request.getParameter("cons_no_to"));
                //String consumerNoTo = request.getParameter("cons_no_to");

                //session.setAttribute("billdate", request.getParameter("billdate"));
                // session.setAttribute("duedate1", request.getParameter("duedate1"));

                String block = request.getParameter("block");
                String conType = request.getParameter("con_tp");
                String consumerNoFrom = request.getParameter("cons_no_fr").trim();
                String consumerNoTo = request.getParameter("cons_no_to").trim();
                String dateTo1 = request.getParameter("billdate");
                String dueDate = request.getParameter("duedate1");

                session.setAttribute("disable", "true");
                String createdBy = (String) session.getAttribute("userid");
                Date createdDate = new Date();
                //String dateTo1 = request.getParameter("billdate");
                //String dueDate = request.getParameter("duedate1");
                Calendar dateTo = Calendar.getInstance();
                Calendar dueDate1 = Calendar.getInstance();
                List<Master> masterList = new ArrayList<Master>();
                if (sector.equals("")) {
                    sector = null;
                }
                if (block.equals("")) {
                    block = null;
                }
                if (conType.equals("")) {
                    conType = null;
                }
                if (dateTo1 != null) {
                    dateTo = convertToDate.convertStringToCLDate(dateTo1);
                }
                if (dueDate != null) {
                    dueDate1 = convertToDate.convertStringToCLDate(dueDate);
                }
                if (!consumerNoFrom.equals("") && !consumerNoTo.equals("")) {
                    masterList = em.createNamedQuery("Master" + division + ".findBetweenConsNo").setParameter("minConsNo", consumerNoFrom).setParameter("maxConsNo", consumerNoTo).getResultList();

                } else {
                    masterList = em.createNamedQuery("Master" + division + ".findBySector&Block&connType").setParameter("sector", sector).setParameter("blkNo", block).setParameter("conTp", conType).getResultList();

                }
                if (masterList.isEmpty()) {
                    session.setAttribute("flag", "1");
                    session.setAttribute("msg", "1");

                    request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/billing/billgen.jsp").forward(request, response);
                } else {

                    session.removeAttribute("msg");
                    int id;
                    List<BillDescription> billDescriptions = new ArrayList<BillDescription>();
                    BillingManager billingManager = new BillingManager(division, masterList, dateTo, dueDate1, 0.0, null, em);
                    session.setAttribute("billingmanager", billingManager);
                    session.setAttribute("flag", "0");
                    Thread bills = new Thread(billingManager);
                    bills.start();


                    while (bills.isAlive()) {
                        session.setAttribute("status", billingManager.getStatus() * 100 / masterList.size());

                        // out.println(billingManager.getStatus());

                    }

                     session.removeAttribute("disable");
                    billDescriptions = billingManager.getBillDescriptions();
                    Integer idList[] = new Integer[billDescriptions.size()];
                    for (int i = 0; i < billDescriptions.size(); i++) {
                        if (billDescriptions.get(i) != null) {
                            /****************************************************/
                            Billrepository billrepository = null;
                            List<Billrepository> brl = em.createNamedQuery("Billrepository" + division + ".findDuplicate").setParameter("consNo", billDescriptions.get(i).getConsNO()).setParameter("billFrom", billDescriptions.get(i).getBillFrom()).setParameter("billTo", billDescriptions.get(i).getBillTo()).getResultList();
                            if (!brl.isEmpty()) {
                                billrepository = brl.get(0);
                                idList[i] = billrepository.getId().intValue();
                            } else {
                                BigDecimal bigDecimalId = (BigDecimal) em.createNamedQuery("Billrepository" + division + ".findByMaxId").getResultList().get(0);

                                if (bigDecimalId != null) {
                                    id = bigDecimalId.intValue() + 1;
                                } else {
                                    id = 1;
                                }
                                if (division.equals("1")) {
                                    billrepository = new Billrepository1();
                                } else if (division.equals("2")) {
                                    billrepository = new Billrepository2();
                                } else if (division.equals("3")) {
                                    billrepository = new Billrepository3();
                                }
                                billrepository.setId(BigDecimal.valueOf(id));
                                billrepository.setBillFrom(billDescriptions.get(i).getBillFrom());
                                billrepository.setBillTo(billDescriptions.get(i).getBillTo());
                                billrepository.setCessAmount(BigDecimal.valueOf(billDescriptions.get(i).getCessAmount()));
                                billrepository.setConsNo(billDescriptions.get(i).getConsNO());
                                billrepository.setInterest(BigDecimal.valueOf(billDescriptions.get(i).getInterest()));
                                billrepository.setPrincipal(BigDecimal.valueOf(billDescriptions.get(i).getPrincipal()));
                                billrepository.setRate(BigDecimal.valueOf(billDescriptions.get(i).getRate()));
                                billrepository.setRebate(BigDecimal.valueOf(billDescriptions.get(i).getRebate()));
                                billrepository.setDueDate(dueDate1.getTime());
                                billrepository.setCreateBy(createdBy);
                                billrepository.setCreatedDate(createdDate);
                                billrepository.setDiscount(billDescriptions.get(i).getDiscount());
                                billrepository.setSecurity(0.0);
                                if (division.equals("1")) {
                                    Billrepository1 billrepository1 = new Billrepository1();
                                    billrepository1 = (Billrepository1) billrepository;
                                    billrepository1Facade.create(billrepository1);
                                } else if (division.equals("2")) {
                                    Billrepository2 billrepository2 = new Billrepository2();
                                    billrepository2 = (Billrepository2) billrepository;
                                    billrepository2Facade.create(billrepository2);
                                } else if (division.equals("3")) {
                                    Billrepository3 billrepository3 = new Billrepository3();
                                    billrepository3 = (Billrepository3) billrepository;
                                    billrepository3Facade.create(billrepository3);
                                }
                                idList[i] = id;
                            }
                        } else {
                            idList[i] = 0;
                        }
                    }
                     
                    session.setAttribute("idList", idList);
                    session.setAttribute("flag", "2");
                    session.removeAttribute("sector");
                    session.removeAttribute("block");
                    session.removeAttribute("con_tp");
                    session.removeAttribute("cons_no_fr");
                    session.removeAttribute("cons_no_to");
                    session.removeAttribute("billdate");
                    session.removeAttribute("billdate1");
                    session.removeAttribute("duedate1");
                    session.removeAttribute("disable");


                }

            } else if (path.equals("/CancelBill")) {
                BillingManager billingManager = (BillingManager) session.getAttribute("billingmanager");
                billingManager.setCancel(false);
                getServletContext().getRequestDispatcher("/a").forward(request, response);
            } else if (path.equals("/CheckConsumer")) {
                String consumerNo = request.getParameter("cons_no");
                String flag1 = "";
                Date calDate = new Date();
                Date ndcDate = new Date();
                Calendar calculationDate = Calendar.getInstance();
                calculationDate.set(1990, 3, 1);
                List<Master> masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
                if (!masterList.isEmpty() && (masterList.get(0).getStatus() == null || !masterList.get(0).getStatus().equals("UA"))) {
                    flag1 = "1";
                    calDate = masterList.get(0).getCalDate();
                    ndcDate = masterList.get(0).getNodueDt();
                    BillUtility billUtility = new BillUtility();
                    if (calculationDate.after(billUtility.getCalDate(ndcDate, calDate))) {
                        flag1 = flag1 + ":1:" + consumerNo;
                    } else {
                        flag1 = "1:0:" + consumerNo;
                    }
                } else {
                    flag1 = "0:0:" + consumerNo;
                }
                PrintWriter out = response.getWriter();
                out.println(flag1);
                out.close();

            } else if (path.equals("/LedgerController")) {

                List<String> sectorList = searchManager.getSectors(division, xmlPath);
                request.setAttribute("sectorList", sectorList);
                session.setAttribute("status1", 0);
                session.setAttribute("flag1", "1");
                session.removeAttribute("sector");
                session.removeAttribute("block");
                session.removeAttribute("con_tp");
                session.removeAttribute("cons_no_fr");
                session.removeAttribute("cons_no_to");
                session.removeAttribute("billdate");
                session.removeAttribute("billdate1");
                session.removeAttribute("duedate1");
                session.removeAttribute("disable");
                request.getServletContext().getRequestDispatcher("/l").forward(request, response);
            } else if (path.equals("/l")) {
                session.setAttribute("flag1", session.getAttribute("flag1"));
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/billing/ledgergen.jsp").forward(request, response);
            } else if (path.equals("/LedgerForConsumer")) {
                session.setAttribute("flag1", "0");
                session.setAttribute("cons_no", request.getParameter("cons_no").trim());
                String consumerNo = request.getParameter("cons_no").trim();
                session.setAttribute("billdate", request.getParameter("billdate"));
                String billDate = request.getParameter("billdate");
                String[] consumerList = new String[1];
                consumerList[0] = consumerNo;
                request.setAttribute("consumerList", consumerList);
                request.getServletContext().getRequestDispatcher("/Ledgergen?billdate=" + billDate +"&statusbar=0").forward(request, response);
                session.removeAttribute("cons_no");
                session.removeAttribute("billdate");
            } else if (path.equals("/LedgerForSector")) {

                session.setAttribute("flag1", "0");
                //session.setAttribute("sector", request.getParameter("sector"));
                String sector = request.getParameter("sector");
                //session.setAttribute("block", request.getParameter("block"));
                String block = request.getParameter("block");
                // session.setAttribute("con_tp", request.getParameter("con_tp"));
                String conType = request.getParameter("con_tp");
                //session.setAttribute("cons_no_fr", request.getParameter("cons_no_fr"));
                String consumerNoFrom = request.getParameter("cons_no_fr").trim();
                //session.setAttribute("cons_no_to", request.getParameter("cons_no_to"));
                String consumerNoTo = request.getParameter("cons_no_to").trim();
                //session.setAttribute("billdate1", request.getParameter("billdate1"));
                String dateTo1 = request.getParameter("billdate1");
                session.setAttribute("disable", "true");
                Calendar dateTo = Calendar.getInstance();
                List<Master> masterList = new ArrayList<Master>();
                if (dateTo1 != null) {
                    dateTo = convertToDate.convertStringToCLDate(dateTo1);
                }
                if (!consumerNoFrom.equals("") && !consumerNoTo.equals("")) {
                    masterList = em.createNamedQuery("Master" + division + ".findBetweenConsNo").setParameter("minConsNo", consumerNoFrom).setParameter("maxConsNo", consumerNoTo).getResultList();

                } else {
                    masterList = em.createNamedQuery("Master" + division + ".findBySector&Block&connType").setParameter("sector", sector).setParameter("blkNo", block).setParameter("conTp", conType).getResultList();
                }
                if (masterList.isEmpty()) {
                    request.getServletContext().getRequestDispatcher("/jsppages/billing/ledgergen.jsp").forward(request, response);
                } else {
                    String[] consumerList = new String[masterList.size()];
                    for (int i = 0; i < masterList.size(); i++) {
                        consumerList[i] = masterList.get(i).getConsNo();
                    }

                    request.setAttribute("consumerList", consumerList);
                    request.getServletContext().getRequestDispatcher("/Ledgergen?billdate=" + dateTo1+"&statusbar=1").forward(request, response);
                }
                session.removeAttribute("sector");
                session.removeAttribute("block");
                session.removeAttribute("con_tp");
                session.removeAttribute("cons_no_fr");
                session.removeAttribute("cons_no_to");
                session.removeAttribute("billdate1");
                session.removeAttribute("disable");
            }
            if (path.equals("/getCaldate")) {

                Date calDate = new Date();
                Date nodueDate = new Date();

                String cons_no = request.getParameter("cons_no");
                String bill_to = request.getParameter("bill_to");

                List<Master> mastersList = new ArrayList<Master>();
                mastersList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", cons_no).getResultList();
                calDate = mastersList.get(0).getNodueDt();
                nodueDate = mastersList.get(0).getCalDate();
                BillUtility billUtility = new BillUtility();
                Calendar findcalDate = billUtility.getCalDate(nodueDate, calDate);
                int flagValue = dmssettingsManager.checkHousingRates(cons_no, findcalDate, bill_to);

                session.setAttribute("flagValue", flagValue);
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/billing/groupHousingBill").forward(request, response);

            }

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
