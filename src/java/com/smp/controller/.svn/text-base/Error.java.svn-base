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
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.dms.BillUtility;
import com.smp.entity.Master;

import com.smp.jal.ConvertToDate;
import com.smp.manager.BillingManager;
import com.smp.manager.SearchManager;
import com.smp.session.Challan1Facade;
import com.smp.session.Master1Facade;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
@WebServlet(name = "Error", urlPatterns = {"/Error"})
public class Error extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    Master1Facade master1Facade;
    @EJB
    Challan1Facade challan1Facade;
    BillingManager billingManager;
    @EJB
    SearchManager searchManager;
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
        String sec = null;
        HttpSession session = request.getSession();
        String division = (String) session.getAttribute("division");
        session.setAttribute("sector1", request.getParameter("sector1"));
        session.setAttribute("disable", "true");
        sec = request.getParameter("sector1");
        try {
            String path = request.getServletPath();
            String xmlPath = getServletContext().getRealPath("") + "/NEWDMS/resources/jalutilXML/" + "jal.xml";

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            Document document = new Document(PageSize.A4, 0, 0, 60, 30);

            PdfWriter docWriter = PdfWriter.getInstance(document, baos);
            document.open();
            Rectangle pageSize = new Rectangle(864, 1080);
            Document document1 = new Document(pageSize);

            baos = new ByteArrayOutputStream();

            docWriter = PdfWriter.getInstance(document1, baos);

            document1.open();
            float[] widths1 = {.5f,1f, 2f, 1f, 1f, 1f, 1f, 1f, 1f, 1f,1f};
            PdfPTable table = new PdfPTable(widths1);
            table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
            

            PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(11);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPaddingBottom(30.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Error list of consumers for Sector-" + sec.trim()));
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setColspan(11);
            cell.setHorizontalAlignment(Element.ALIGN_MIDDLE);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph());
           cell.setBorder(Rectangle.NO_BORDER);
           cell.setColspan(11);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setPaddingBottom(10.0f);
            table.addCell(cell);

            


            cell = new PdfPCell(new Paragraph("S No."));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Consumer Number"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Consumer Name"));
            cell.setBorder(Rectangle.BOTTOM);
            table.addCell(cell);



            cell = new PdfPCell(new Paragraph("Connection Type"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Connection Category"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Flat Type"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Plot size"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Pipe size"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Connection Date"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("No Due Date"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Paragraph("Rate"));
            cell.setBorder(Rectangle.BOTTOM);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            int k=0;
            List<Master> masterList = new ArrayList<Master>();
            masterList = em.createNamedQuery("Master" + division + ".findError").setParameter("sector", sec.trim()).getResultList();
            Calendar startDate=Calendar.getInstance();
            startDate.set(1990, 03,01);
            Calendar endDate=Calendar.getInstance();
            billingManager=new BillingManager(em);
            double billRate=0.0;
            int flag=0;
            String connCateg = "";
            for (int i = 0; i < masterList.size(); i++) {

                String consname = masterList.get(i).getConsNm1();
                String consno = masterList.get(i).getConsNo();
                String constype = masterList.get(i).getConTp();
                String conscategeory = masterList.get(i).getConsCtg();

                String flattype = masterList.get(i).getFlatType();
                BigDecimal plotsize = masterList.get(i).getPlotSize();
                BigDecimal pipesize = masterList.get(i).getPipeSize();
                Date conndate = masterList.get(i).getConnDt();
                Date caldate = masterList.get(i).getCalDate();
                Date nddate = masterList.get(i).getNodueDt();


                    if (masterList.get(i).getCompDate() != null && masterList.get(i).getCompDate().before(startDate.getTime())) {
                        connCateg = "R";
                    } else {
                        connCateg = "T";
                    }
                        
                if (!(consno == null || constype == null || conscategeory == null || flattype == null || pipesize == null || (caldate == null && nddate == null) || (flattype != null && (flattype.equals("PLOT") && plotsize == null)))) {
                   while(startDate.before(endDate))
                   {
                       billRate=0;
                       flag=0;
                       if (pipesize.intValue() == 15 && flattype.trim().equals("PLOT")) {
                            billRate = billingManager.getRate(constype, connCateg, flattype, plotsize, pipesize, startDate.getTime());
                        } else if (!flattype.equals("PLOT")) {
                            billRate = billingManager.getRateForFlat(constype, connCateg, flattype, pipesize.intValue(), masterList.get(i).getSector(), startDate.getTime());
                        } else {
                            billRate = billingManager.getRateForBulk(constype, connCateg, flattype, pipesize, startDate.getTime());
                        }
                       if(billRate==0)
                       {
                           flag=1;
                           break;
                       }
                       startDate.set(startDate.get(Calendar.YEAR)+1, startDate.get(Calendar.MONTH),startDate.get(Calendar.DATE));
                   }
                   if(flag==0)
                   {
                    continue;
                    }
                }

                k=k+1;

                cell = new PdfPCell(new Paragraph(k + ". "));
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);

                if (consno.equals("") || consno == null) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    cell = new PdfPCell(new Paragraph(String.valueOf(consno)));
                }
                 cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Paragraph(consname));
                 cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                table.addCell(cell);


                if (constype == null || constype.equals("")) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    if (String.valueOf(constype).equals("I")) {
                        constype = "Industrial";
                    } else if (String.valueOf(constype).equals("T")) {
                        constype = "Institutional";
                    } else if (String.valueOf(constype).equals("C")) {
                        constype = "Commercial";
                    } else if (String.valueOf(constype).equals("R")) {
                        constype = "Residential";
                    } else if (String.valueOf(constype).equals("G")) {
                        constype = "Group Housing";
                    }

                    cell = new PdfPCell(new Paragraph(constype));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);


                if (conscategeory == null || conscategeory.equals("")) {
                    cell = new PdfPCell(new Paragraph(""));

                } else {
                    if (String.valueOf(conscategeory).equals("T")) {
                        conscategeory = "Temporary";
                    } else if (String.valueOf(conscategeory).equals("R")) {
                        conscategeory = "Regular";
                    }
                    cell = new PdfPCell(new Paragraph(conscategeory));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);


                if (flattype == null || flattype.equals("")) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    cell = new PdfPCell(new Paragraph(String.valueOf(flattype)));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);


                if (plotsize == null) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    DecimalFormat decimalFormat = new DecimalFormat("#.00");
                    String plot_size = decimalFormat.format(plotsize);
                    cell = new PdfPCell(new Paragraph(plot_size));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                table.addCell(cell);


                if (pipesize == null) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    cell = new PdfPCell(new Paragraph(String.valueOf(pipesize.intValue())));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                if (conndate == null) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    cell = new PdfPCell(new Paragraph(dateFormat.format(conndate)));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);


                if (nddate == null) {
                    cell = new PdfPCell(new Paragraph(""));
                } else {
                    cell = new PdfPCell(new Paragraph(dateFormat.format(nddate)));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                if (flag==1) {
                    cell = new PdfPCell(new Paragraph("Incomplete"));
                } else {
                    cell = new PdfPCell(new Paragraph("Complete"));
                }
                cell.setBorder(Rectangle.ALIGN_UNDEFINED);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                

            }


            table.setWidthPercentage(100);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);
            document1.add(table);

            document1.add(new Paragraph("  "));
            document1.close();
            response.setHeader("Content-Disposition", " filename=Error-List_Sec-"+sec);
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            ServletOutputStream out = response.getOutputStream();
            baos.writeTo(out);
            out.flush();
            session.removeAttribute("sector1");
            session.removeAttribute("disable");


        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Exception in dopost" + e);
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
