/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.dms;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.smp.entity.CessRate;
import com.smp.entity.Challan;
import com.smp.entity.HousingRate;
import com.smp.entity.InterestRates;
import com.smp.entity.Master;
import com.smp.entity.Rates;
import com.smp.session.Billrepository1Facade;
import com.smp.session.Billrepository2Facade;
import com.smp.session.Billrepository3Facade;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LedgerPdf", urlPatterns = {"/Ledgergen", "/getLedgerList", "/CancelLedger"})
public class LedgerPdf extends HttpServlet {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    Billrepository1Facade billrepository1Facade;
    @EJB
    Billrepository2Facade billrepository2Facade;
    @EJB
    Billrepository3Facade billrepository3Facade;
    BillUtility billUtility = new BillUtility();
    ConvertToDate convertToDate = new ConvertToDate();
    Challan challan;
    DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");

    class LedgerThread implements Runnable {

        String division;
        String[] consumerList;
        String dateTo;
        Document document;
        int status1;
        boolean cancel;

        public LedgerThread() {
        }

        public LedgerThread(String division, String[] consumerList, String dateTo, Document document) {
            this.division = division;
            this.consumerList = consumerList;
            this.dateTo = dateTo;
            this.document = document;
            this.status1 = 0;
            this.cancel = true;
        }

