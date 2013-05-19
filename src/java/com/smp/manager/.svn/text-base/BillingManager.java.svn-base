/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.dms.BillDescription;
import com.smp.dms.BillUtility;
import com.smp.entity.CessRate;
import com.smp.entity.Challan;
import com.smp.entity.DiscountRate;
import com.smp.entity.HousingRate;
import com.smp.entity.InterestRates;
import com.smp.entity.Master;
import com.smp.entity.Rates;

import com.smp.jal.ConvertToDate;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author smp-06
 */
//@Stateless
public class BillingManager implements Runnable {

    // @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    BillUtility billUtility = new BillUtility();
    ConvertToDate convertToDate = new ConvertToDate();
    Challan challan;
    String division;
    int status;
    boolean cancel;
    List<Master> masterList = new ArrayList<Master>();
    //String consumerNo;
    Calendar dateTo;
    Calendar dueDate;
    double oldArear;
    Calendar arrearUpto;
    List<BillDescription> billDescriptions = new ArrayList<BillDescription>();
    Thread thread;

    public BillingManager() {
    }

    public BillingManager(EntityManager em) {
        this.em = em;
    }

    public BillingManager(String division, List<Master> masterList, Calendar dateTo, Calendar dueDate, double oldArrear, Calendar arrearUpto, EntityManager em) {
        this.em = em;
        this.division = division;
        // this.consumerNo = consumerNo;
        this.masterList = masterList;
        this.dateTo = dateTo;

        this.dueDate = dueDate;
        this.oldArear = oldArrear;
        this.arrearUpto = arrearUpto;
        this.status = 0;
        this.cancel = true;
//        thread = new Thread(this, "1");
//        thread.start();
    }

    @Override
    public void run() {
        this.billDescriptions = calculateBill(this.division, this.masterList, this.dateTo, this.dueDate, this.oldArear, this.arrearUpto, this.em);
    }

