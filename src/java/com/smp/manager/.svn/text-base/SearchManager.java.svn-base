/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.entity.Challan;
import com.smp.entity.Challan1;
import com.smp.entity.Challan2;
import com.smp.entity.Challan3;
import com.smp.entity.Master;
import com.smp.entity.Master1;
import com.smp.entity.Master2;
import com.smp.entity.Master3;
import com.smp.entity.Sewerdetails;
import com.smp.entity.Sewerdetails1;
import com.smp.entity.Sewerdetails2;
import com.smp.entity.Sewerdetails3;
import com.smp.session.Challan1Facade;
import com.smp.session.Challan2Facade;
import com.smp.session.Challan3Facade;
import com.smp.session.Master1Facade;
import com.smp.session.Master2Facade;
import com.smp.session.Master3Facade;
import com.smp.session.Sewerdetails1Facade;
import com.smp.session.Sewerdetails2Facade;
import com.smp.session.Sewerdetails3Facade;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

/**
 *
 * @author smp-06
 */
@Stateless
public class SearchManager {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    Master1Facade master1Facade;
    @EJB
    Master2Facade master2Facade;
    @EJB
    Master3Facade master3Facade;
    @EJB
    Sewerdetails1Facade sewerdetails1Facade;
    @EJB
    Sewerdetails2Facade sewerdetails2Facade;
    @EJB
    Sewerdetails3Facade sewerdetails3Facade;
    @EJB
    Challan1Facade challan1Facade;
    @EJB
    Challan2Facade challan2Facade;
    @EJB
    Challan3Facade challan3Facade;
    DateFormat formatter;
    Date blPerFr;
    Date blPerTo;
    Date dueDt;
    Date payDate;
    BigInteger id;
    BigInteger billAmt;
    BigInteger Surcharge;
    BigInteger Arrear;
    BigInteger Credit;
    BigInteger Noc;
    BigInteger Rmc;
    BigInteger chlSecu;
    BigInteger tFee;
    BigInteger paidAmt;
   