        @Override
        public void run() {
            System.out.println("this.consumerList.length----- " + this.consumerList.length);
            for (int m = 0; m < this.consumerList.length && cancel; m++) {
                this.status1++;
                float[] widths1 = {1.4f, 1f, 1f, 1f, 1f, 1f, 1f, 1f, 1f};
                PdfPTable table = new PdfPTable(widths1);


                table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);

                PdfPCell cell = new PdfPCell(new Paragraph("NEW OKHLA INDUSTRIAL DEVELOPMENT AUTHORITY"));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(9);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(10.0f);
                table.addCell(cell);
                /******************************************************************************************************/
                double billRate = 0.0;
                double billRate1 = 0.0;
                double cessRate = 0.0;
                double rebate = 0.0;
                double interestRate = 0.0;
                double principal = 0.0;
                double arrear = 0.0;
                double credit = 0.0;
                double interest = 0.0;
                double billAmount = 0.0;
                double paidAmount = 0.0;
                double cessAmount = 0.0;
                int id = 0;
                Calendar paymentDate = Calendar.getInstance();
                Calendar dueDate = Calendar.getInstance();

                int billCycle = 1;
                int cyclePeriod = 1;
                Calendar billTo = Calendar.getInstance();
                if (this.dateTo != null) {
                    billTo = convertToDate.convertStringToCLDate(this.dateTo);
                    dueDate.setTime(billTo.getTime());
                    //billTo.set(billTo.get(Calendar.YEAR), billTo.get(Calendar.MONTH),billTo.get(Calendar.DATE));
                }

                List<Master> ml = em.createNamedQuery("Master" + this.division + ".findByConsNoWithConditions").setParameter("consNo", this.consumerList[m]).getResultList();
//                if(ml.isEmpty())
//                {
//
//
//                }else{
                Master master = (Master) ml.get(0);
                String str = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                String[] conNO = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th"};
                String index = " ";
                if (master.getConsNo().length() == 9) {
                    index = master.getConsNo().substring(8, 9);
                }
                Calendar calculationDate = billUtility.getCalDate(master.getNodueDt(), master.getCalDate());
                System.out.println("calculation date=============================================================" + calculationDate.getTime());
                int billPeriod = billTo.get(Calendar.YEAR) - calculationDate.get(Calendar.YEAR);
                Calendar dateFrom = Calendar.getInstance();
                dateFrom.setTime(calculationDate.getTime());
                Calendar dateTo = Calendar.getInstance();
                Calendar lastPaymentDate = Calendar.getInstance();
                Calendar yearEnd = Calendar.getInstance();
                /******************************************************************************************************/
                cell = new PdfPCell(new Paragraph("LEDGER FOR CONSUMER NUMBER - " + master.getConsNo()));
                cell.setBorder(Rectangle.NO_BORDER);
                cell.setColspan(9);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPaddingBottom(20.0f);
                table.addCell(cell);

                try {

                    cell = new PdfPCell(new Paragraph("Consumer No:"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);

                    if (!(conNO[str.indexOf(index)].equals("1st"))) {
                        cell = new PdfPCell(new Paragraph(master.getConsNo() + "\n(" + conNO[str.indexOf(index)] + " Conn.)"));
                    } else {
                        cell = new PdfPCell(new Paragraph(master.getConsNo()));
                    }
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);




                    cell = new PdfPCell(new Paragraph("Consumer Name:"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    cell.setColspan(2);
                    table.addCell(cell);

                    if (master.getTransNm() == null) {
                        System.out.println("transfer namer is...." + master.getTransNm());
                        cell = new PdfPCell(new Paragraph(master.getConsNm1()));
                    } else {
                        cell = new PdfPCell(new Paragraph(master.getTransNm()));
                    }
                    //  cell = new PdfPCell(new Paragraph(master.getConsNm1()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setColspan(3);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);


                    cell = new PdfPCell(new Paragraph("Address:"));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph(master.getBlkNo() + "-" + master.getFlatNo() + "/" + master.getSector()));
                    cell.setBorder(Rectangle.NO_BORDER);
                    cell.setPaddingBottom(10.0f);
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);


                    cell = new PdfPCell(new Paragraph("Bill From"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Blill Upto"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Rate"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Paid_Amt"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Pay_Date"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Credit"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Principal"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Interest"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Paragraph("Arrear"));
                    cell.setBorder(Rectangle.BOTTOM);
                    cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    table.addCell(cell);

                    /*********************************************************************************************************************************************************************************/
                    for (int i = 0; i <= billPeriod || dateFrom.before(billTo); i++) {
                        System.out.println("......................................................................................");
                        paidAmount = 0.0;
                        billAmount = 0.0;
                        double cessInterest = 2.0;
                        yearEnd = billUtility.getDateTo(1, dateFrom);
                        String connCateg = "";
                        if (master.getConsCtg().equals("T") && master.getCompDate() != null && master.getCompDate().before(dateFrom.getTime())) {
                            connCateg = "R";
                        } else {
                            connCateg = master.getConsCtg();
                        }
                        if (master.getPipeSize() != null) {
                            //cessRate = billUtility.getCess(dateFrom, master.getConTp(), master.getPipeSize().doubleValue());
                             cessRate= getCessRate(dateFrom.getTime(), master.getPipeSize().doubleValue(),  master.getConTp());
                            System.out.println("cess rate=" + cessRate + "duration=" + ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1));
                            cessInterest = cessAmount * ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1) * 2 / 100;
                            cessAmount = cessInterest + cessAmount + cessRate * ((yearEnd.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1);
                            if (master.getConTp().equals("G")) {
                                billRate = getRateForGroupHousing(master.getConsNo(), dateFrom.getTime());
                            } else if (master.getPipeSize().intValue() == 15 && master.getFlatType().trim().equals("PLOT")) {
                                billRate = getRate(master.getConTp(), connCateg, master.getFlatType(), master.getPlotSize(), master.getPipeSize(), dateFrom.getTime());
                            } else if (!master.getFlatType().trim().equals("PLOT")) {
                                billRate = getRateForFlat(master.getConTp(), connCateg, master.getFlatType(), master.getPipeSize().intValue(), master.getSector(), dateFrom.getTime());
                            } else {
                                billRate = getRateForBulk(master.getConTp(), connCateg, master.getFlatType(), master.getPipeSize(), dateFrom.getTime());
                            }
                            billRate1 = billRate;
                        }
                        interestRate = getInterestRate(dateFrom.getTime());

                        billCycle = billUtility.getBillCycle(billRate, dateFrom);
                        cyclePeriod = billUtility.getBillPeriod(billCycle, dateFrom);

                        Calendar dateFromForCycle2 = Calendar.getInstance();
                        dateFromForCycle2.setTime(dateFrom.getTime());
                        dateTo = billUtility.getDateTo(billCycle, dateFromForCycle2);
                        if (i == 0) {
                            lastPaymentDate.setTime(dateTo.getTime());
                        }
                        double preArear = 0.0;
                        if (arrear > 0) {
                            preArear = arrear;
                        }
                        double localArrear = 0.0;
                        double localInterest = 0.0;
                        for (int j = 0; j < billCycle && dateFromForCycle2.before(billTo); j++) {
                            billAmount = 0.0;
                            paidAmount = 0.0;

                            rebate = 0.0;

                            List<Challan> challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&BlPerFr&BlPerTo").setParameter("consNo", consumerList[m]).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
                            int dateDifference = 0;
                            if (challanList.isEmpty()) {
                                challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&Financialyear").setParameter("consNo", consumerList[m]).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
                            }
                            if (!challanList.isEmpty()) {
                                challan = challanList.get(0);
                                if (challan.getPayDate() == null) {
                                    challan.setPayDate(dateTo.getTime());
                                }
                                if (challan.getBillAmt() != null) {
                                    if (challan.getPayDate() != null) {
                                        rebate = billUtility.getRebate(dateFrom, challan.getPayDate(), billRate * 12, challan.getBillAmt(), billCycle);
                                    } else {
                                        rebate = billUtility.getRebate(dateFrom, dateTo.getTime(), billRate * 12, challan.getBillAmt(), billCycle);
                                    }
                                }
                                System.out.println("date=" + dateFrom.getTime() + " paid date=" + challan.getPayDate() + " billamount=" + (billRate * 12) + " paidamount=" + challan.getPaidAmt() + " billcycle=" + billCycle);
                                // billAmount = billRate * ((yearEnd.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - yearEnd.get(Calendar.MONTH)) + 1);
                                billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                                billRate1 = billRate;
                                // billRate = 0;
                                paidAmount = challan.getPaidAmt().doubleValue();
                                paymentDate.setTime(challan.getPayDate());

                                if (challan.getCss() != null) {
                                    paidAmount = paidAmount - challan.getCss();
                                    cessAmount = cessAmount - challan.getCss();
                                }
                                if (challan.getDiscount() != null) {
                                    paidAmount = paidAmount - challan.getDiscount();
                                }
                                if (challan.getSecu() != null) {
                                    paidAmount = paidAmount - challan.getSecu().doubleValue();
                                }


                                System.out.println("paymentdate=" + paymentDate.getTime());
                                System.out.println("last payment date=" + lastPaymentDate.getTime());
                                preArear = preArear + localInterest;
                                System.out.println("prearrea=" + preArear);
                                if (paymentDate.after(lastPaymentDate) && credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                    interest = interest + preArear * interestRate * ((paymentDate.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - paymentDate.get(Calendar.MONTH)) + 1) / (100 * 12);
                                    Calendar f = Calendar.getInstance();
                                    Calendar d = Calendar.getInstance();
                                    f.setTimeInMillis(lastPaymentDate.getTimeInMillis());
                                    d.setTimeInMillis(paymentDate.getTimeInMillis());
                                    //interest = interest + preArear * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                                }

                                if (paymentDate.after(dateTo) && credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                    Calendar f = Calendar.getInstance();
                                    Calendar d = Calendar.getInstance();
                                    f.setTimeInMillis(dateTo.getTimeInMillis());
                                    d.setTimeInMillis(paymentDate.getTimeInMillis());
                                    interest = interest + billAmount * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                                }
                                principal = principal + billAmount - (paidAmount + rebate + credit);
                                System.out.println("principal between financial year..............=" + principal);
                                System.out.println("interest between financial year..............=" + interest);

                                if (principal < 0) {

                                    principal = principal + interest;
                                    interest = 0;



                                    if (principal < 0) {
                                        credit = -principal;
                                        principal = 0;
                                    } else {
                                        credit = 0;
                                    }
                                } else {
                                    credit = 0;
                                }

                                if (credit < 0) {
                                    principal = -credit;
                                    credit = 0;
                                }
//                                else {
//                                    principal = 0;
//                                }

                                lastPaymentDate.set(paymentDate.get(Calendar.YEAR), paymentDate.get(Calendar.MONTH), paymentDate.get(Calendar.DATE));
                                //paymentDate.setTime(dateTo.getTime());
                                paymentDate.set(dateTo.get(Calendar.YEAR), dateTo.get(Calendar.MONTH), dateTo.get(Calendar.DATE));
                                Calendar f = Calendar.getInstance();
                                Calendar d = Calendar.getInstance();
                                f.setTimeInMillis(lastPaymentDate.getTimeInMillis());
                                d.setTimeInMillis(paymentDate.getTimeInMillis());

                                // interest = interest + principal * interestRate * ((paymentDate.get(Calendar.YEAR) - lastPaymentDate.get(Calendar.YEAR)) * 12 - (lastPaymentDate.get(Calendar.MONTH) - paymentDate.get(Calendar.MONTH))) / 1200;
                                if (credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                    interest = interest + principal * interestRate * billUtility.yearDiff(f, d) / 1200;
                                    
                                }
                                arrear = principal + interest;
                                preArear = arrear;

                                lastPaymentDate.setTime(dateTo.getTime());

                            } //                            else if (challanList.isEmpty() && billRate == 0) {
                            //                                paymentDate.setTime(dateTo.getTime());
                            //
                            //                                billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                            //                                //  preArear = preArear + localInterest;
                            //                                //  BigDecimal bigPreArear = new BigDecimal(preArear);
                            //                                //  preArear = bigPreArear.setScale(2, RoundingMode.CEILING).doubleValue();
                            //                                if (paymentDate.after(lastPaymentDate)) {
                            //
                            //                                    interest = interest + preArear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                            //                                    BigDecimal bigInterest = new BigDecimal(interest);
                            //
                            //                                }
                            //
                            //                                principal = principal + billAmount - credit;
                            //                                BigDecimal bigPrincipal = new BigDecimal(principal);
                            //                                //principal = bigPrincipal.setScale(2, RoundingMode.CEILING).doubleValue();
                            //                                if (principal < 0) {
                            //                                    credit = -principal;
                            //                                    arrear = 0;
                            //                                    principal = 0;
                            //                                    interest = 0;
                            //                                } else {
                            //                                    credit = 0;
                            //                                }
                            //                                arrear = principal + interest;
                            //                                BigDecimal bigArrear = new BigDecimal(arrear);
                            //                                //arrear = bigArrear.setScale(2, RoundingMode.CEILING).doubleValue();
                            //                                preArear = preArear + billAmount;
                            //                                lastPaymentDate.setTime(dateTo.getTime());
                            //
                            //                            }
                            else {
                                paymentDate.setTime(dateTo.getTime());

                                billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                                preArear = preArear + localInterest;
                                BigDecimal bigPreArear = new BigDecimal(preArear);
                                // preArear = bigPreArear.setScale(2, RoundingMode.CEILING).doubleValue();
                                int dy = dateTo.get(Calendar.YEAR);
                                int dy1 = billTo.get(Calendar.YEAR);
                                int mo = dateTo.get(Calendar.MONTH);
                                int mo1 = billTo.get(Calendar.MONTH);
                                System.out.println("dy=" + dy + "dy1=" + dy1 + "mo=" + mo + "mo1=" + mo1);
                                if ((dy == dy1 && mo == mo1)) {
                                    rebate = billUtility.getRebate(dateFrom, billTo.getTime(), billRate1 * 12, billRate1 * 12, billCycle);
                                }
                                if (paymentDate.after(lastPaymentDate) && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                    System.out.println("Prearrer=" + preArear);
                                    interest = interest + preArear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                                    BigDecimal bigInterest = new BigDecimal(interest);
                                    //interest = bigInterest.setScale(2, RoundingMode.CEILING).doubleValue();

                                    localInterest = (localArrear) * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                                }
                                localArrear = localArrear + billAmount;
//
                                principal = principal + billAmount - credit - rebate;
                                System.out.println("principal between financial year..............=" + principal);
                                System.out.println("interest between financial year..............=" + interest);
                                preArear = preArear + billAmount - credit - rebate;
                                BigDecimal bigPrincipal = new BigDecimal(principal);

                                if (principal < 0) {
                                    credit = -principal;
                                    arrear = 0;
                                    principal = 0;
                                    interest = 0;
                                    preArear = 0;
                                } else {
                                    credit = 0;
                                }
                                arrear = principal + interest;
                                BigDecimal bigArrear = new BigDecimal(arrear);
                                //arrear = bigArrear.setScale(2, RoundingMode.CEILING).doubleValue();

                                lastPaymentDate.setTime(dateTo.getTime());
                            }

                            System.out.println("paid amount=" + paidAmount);
                            System.out.println("date form=" + dateFromForCycle2.getTime());
                            System.out.println("date to=" + dateTo.getTime());
                            System.out.println("interest rate=" + interestRate);
                            System.out.println("bill Rate=" + billRate);
                            System.out.println("cess Rate=" + cessRate);
                            System.out.println("rebate=" + rebate);
                            System.out.println("bill amount=" + billAmount);
                            System.out.println("credit=" + credit);
                            System.out.println("principal=" + principal);
                            System.out.println("interest=" + interest);
                            System.out.println("arrear=" + arrear);
                            System.out.println("cess amount=" + cessAmount);

                            cell = new PdfPCell(new Paragraph(dateFormat.format(dateFromForCycle2.getTime())));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                            table.addCell(cell);


                            cell = new PdfPCell(new Paragraph(dateFormat.format(dateTo.getTime())));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                            table.addCell(cell);



                            DecimalFormat decimalFormate = new DecimalFormat("#0.00 ");
                            String bill_rate = decimalFormate.format(billRate1);
                            cell = new PdfPCell(new Paragraph(bill_rate));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(cell);



                            decimalFormate = new DecimalFormat("#0.00 ");
                            String paid_amount = decimalFormate.format(paidAmount);
                            cell = new PdfPCell(new Paragraph(String.valueOf(paid_amount)));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(cell);

                            if (paidAmount > 0) {
                                cell = new PdfPCell(new Paragraph(dateFormat.format(challan.getPayDate())));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                table.addCell(cell);
                            } else {
                                cell = new PdfPCell(new Paragraph(""));
                                cell.setBorder(Rectangle.NO_BORDER);
                                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                                table.addCell(cell);
                            }



                            decimalFormate = new DecimalFormat("#0.00 ");
                            String Credit = decimalFormate.format(credit);
                            cell = new PdfPCell(new Paragraph(Credit));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(cell);
                            decimalFormate = new DecimalFormat("#0.00 ");
                            String Principal = decimalFormate.format(principal);
                            cell = new PdfPCell(new Paragraph(Principal));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(cell);
                            decimalFormate = new DecimalFormat("#0.00 ");
                            String Interest = decimalFormate.format(interest);
                            cell = new PdfPCell(new Paragraph(Interest));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            table.addCell(cell);
                            decimalFormate = new DecimalFormat("#0.00 ");
                            String Arrear = decimalFormate.format(arrear);
                            cell = new PdfPCell(new Paragraph(Arrear));
                            cell.setBorder(Rectangle.NO_BORDER);
                            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
                            cell.setColspan(12);
                            //cell.setPaddingBottom(20.0f);
                            table.addCell(cell);
                            dateFromForCycle2.set(dateTo.get(Calendar.YEAR), dateTo.get(Calendar.MONTH) + 1, 1);
                            System.out.println("dateform=" + dateFromForCycle2.getTime());
                            System.out.println("cycleperiod=" + cyclePeriod);
                            dateTo = billUtility.getDateTo(billCycle, dateFromForCycle2);
                            if (cyclePeriod == billCycle) {
                                break;
                            } else {
                                cyclePeriod = billUtility.getBillPeriod(billCycle, dateFromForCycle2);
                            }
                        }
                        System.out.println("bill cycle=" + billCycle);

                        dateFrom.setTime(dateFromForCycle2.getTime());

                    }
                    /*********************************************************************************************************************************************************************************/
                    table.setWidthPercentage(100);
                    table.setHorizontalAlignment(Element.ALIGN_CENTER);
                    this.document.add(table);

                    this.document.newPage();
                    // document1.add(new Paragraph("  "));





                } catch (Exception e) {
                    System.err.println("Exception in dopost" + e);
                }
//                this.status1++;
                //System.out.println(" this.status1-------- "+ this.status1);
            }


        }

        public int getStatus1() {
            return status1;
        }

        public void setStatus1(int status1) {
            this.status1 = status1;
        }

        public boolean isCancel() {
            return cancel;
        }

        public void setCancel(boolean cancel) {
            this.cancel = cancel;
        }
    }

