/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.dms.BillDescription;
import com.smp.dms.BillUtility;
import com.smp.entity.Billrepository1;
import com.smp.entity.Master;

import com.smp.jal.ConvertToDate;
import com.smp.manager.BillingManager;
import com.smp.manager.SearchManager;
import com.smp.session.Billrepository1Facade;
import com.smp.session.Billrepository2Facade;
import com.smp.session.Billrepository3Facade;
import com.smp.session.Challan1Facade;
import com.smp.session.Master1Facade;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.ejb.EJB;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
@WebServlet(name = "DefaultPdf", urlPatterns = {"/DefaultPdf", "/b", "/GetPdf", "/printDefaulter", "/CanceldefaultPDF"})
public class DefaultPdf extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    Master1Facade master1Facade;
    @EJB
    Challan1Facade challan1Facade;
    @EJB
    Billrepository1Facade billrepository1Facade;
    @EJB
    Billrepository2Facade billrepository2Facade;
    @EJB
    Billrepository3Facade billrepository3Facade;
    @EJB
    SearchManager searchManager;
    Billrepository1 billrepository1 = new Billrepository1();
    BillDescription billDescription = new BillDescription();
    BillUtility billUtility = new BillUtility();
    ConvertToDate convertToDate = new ConvertToDate();
    DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DocumentException {
        response.setContentType("text/html;charset=UTF-8");
        String consumerNo = null;
        String sec = null;
        String duedate;
        double principal = 0;
        double interest = 0;
        double total = 0;
        String path = request.getServletPath();
        String xmlPath = getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";
        HttpSession session = request.getSession();
        String division = (String) session.getAttribute("division");
        try {

            if (path.equals("/DefaultPdf")) {

                List<String> sectorList = searchManager.getSectors(division, xmlPath);
                session.removeAttribute("block");
                session.removeAttribute("con_tp");
                session.removeAttribute("cons_no_fr");
                session.removeAttribute("cons_no_to");
                session.removeAttribute("billdate");
                session.removeAttribute("duedate1");
                session.removeAttribute("disable");
                session.setAttribute("sectorList", sectorList);
                session.setAttribute("defaultstatus", 0);
                session.setAttribute("dflag", "1");
                request.getServletContext().getRequestDispatcher("/b").forward(request, response);

            } else if (path.equals("/b")) {
                
                session.setAttribute("dflag", session.getAttribute("dflag"));
                request.getServletContext().getRequestDispatcher("/NEWDMS/jsppages/billing/default_err.jsp").forward(request, response);
            } else if (path.equals("/CanceldefaultPDF")) {
                BillingManager billingManager = (BillingManager) session.getAttribute("billingManager");
                billingManager.setCancel(false);
                session.removeAttribute("disable");
                getServletContext().getRequestDispatcher("/b").forward(request, response);
            } else if (path.equals("/GetPdf")) {
                session.setAttribute("dflag", "0");
                session.setAttribute("billdate", request.getParameter("billdate"));
                duedate = request.getParameter("billdate");
                session.setAttribute("sector", request.getParameter("sector"));
                sec = request.getParameter("sector");
                session.setAttribute("disable", "true");
                Calendar calendar = Calendar.getInstance();
                calendar = convertToDate.convertStringToCLDate(duedate);
                // int defaultstatus=0;
                List<Master> masterList = new ArrayList<Master>();
                masterList = em.createNamedQuery("Master" + division + ".findBySector").setParameter("sector", sec).getResultList();

//                if (masterList.size() > 0) {
                BillingManager billingManager = new BillingManager(division, masterList, calendar, calendar, 0.0, null, em);
                session.setAttribute("billingManager", billingManager);
                Thread defaulterBill = new Thread(billingManager);
                defaulterBill.start();

                while (defaulterBill.isAlive()) {

                    session.setAttribute("defaultstatus", billingManager.getStatus() * 100 / masterList.size());

                }
                session.setAttribute("dflag", "2");
                List<BillDescription> billDescriptionList = new ArrayList<BillDescription>();
                billDescriptionList = billingManager.getBillDescriptions();
                session.setAttribute("billList", billDescriptionList);
                session.setAttribute("duedate", duedate);
                session.setAttribute("sector", sec);
                session.removeAttribute("disable");
//                session.removeAttribute("sector");
//                session.removeAttribute("billdate");
            } else if (path.equals("/printDefaulter")) {
                List<BillDescription> billDescriptionList = new ArrayList<BillDescription>();
                billDescriptionList = (List<BillDescription>) session.getAttribute("billList");
                String duedate1 = (String) session.getAttribute("duedate");
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                Document document = new Document(PageSize.A4, 0, 0, 60, 30);

                PdfWriter docWriter = PdfWriter.getInstance(document, baos);
                document.open();
                Rectangle pageSize = new Rectangle(864, 1080);
                Document document1 = new Document(pageSize);

                baos = new ByteArrayOutputStream();

                docWriter = PdfWriter.getInstance(document1, baos);

                document1.open();
                PdfPTable outerTable = new PdfPTable(1);
                float[] widths1 = {1f, 1f, 2f, 1f, 1f, 1f, 1f};
                PdfPTable table = new PdfPTable(widths1);
                //form=request.getParameter("form");

                table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
                String sector = (String) session.getAttribute("sector");
                PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY \n \n   DEFAULTER'S LIST FOR SECTOR - " + sector.trim() + "(ARREAR UPTO-" + duedate1 + ")\n\n"));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(7);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(10.0f);
                table.addCell(cell);


//                cell = new PdfPCell(new Paragraph("DEFAULTER'S LIST FOR SECTOR - " + sector.trim() + "(ARREAR UPTO-" + duedate1 + ")"));
//                cell.setBorder(Rectangle.NO_BORDER);
//                cell.setColspan(6);
//                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
//                cell.setPaddingBottom(20.0f);
//                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("S. No."));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);
                cell = new PdfPCell(new Paragraph("Consumer No:"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Consumer Name:"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Address:"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                cell = new PdfPCell(new Paragraph("Principal"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Interest"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph("Total/sum"));
                cell.setBorder(Rectangle.BOTTOM);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);
                int k = 0;
                Master m = null;
                for (int i = 0; i < billDescriptionList.size(); i++) {

                    if(billDescriptionList.get(i) != null)
                    {
                    consumerNo = billDescriptionList.get(i).getConsNO();

                    m = (Master) em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList().get(0);

                    String consumername = m.getConsNm1();
                    String flatno = m.getFlatNo();
                    String blkno = m.getBlkNo();

                    interest = 0;
                    principal = 0;
                    principal = billDescriptionList.get(i).getPrincipal();
                    interest = billDescriptionList.get(i).getInterest();
                    total = principal + interest;
                    if (total > 0) {
                        k = k + 1;

                        cell = new PdfPCell(new Paragraph(k + ". "));
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);
                        if (consumerNo.equals("") || consumerNo == null) {
                            cell = new PdfPCell(new Paragraph(""));
                        } else {
                            cell = new PdfPCell(new Paragraph(consumerNo));
                        }
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);

                        if (consumername == null || consumername.equals("")) {
                            cell = new PdfPCell(new Paragraph(""));
                        } else {
                            cell = new PdfPCell(new Paragraph(consumername));
                        }
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);

                        Phrase phrase1 = new Phrase();
                        phrase1 = new Phrase("" + blkno + "," + flatno);
                        Paragraph paragraph = new Paragraph("");
                        paragraph.add(phrase1);
                        cell = new PdfPCell(paragraph);
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                        table.addCell(cell);

                        cell = new PdfPCell(new Paragraph(""));

                        DecimalFormat decimalFormat = new DecimalFormat("#.00");
                        String principalAMt = decimalFormat.format(principal);
                        cell = new PdfPCell(new Paragraph(principalAMt));
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);


                        String interestAmt = decimalFormat.format(interest);
                        cell = new PdfPCell(new Paragraph(interestAmt));
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);

                        String totalAmt = decimalFormat.format(total);
                        cell = new PdfPCell(new Paragraph(totalAmt));
                        cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                        table.addCell(cell);
                    }
                    }
                }



                table.setWidthPercentage(100);
                table.setHorizontalAlignment(Element.ALIGN_CENTER);
                document1.add(table);
                outerTable.addCell(table);
                //document1.newPage();

                document1.add(new Paragraph("  "));
                document1.close();
                response.setHeader("Content-Disposition", " filename=Defaulter-List_Sec-" + sector);
                response.setHeader("Expires", "0");
                response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
                response.setHeader("Pragma", "public");
                response.setContentType("application/pdf");
                ServletOutputStream out = response.getOutputStream();
                baos.writeTo(out);
                out.flush();
                session.removeAttribute("sector");
                session.removeAttribute("billdate");
            }
        } catch (Exception e) {
            e.printStackTrace();
            //System.err.println("Exception in dopost" + e);
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



        } catch (DocumentException ex) {
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



        } catch (DocumentException ex) {
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