    public ArrayList<String> getSectors(String division, String xmlPath) {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db;
        ArrayList<String> sectorList = new ArrayList<String>();
        try {
            db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlPath);
            NodeList jalList = doc.getElementsByTagName("jal" + division.trim());

            NodeList jalChildList = jalList.item(0).getChildNodes();
            for (int i = 1; i < jalChildList.getLength(); i = i + 2) {
                sectorList.add(jalChildList.item(i).getTextContent());

            }

        } catch (Exception ex) {
            Logger.getLogger(SearchManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sectorList;


    }

    public List getMasters(String division) {
        System.out.println("masterlist size in manager>>>>>");

        List masterList = new ArrayList();

        String status = "UA";
        masterList = em.createNamedQuery("Master" + division + ".findByStatus").setParameter("status", status).getResultList();
        System.out.println("masterlist size in manager" + masterList.size());
        return masterList;
    }

    public List getAuthoriseMasters(String division, String consumerNo, String username, Date createdDate) {
        System.out.println("masterlist size in manager>>>>>");
        Master master = null;

        List masterList = new ArrayList();
        masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();

        //   Master master= (Master)em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
        if (!masterList.isEmpty()) {
            master = (Master) masterList.get(0);
            master.setStatus("A");
            master.setAuthoriseBy(username);
            master.setAuthorizedDate(createdDate);
            if (division.equals("1")) {
                master1Facade.edit((Master1) master);
            } else if (division.equals("2")) {
                master2Facade.edit((Master2) master);
            } else if (division.equals("3")) {
                master3Facade.edit((Master3) master);
            }
        }

        String status = "UA";
        masterList = em.createNamedQuery("Master" + division + ".findByStatus").setParameter("status", status).getResultList();
        System.out.println("masterlist size in manager" + masterList.size());
        return masterList;
    }

    public List getChallans(String division) {
        System.out.println("masterlist size in manager>>>>>");

        List challanList = new ArrayList();

        String status = "UA";
        challanList = em.createNamedQuery("Challan" + division + ".findByStatus").setParameter("status", status).getResultList();
        System.out.println("masterlist size in manager" + challanList.size());
        return challanList;
    }

    public Boolean getAuthoriseChallans(String division, String consumerNo, String id, String username, Date createdDate) {
        System.out.println("masterlist size in manager>>>>>");
        boolean flag = false;
        Challan challan = null;
        List challanList = new ArrayList();

        Master master = null;
        List masterList = new ArrayList();
        System.out.println("masterlist size in manager>>>>>" + division);
        System.out.println("masterlist size in manager>>>>>" + consumerNo);
        System.out.println("masterlist size in manager>>>>>" + id);
        System.out.println("masterlist size in manager>>>>>" + username);
        System.out.println("masterlist size in manager>>>>>" + createdDate);

        masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
        System.out.println(">>>>>" + division);
        System.out.println(">>>>>" + consumerNo);
        System.out.println(">>>>>" + id);
        System.out.println(">>>>>" + username);
        System.out.println(">>>>>" + createdDate);
        if (!masterList.isEmpty()) {
            master = (Master) masterList.get(0);
            String masterstatus = master.getStatus();
            System.out.println(">>>>>" + masterstatus);

            if (masterstatus == null || masterstatus.equals("A")) {
                challanList = em.createNamedQuery("Challan" + division + ".findById").setParameter("id", Double.parseDouble(id)).getResultList();
                if (!challanList.isEmpty()) {
                    challan = (Challan) challanList.get(0);
                    System.out.println(">>>>challan status>" + challan.getStatus());

                    challan.setStatus("A");
                    challan.setAuthoriseBy(username);
                    challan.setAuthorizedDate(createdDate);

                    if (division.equals("1")) {
                        challan1Facade.edit((Challan1) challan);
                    } else if (division.equals("2")) {
                        challan2Facade.edit((Challan2) challan);
                    } else if (division.equals("3")) {
                        challan3Facade.edit((Challan3) challan);
                    }

                    flag = true;
                    System.out.println("authorised master");

                }
            } else {
                flag = false;
                System.out.println("unauthorised master");
            }
        }

        return flag;


    }

    public List<Master> searchByMaster(String sector,String division){
        System.out.println("in /search manager"+sector.trim());

      List masterList=  new ArrayList<Master>();
       try {
         
            masterList.clear();

            if (sector.equals("") || (sector == null)) {
                sector = null;
            }

//            if (block.equals("") || (block == null)) {
//               block = null;
//            }
            Query query = em.createNamedQuery("Master"+division+".findBySelectedValues");
            query.setParameter("sector", sector.trim());
//            query.setParameter("blkNo", block.trim());
            query.setParameter("status", "UA");
            
            masterList = query.getResultList();
            System.out.println("masterlist>>>>>>>>>>>>>"+masterList.size());


        } catch (Exception e) {
            e.printStackTrace();
        }
        return masterList;

    }

      public List<Challan> searchByChallan(String sector,String division){
           System.out.println("in search manager>>>>>>>>>"+sector);
//           System.out.println("in search manager>>>>>>>>>"+block);

       List challanList=new ArrayList();
       try {

           challanList.clear();

            if (sector.equals("") || (sector == null)) {
                sector = null;
            }

//            if (block.equals("") || (block == null)) {
//               block = null;
//            }
            Query query = em.createNamedQuery("Challan"+division+".findBySelectedValues");
            query.setParameter("sec", sector.trim());
//            query.setParameter("blk", block);
            query.setParameter("status", "UA");

            challanList = query.getResultList();
            System.out.println("masterlist>>>>>>>>>>>>>"+challanList.size());


        } catch (Exception e) {
            e.printStackTrace();
        } return challanList;
    }
      
    public String getBlocks(String division, String sector) {
        String block = "";
        int flag = 0;
        List<String> blockList = em.createNamedQuery("Master" + division + ".findBySectorDistinct").setParameter("sector", sector).getResultList();
        for (int i = 0; i < blockList.size(); i++) {
            if (block.equals("")) {
                if (blockList.get(i) == null) {
                    block = "N/A";
                    flag = 1;
                } else {
                    block = blockList.get(i);
                }
            } else {
                if (blockList.get(i) == null) {
                    block = block + ":" + "N/A";
                    flag = 1;
                } else {
                    block = block + ":" + blockList.get(i);
                }
            }
        }
        if (flag == 0) {
            block = block + ":" + "N/A";
        }
        return block;
    }

    public Master getConsumerDetails(String division, String consumerNo) {
        Master master = null;
        List masterList = em.createNamedQuery("Master" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();

        if (!masterList.isEmpty()) {
            master = (Master) masterList.get(0);
        }
        return master;
    }

    public Sewerdetails getSewerDetails(String division, String consumerNo) {
        Sewerdetails sewerdetails = null;
        List sewerdetailsList = em.createNamedQuery("Sewerdetails" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
        if (!sewerdetailsList.isEmpty()) {
            sewerdetails = (Sewerdetails) sewerdetailsList.get(0);
        }
        return sewerdetails;
    }

    public List getChallanDetails(String division, String consumerNo) {
        List challan1List = new ArrayList();
        challan1List = em.createNamedQuery("Challan" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
        return challan1List;
    }

    public List getBills(String division, String consumerNo) {
        List billrepositoryList = new ArrayList();
        billrepositoryList = em.createNamedQuery("Billrepository" + division + ".findByConsNo").setParameter("consNo", consumerNo).getResultList();
        return billrepositoryList;
    }

    public void updateConsumerDetail(String division, String consumerNo, String consumerName1, String connectionType, String connectionCategory, String flatType, String flatNo, String blockNo, String sector, double plotSize, double pipeSize, String regNo, Date connectionDate, String estimationNo, double estimationAmount, double security, Date estimationDate, double estimation1Amount, double noDueAmount, Date noDueDate, String transferName, String trf, Date calculationDate, Date possesionDate, Date completionDate, double id, String editedBY, Date editedDate, String userRole) {
        try {
            Master masterTemp;

            Master master = (Master) em.createNamedQuery("Master" + division + ".findById").setParameter("id", id).getResultList().get(0);
            masterTemp = master;
            master.setConsNo(consumerNo);
            master.setConsNm1(consumerName1);
            master.setConTp(connectionType);
            master.setConsCtg(connectionCategory);
            master.setFlatType(flatType);
            master.setFlatNo(flatNo);
            master.setBlkNo(blockNo);
            master.setSector(sector);
            master.setPlotSize(BigDecimal.valueOf(plotSize));
            master.setPipeSize(BigDecimal.valueOf(pipeSize));
            master.setRegNo(regNo);
            master.setConnDt(connectionDate);
            master.setEstiNo(estimationNo);
            master.setEstiAmt(BigDecimal.valueOf(estimationAmount));
            master.setNodueAmt(BigDecimal.valueOf(noDueAmount));
            master.setEstiDt(noDueDate);
            master.setTransNm(transferName);
            master.setTrf(trf);
            master.setCalDate(calculationDate);
            master.setPosDate(possesionDate);
            master.setCompDate(completionDate);
            master.setEditedBy(editedBY);
            master.setEditedDate(editedDate);
            if (userRole.equals("employee")) {

                master.setStatus("UA");
            }
 else{
                master.setStatus("A");
                master.setAuthoriseBy(editedBY);
                master.setAuthorizedDate(editedDate);
 }
            if (division.equals("1")) {
                master1Facade.edit((Master1) master);
            } else if (division.equals("2")) {
                master2Facade.edit((Master2) master);
            } else if (division.equals("3")) {
                master3Facade.edit((Master3) master);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteConsumerDetail(String division, double id) {
        if (division.equals("1")) {
            Master1 master1 = master1Facade.find(BigDecimal.valueOf(id));
            master1Facade.remove(master1);
        } else if (division.equals("2")) {
            Master2 master2 = master2Facade.find(BigDecimal.valueOf(id));
            master2Facade.remove(master2);
        } else if (division.equals("3")) {
            Master3 master3 = master3Facade.find(BigDecimal.valueOf(id));
            master3Facade.remove(master3);
        }
    }

    public void createSewerDetail(String division, double id, String consumerNO, String sRegNo, Date sConnDate, String sEstimationNo, int sEstimationAmount, int sSecurity, int sEstimationPaidAmt, Date sEstimationPaidDate, Date sNoDueDate, int sNoDueAmt, String createdBy, Date createdDate) {
        Sewerdetails sewerdetails = new Sewerdetails1();
        if (division.equals("1")) {
            sewerdetails = new Sewerdetails1();
        } else if (division.equals("2")) {
            sewerdetails = new Sewerdetails2();
        } else if (division.equals("3")) {
            sewerdetails = new Sewerdetails3();
        }
        sewerdetails.setConsNo(consumerNO);
        sewerdetails.setId(id);
        sewerdetails.setSRegNo(sRegNo);
        sewerdetails.setSConDt(sConnDate);
        sewerdetails.setSEstNo(sEstimationNo);
        sewerdetails.setSEstAmt(sEstimationAmount);
        sewerdetails.setSSecu(sSecurity);
        sewerdetails.setSEstPamt(sEstimationPaidAmt);
        sewerdetails.setSEstPdate(sEstimationPaidDate);
        sewerdetails.setSNodueDt(sNoDueDate);
        sewerdetails.setSNodueAmt(sNoDueAmt);
        sewerdetails.setCreatedBy(createdBy);
        sewerdetails.setCreatedDate(createdDate);
        if (division.equals("1")) {
            sewerdetails1Facade.create((Sewerdetails1) sewerdetails);
        } else if (division.equals("2")) {
            sewerdetails2Facade.create((Sewerdetails2) sewerdetails);
        } else if (division.equals("3")) {
            sewerdetails3Facade.create((Sewerdetails3) sewerdetails);
        }
    }

    public void updateSewerDetail(String division, double id, String consumerNO, String sRegNo, Date sConnDate, String sEstimationNo, int sEstimationAmount, int sSecurity, int sEstimationPaidAmt, Date sEstimationPaidDate, Date sNoDueDate, int sNoDueAmt, String editedBy, Date editedDate) {
        Sewerdetails sewerdetails = (Sewerdetails) em.createNamedQuery("Sewerdetails" + division + ".findById").setParameter("id", id).getResultList().get(0);
        sewerdetails.setConsNo(consumerNO);
        sewerdetails.setSRegNo(sRegNo);
        sewerdetails.setSConDt(sConnDate);
        sewerdetails.setSEstNo(sEstimationNo);
        sewerdetails.setSEstAmt(sEstimationAmount);
        sewerdetails.setSSecu(sSecurity);
        sewerdetails.setSEstPamt(sEstimationPaidAmt);
        sewerdetails.setSEstPdate(sEstimationPaidDate);
        sewerdetails.setSNodueDt(sNoDueDate);
        sewerdetails.setSNodueAmt(sNoDueAmt);
        sewerdetails.setEditedBy(editedBy);
        sewerdetails.setEditedDate(editedDate);
        if (division.equals("1")) {
            sewerdetails1Facade.edit((Sewerdetails1) sewerdetails);
        } else if (division.equals("2")) {
            sewerdetails2Facade.edit((Sewerdetails2) sewerdetails);
        } else if (division.equals("3")) {
            sewerdetails3Facade.edit((Sewerdetails3) sewerdetails);
        }
    }

    public List<Master> sectorSearch(String division, String sector) {
        //  System.out.println("block in manager...");
        List<Master> masterList = new ArrayList<Master>();
        masterList = em.createNamedQuery("Master" + division + ".findBySector").setParameter("sector", sector).getResultList();
        return (masterList);
    }

    public List<Master> blockSearch(String division, String sector, String block) {
        //    System.out.println("block in manager..."+block);
        List<Master> masterList = new ArrayList<Master>();
        Query query = em.createNamedQuery("Master" + division + ".findBySectorAndBlkNo");
        query.setParameter("sector", sector);
        query.setParameter("blkNo", block);
        masterList = query.getResultList();
        return (masterList);
    }

    public List<Master> search(String division, String sector, String block, String flatNo) {
        List<Master> masterList = new ArrayList<Master>();
        Query query = em.createNamedQuery("Master" + division + ".findBySectorAndBlkNoAndFlatNo");
        query.setParameter("sector", sector);
        query.setParameter("blkNo", block);
        query.setParameter("flatNo", flatNo);
        masterList = query.getResultList();
        if(masterList.isEmpty())
        {
         
            flatNo="0"+flatNo;
            query.setParameter("flatNo", flatNo);
            masterList=query.getResultList();
        }
        if(masterList.isEmpty())
        {
            flatNo="00"+flatNo;
            query.setParameter("flatNo", flatNo);
            masterList=query.getResultList();
        }
        return (masterList);
    }

    public void insertChallan(String division, String cons_no, String flat_no, String blk, String sec, String bl_per_fr, String bl_per_to, String due_dt, String bill_amt, String surcharge, String paid_amt, String pay_date, String arrear, String credit, String recp_no, String dis_cd, String noc, String rmc, String chlsecu, String t_fee, String css, String bnk_cd, String br_nm, String createdBy, Date createdDate, String userRole) {
        try {
            Query maxId = em.createNamedQuery("Challan" + division + ".findBymaxid");
            Object maximumId = maxId.getResultList().get(0);
           Double id1 = (Double) maximumId;
            Challan challan = null;
            if (division.equals("1")) {
                challan = new Challan1();
            } else if (division.equals("2")) {
                challan = new Challan2();
            } else if (division.equals("3")) {
                challan = new Challan3();
            }
            if ((id1 != null)) {
                challan.setId(id1 + 1);

            } else {
                challan.setId(1.0);

            }
            challan.setConsNo(cons_no);
            challan.setFlatNo(flat_no);
            challan.setSec(sec);
            challan.setBlk(blk);
            formatter = new SimpleDateFormat("dd/MM/yy");
            blPerFr = (Date) formatter.parse(bl_per_fr);
            challan.setBlPerFr(blPerFr);
            formatter = new SimpleDateFormat("dd/MM/yy");
            blPerTo = (Date) formatter.parse(bl_per_to);
            challan.setBlPerTo(blPerTo);
            formatter = new SimpleDateFormat("dd/MM/yy");
            if (due_dt != null && !due_dt.equals("")) {
                dueDt = (Date) formatter.parse(due_dt);
            } else {
                dueDt = null;
            }
            challan.setDueDt(dueDt);
            if (bill_amt != null && !bill_amt.equals("")) {
                challan.setBillAmt(Double.parseDouble(bill_amt));
            }
            if (surcharge != null && !surcharge.equals("")) {
                challan.setSurcharge(Double.parseDouble(surcharge));
            }
            if (paid_amt != null && !paid_amt.equals("")) {
                challan.setPaidAmt(Double.parseDouble(paid_amt));
            }
            formatter = new SimpleDateFormat("dd/MM/yy");
            if (pay_date != null && !pay_date.equals("")) {
                payDate = (Date) formatter.parse(pay_date);
            }
            challan.setPayDate(payDate);
            if (arrear != null && !arrear.equals("")) {
                challan.setArrear(Double.parseDouble(arrear));
            }
            if (credit != null && !credit.equals("")) {
                challan.setCredit(Double.parseDouble(credit));
            }
            challan.setRecpNo(recp_no);
            challan.setDisCd(dis_cd);
            if (noc != null && !noc.equals("")) {
                challan.setNoc(Double.parseDouble(noc));
            }
            if (rmc != null && !rmc.equals("")) {
                challan.setRmc(Double.parseDouble(rmc));
            }
            if (chlsecu != null && !chlsecu.equals("")) {
                challan.setSecu(Double.parseDouble(chlsecu));
            }
            if (t_fee != null && !t_fee.equals("")) {
                challan.setTFee(Double.parseDouble(t_fee));
            }
            challan.setCreatedBy(createdBy);
            challan.setCreatedDate(createdDate);
            if (userRole.equals("employee")) {
                challan.setStatus("UA");
            } else {
                challan.setStatus("A");
                challan.setAuthoriseBy(createdBy);
                challan.setAuthorizedDate(createdDate);
            }
            if (css != null && !css.equals("")) {
                challan.setCss(Double.parseDouble(css));
            }
            challan.setBnkCd(bnk_cd);
            challan.setBrNm(br_nm);
            if (division.equals("1")) {
                challan1Facade.create((Challan1) challan);
            } else if (division.equals("2")) {
                challan2Facade.create((Challan2) challan);
            } else if (division.equals("3")) {
                challan3Facade.create((Challan3) challan);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editChallan(String division, String row_id, String bl_per_fr, String bl_per_to, String due_dt, String bill_amt, String surcharge, String paid_amt, String pay_date, String arrear, String credit, String recp_no, String dis_cd, String noc, String rmc, String chlsecu, String t_fee, String css, String bnk_cd, String br_nm, String editedBy, Date editedDate, String userRole) {
        try {

            Challan challan = null;
            Challan challanTemp = null;
            challan = (Challan) em.createNamedQuery("Challan" + division + ".findById").setParameter("id", Double.parseDouble(row_id)).getResultList().get(0);
            challanTemp = challan;
            if (bl_per_fr.equals("")) {
                blPerFr = null;
            } else {
                formatter = new SimpleDateFormat("dd/MM/yy");
                blPerFr = (Date) formatter.parse(bl_per_fr);
            }
            challan.setBlPerFr(blPerFr);
            if (bl_per_to.equals("")) {
                blPerTo = null;
            } else {
                formatter = new SimpleDateFormat("dd/MM/yy");
                blPerTo = (Date) formatter.parse(bl_per_to);
            }
            challan.setBlPerTo(blPerTo);
            System.out.println("due_dt========= " + due_dt);
            if (due_dt.equals("")) {
                dueDt = null;
            } else {
                formatter = new SimpleDateFormat("dd/MM/yy");
                dueDt = (Date) formatter.parse(due_dt);
            }
            challan.setDueDt(dueDt);

            if (bill_amt.equals("")) {
               challan.setBillAmt(null);
            } else {

                 challan.setBillAmt(Double.parseDouble(bill_amt));
            }

            if (surcharge.equals("")) {
                challan.setSurcharge(null);
            } else {
               challan.setSurcharge(Double.parseDouble(surcharge));
            }
            
            if (paid_amt.equals("")) {
               challan.setPaidAmt(Double.parseDouble(null));
            } else {

                challan.setPaidAmt(Double.parseDouble(paid_amt));
            }
            

            formatter = new SimpleDateFormat("dd/MM/yy");
            if (pay_date.equals("")) {
                payDate = null;
            } else {
                formatter = new SimpleDateFormat("dd/MM/yy");
                payDate = (Date) formatter.parse(pay_date);
            }
            challan.setPayDate(payDate);
            if (arrear.equals("")) {
                 challan.setArrear(null);
            } else {
                challan.setArrear(Double.parseDouble(arrear));
            }

            if (credit.equals("")) {
                challan.setCredit(null);
            } else {
                challan.setCredit(Double.parseDouble(credit));
            }

            if (recp_no.equals("")) {
                recp_no = null;
            }
            challan.setRecpNo(recp_no);

            if (dis_cd.equals("")) {
                dis_cd = null;
            }
            challan.setDisCd(dis_cd);

            if (noc.equals("")) {
                challan.setNoc(null);
            } else {
                challan.setNoc(Double.parseDouble(noc));
            }

            if (rmc.equals("")) {
                 challan.setRmc(null);
            } else {
                  challan.setRmc(Double.parseDouble(rmc));
            }


            if (chlsecu.equals("")) {
                 challan.setSecu(null);
            } else {
                challan.setSecu(Double.parseDouble(chlsecu));
            }

            if (t_fee.equals("")) {
                 challan.setTFee(null);
            } else {
                challan.setTFee(Double.parseDouble(t_fee));
            }
          

            if (css != null && !css.equals("")) {
                challan.setCss(Double.parseDouble(css));
            }

            if (bnk_cd.equals("")) {
                bnk_cd = null;
            }
            challan.setBnkCd(bnk_cd);

            if (br_nm.equals("")) {
                br_nm = null;
            }
            challan.setBrNm(br_nm);
            challan.setEditedBy(editedBy);
            challan.setEditedDate(editedDate);

            if (userRole.equals("employee")) {

                challan.setStatus("UA");
            }else{
                challan.setStatus("A");
                challan.setAuthoriseBy(editedBy);
                challan.setAuthorizedDate(editedDate);
            }
            if (division.equals("1")) {
                challan1Facade.edit((Challan1) challan);
            } else if (division.equals("2")) {
                challan2Facade.edit((Challan2) challan);
            } else if (division.equals("3")) {
                challan3Facade.edit((Challan3) challan);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteChallan(String division, String row_id) {
        try {
            if (division.equals("1")) {
                Challan1 challan1 = new Challan1();
                challan1 = challan1Facade.find(Double.parseDouble(row_id));
                challan1Facade.remove(challan1);
            } else if (division.equals("2")) {
                Challan2 challan2 = new Challan2();
                challan2 = challan2Facade.find(Double.parseDouble(row_id));
                challan2Facade.remove(challan2);
            } else if (division.equals("3")) {
                Challan3 challan3 = new Challan3();
                challan3 = challan3Facade.find(Double.parseDouble(row_id));
                challan3Facade.remove(challan3);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