    public double getRate(String connType, String connCategory, String flatType, BigDecimal plotSize, BigDecimal pipeSize, Date rateYear) {
        Calendar rateYear2 = Calendar.getInstance();
        rateYear2.setTime(rateYear);
        rateYear2.set(rateYear2.get(Calendar.YEAR), rateYear2.get(Calendar.MONTH) + 1, rateYear2.get(Calendar.DATE));
        rateYear = rateYear2.getTime();
        Calendar staffDate = Calendar.getInstance();
        staffDate.set(1999, 10, 30);
        Calendar rateYear1 = Calendar.getInstance();
        rateYear1.setTime(rateYear);

        List<Rates> RateList = em.createNamedQuery("Rates.findByCriteria").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("minPlotSize", plotSize).setParameter("maxPlotSize", plotSize).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
        double rate = 0.0;
        if (!RateList.isEmpty()) {
            rate = RateList.get(0).getRate();
        }
        if (connType.equals("S") && rateYear1.after(staffDate)) {
            rate = 0.0;
        }
        return rate;
    }

    public double getRateForBulk(String connType, String connCategory, String flatType, BigDecimal pipeSize, Date rateYear) {
        Calendar rateYear2 = Calendar.getInstance();
        rateYear2.setTime(rateYear);
        rateYear2.set(rateYear2.get(Calendar.YEAR), rateYear2.get(Calendar.MONTH) + 1, rateYear2.get(Calendar.DATE));
        rateYear = rateYear2.getTime();
        List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForBulk").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
        double rate = 0.0;
        if (!RateList.isEmpty()) {
            rate = RateList.get(0).getRate();
        }
        return rate;
    }