    public double getRate(String connType, String connCategory, String flatType, BigDecimal plotSize, BigDecimal pipeSize, Date rateYear) {
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
        List<Rates> RateList = em.createNamedQuery("Rates.findByCriteriaForBulk").setParameter("pipeSize", pipeSize).setParameter("connType", connType).setParameter("connCategory", connCategory).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
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

    public double getRateForGroupHousing(String consumerNo, Date rateYear) {
        List<HousingRate> RateList = em.createNamedQuery("HousingRate.findByCriteria").setParameter("consNo", consumerNo).setParameter("dateFrom", rateYear).setParameter("dateTo", rateYear).getResultList();
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

    public double getDiscount(Date discountDate) {
        List<DiscountRate> discountRateList = em.createNamedQuery("DiscountRate.findByDateBetween").setParameter("dateFrom", discountDate).setParameter("dateTo", discountDate).getResultList();
        DiscountRate discountRate = new DiscountRate();
        double rate = 0.0;
        if (!discountRateList.isEmpty()) {
            discountRate = discountRateList.get(0);
            rate = discountRate.getRate();
        }
        return rate;
    }

    public List<BillDescription> calculateBill(String division, List<Master> masterList, Calendar billTo, Calendar dueDate, double oldArrear, Calendar arrearUpto, EntityManager em) {

        List<BillDescription> billDescriptionList = new ArrayList<BillDescription>();
        for (int x = 0; x < masterList.size() && this.cancel; x++) {
            this.status++;
            BillDescription billDescription = new BillDescription();
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
            int billCycle = 1;
            int cyclePeriod = 1;
            Master master = (Master) em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", masterList.get(x).getConsNo()).getResultList().get(0);
            System.out.println("connection category=" + master.getConsCtg());
            if (master.getConsCtg() == null || master.getConTp() == null || master.getFlatType() == null || (master.getFlatType() != null && (master.getFlatType().equals("PLOT") && master.getPlotSize() == null) || master.getPipeSize() == null || (master.getCalDate() == null && master.getNodueDt() == null))) {
                billDescription = null;
            } else {

                Calendar calculationDate = billUtility.getCalDate(master.getNodueDt(), master.getCalDate());
                Calendar startDate = Calendar.getInstance();
                startDate.set(1990, 3, 1);
                if (arrearUpto != null && calculationDate.before(startDate)) {
                    arrear = oldArrear;
                    calculationDate.setTime(arrearUpto.getTime());
                }
                int billPeriod = billTo.get(Calendar.YEAR) - calculationDate.get(Calendar.YEAR);
                if (calculationDate.get(Calendar.MONTH) < 3) {
                    billPeriod++;
                }
                Calendar dateFrom = Calendar.getInstance();
                dateFrom.setTime(calculationDate.getTime());
                Calendar dateTo = Calendar.getInstance();
                Calendar lastPaymentDate = Calendar.getInstance();
                Calendar yearEnd = Calendar.getInstance();
                for (int i = 0; i < billPeriod || dateFrom.before(billTo); i++) {

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
                       // cessRate = billUtility.getCess(dateFrom, master.getConTp(), master.getPipeSize().doubleValue());
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
                    if (billRate1 == 0) {
                        break;
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

                        List<Challan> challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&BlPerFr&BlPerTo").setParameter("consNo", masterList.get(x).getConsNo()).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
                        int dateDifference = 0;
                        if (challanList.isEmpty()) {
                            challanList = em.createNamedQuery("Challan" + division + ".findByConsNo&Financialyear").setParameter("consNo", masterList.get(x).getConsNo()).setParameter("blPerFr", dateFromForCycle2.getTime()).setParameter("blPerTo", dateTo.getTime()).getResultList();
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
                            billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                            billRate1 = billRate;
                            //billRate = 0;
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
                                //interest = interest + arrear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / (100 * 12);
                                Calendar f = Calendar.getInstance();
                                Calendar d = Calendar.getInstance();
                                f.setTimeInMillis(lastPaymentDate.getTimeInMillis());
                                d.setTimeInMillis(paymentDate.getTimeInMillis());
                                interest = interest + preArear * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                            }

                            if (paymentDate.after(dateTo) && credit <= 0 && paymentDate.getTimeInMillis() <= dueDate.getTimeInMillis()) {
                                Calendar f = Calendar.getInstance();
                                Calendar d = Calendar.getInstance();
                                f.setTimeInMillis(dateTo.getTimeInMillis());
                                d.setTimeInMillis(paymentDate.getTimeInMillis());
                                interest = interest + billAmount * interestRate * billUtility.yearDiff(f, d) / (100 * 12);
                            }
                            principal = principal + billAmount - (paidAmount + rebate + credit);
                            System.out.println("principal between financial year..............=" + principal + "aa" + preArear + "cr" + credit);
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

                        } //                        else if (challanList.isEmpty() && billRate == 0) {
                        //                            paymentDate.setTime(dateTo.getTime());
                        //
                        //                            billAmount = billRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1);
                        //                            //  preArear = preArear + localInterest;
                        //                            //  BigDecimal bigPreArear = new BigDecimal(preArear);
                        //                            //  preArear = bigPreArear.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            if (paymentDate.after(lastPaymentDate)) {
                        //
                        //                                interest = interest + preArear * interestRate * ((dateTo.get(Calendar.YEAR) - dateFromForCycle2.get(Calendar.YEAR)) * 12 - (dateFromForCycle2.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1) / 1200;
                        //                                BigDecimal bigInterest = new BigDecimal(interest);
                        //
                        //                            }
                        //
                        //                            principal = principal + billAmount - credit;
                        //                            BigDecimal bigPrincipal = new BigDecimal(principal);
                        //                            //principal = bigPrincipal.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            if (principal < 0) {
                        //                                credit = -principal;
                        //                                arrear = 0;
                        //                                principal = 0;
                        //                                interest = 0;
                        //                            } else {
                        //                                credit = 0;
                        //                            }
                        //                            arrear = principal + interest;
                        //                            BigDecimal bigArrear = new BigDecimal(arrear);
                        //                            //arrear = bigArrear.setScale(2, RoundingMode.CEILING).doubleValue();
                        //                            preArear = preArear + billAmount;
                        //                            lastPaymentDate.setTime(dateTo.getTime());
                        //
                        //                        }
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
                                rebate = billUtility.getRebate(dateFrom, billTo.getTime(), billRate1 * 12, billRate1 * ((dateTo.get(Calendar.YEAR) - dateFrom.get(Calendar.YEAR)) * 12 - (dateFrom.get(Calendar.MONTH) - dateTo.get(Calendar.MONTH)) + 1), billCycle);
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
                            principal = principal + billAmount - credit;
                            preArear = preArear + billAmount - credit;
                            BigDecimal bigPrincipal = new BigDecimal(principal);
                            //principal = bigPrincipal.setScale(2, RoundingMode.CEILING).doubleValue();
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
                            // preArear = preArear + billAmount;
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
                        dateFromForCycle2.set(dateTo.get(Calendar.YEAR), dateTo.get(Calendar.MONTH) + 1, 1);
                        System.out.println("dateform=" + dateFromForCycle2.getTime());
                        System.out.println("cycleperiod=" + cyclePeriod);
                        dateTo = billUtility.getDateTo(billCycle, dateFromForCycle2);
                        if (cyclePeriod == billCycle) {
                            break;
                        }
                        cyclePeriod = billUtility.getBillPeriod(billCycle, dateFromForCycle2);
                    }
                    System.out.println("bill cycle=" + billCycle);


                    dateFrom.setTime(dateFromForCycle2.getTime());
                }
                if (billRate1 != 0) {
                    Calendar from = Calendar.getInstance();
                    Calendar to = Calendar.getInstance();
                    if (from.get(Calendar.MONTH) < 3) {
                        from.set(from.get(Calendar.YEAR) - 1, 3, 1);
                        to.set(billTo.get(Calendar.YEAR), billTo.get(Calendar.MONTH), billTo.get(Calendar.DATE));
                    } else {
                        from.set(from.get(Calendar.YEAR), 3, 1);
                        to.set(billTo.get(Calendar.YEAR), billTo.get(Calendar.MONTH), billTo.get(Calendar.DATE));
                    }
                    //rebate = billUtility.getRebate(from, dueDate.getTime(), billRate1 * 12, billRate1 * ((to.get(Calendar.YEAR) - from.get(Calendar.YEAR)) * 12 - (from.get(Calendar.MONTH) - to.get(Calendar.MONTH)) + 1), billCycle);
                    double discount = getDiscount(dueDate.getTime());
                    billDescription.setDueDate(dueDate.getTime());
                    billDescription.setBillFrom(from.getTime());
                    billDescription.setBillTo(to.getTime());
                    billDescription.setCessAmount(cessAmount);
                    billDescription.setConsNO(masterList.get(x).getConsNo());
                    billDescription.setInterest(interest);
                    billDescription.setPrincipal(principal);
                    billDescription.setRate(billRate1);
                    billDescription.setRebate(rebate);
                    billDescription.setDiscount(discount);
                } else {
                    billDescription = null;
                }
                // return billDescription;
            }
            billDescriptionList.add(billDescription);
//            this.status++;
        }
        return billDescriptionList;
    }

    public List<BillDescription> getBillDescriptions() {
        return billDescriptions;
    }

    public void setBillDescriptions(List<BillDescription> billDescriptions) {
        this.billDescriptions = billDescriptions;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean isCancel() {
        return cancel;
    }

    public void setCancel(boolean cancel) {
        this.cancel = cancel;
    }
}