    public double getRateForGroupHousing(String consumerNo, Date rateYear) {
        List<HousingRate> RateList = em.createNamedQuery("HousingRate.findByCriteria").setParameter("consNo", consumerNo).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
        double rate = 0.0;
        if (!RateList.isEmpty()) {
            rate = RateList.get(0).getRate();
        }
        return rate;
    }

    public double getRateForFlat(String connType, String connCategory, String flatType, int pipeSize, String sector, Date rateYear) {
        List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForFlat").setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).setParameter("flatType", flatType).setParameter("sector", sector).getResultList();
        double rate = 0.0;
        if (!RateList.isEmpty()) {
            rate = RateList.get(0).getRate();
        }
        return rate;
    }

    public double getInterestRate(Date rateDate) {

        List<InterestRates> interestRateList = em.createNamedQuery("InterestRates.findByDateBetween").setParameter("dateFrom", rateDate).setParameter("dateTo", rateDate).getResultList();
        InterestRates interestRates = new InterestRates();
        double rate = 0.0;
        if (!interestRateList.isEmpty()) {
            interestRates = interestRateList.get(0);
            rate = interestRates.getRate();
        }
        return rate;
    }
public Double getCessRate(Date cessDate,double pipeSize, String conType) {

        List<CessRate> cessRateList = em.createNamedQuery("CessRate.findByPipeSize&connType&Date").setParameter("pipeSize", pipeSize).setParameter("conType", "%"+conType+"%").setParameter("dateFrom", cessDate).setParameter("dateTo", cessDate).getResultList();
        CessRate cessRate = new CessRate();
        double rate = 0.0;
        if (!cessRateList.isEmpty()) {
            cessRate = cessRateList.get(0);
            rate = cessRate.getRate();
        }
        return rate;
       // System.out.println("cess list size="+cessRateList.size());
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DocumentException, ParserConfigurationException, SAXException {


        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        HttpSession session = request.getSession();
        String path = request.getServletPath();


        if (path.equals("/Ledgergen")) {
            String division = (String) session.getAttribute("division");
            String[] consumerList = (String[]) request.getAttribute("consumerList");
            String dateTo1 = request.getParameter("billdate");
            String statusbar = request.getParameter("statusbar");

            Document document1;
            Rectangle pageSize;
            pageSize = new Rectangle(864, 1080);
            document1 = new Document(pageSize);
            PdfWriter docWriter = PdfWriter.getInstance(document1, baos);
            document1.open();
            LedgerThread ledgerThread = new LedgerThread(division, consumerList, dateTo1, document1);
            session.setAttribute("ledgerThread", ledgerThread);
            session.setAttribute("flag1", "0");
            Thread ledger = new Thread(ledgerThread);
            ledger.start();

            while (ledger.isAlive()) {
                if (statusbar.equals("1")) {
                    session.setAttribute("status1", ledgerThread.getStatus1() * 100 / consumerList.length);
                }
            }
            document1.addAuthor("NOIDA JAL");
            System.out.println("consumerList.length----- " + consumerList.length);
            if (consumerList.length == 1) {
                document1.addTitle("Ledger - " + consumerList[0]);
            } else {
                document1.addTitle("Ledger List");
            }
            session.setAttribute("flag1", "2");
            document1.close();
            session.setAttribute("baos", baos);
        } else if (path.equals("/getLedgerList")) {
            ByteArrayOutputStream baos1 = (ByteArrayOutputStream) session.getAttribute("baos");
            response.setHeader("Content-Disposition", " filename=Ledger");
            response.setHeader("Expires", "0");
            response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "public");
            response.setContentType("application/pdf");
            ServletOutputStream out = response.getOutputStream();
            baos1.writeTo(out);
            out.flush();
        } else if (path.equals("/CancelLedger")) {
            System.out.println("************************************************************************************************************rwrwrewrewwerwrw");
            LedgerThread ledgerThread = (LedgerThread) session.getAttribute("ledgerThread");
            ledgerThread.setCancel(false);
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
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(LedgerPdf.class.getName()).log(Level.SEVERE, null, ex);
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
