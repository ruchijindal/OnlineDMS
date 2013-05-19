/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.entity.DiscountRate;
import com.smp.entity.HousingRate;
import com.smp.entity.LoginTab;
import com.smp.entity.Rates;
import com.smp.session.DiscountRateFacade;
import com.smp.session.HousingRateFacade;
import com.smp.session.LoginTabFacade;
import com.smp.session.RatesFacade;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
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
 * @author smp
 */
@Stateless
public class DmssettingsManager {

    @EJB
    RatesFacade ratesFacade;
    @EJB
    LoginTabFacade loginTabFacade;
    @EJB
    DiscountRateFacade discountRateFacade;
    @EJB
    HousingRateFacade housingRateFacade;
    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    Rates rates = new Rates();
    LoginTab loginTab = new LoginTab();
    HttpSession session;
    DateFormat formatter;
    Date date_from;
    Date date_to;
    Date datefrom;
    Date dateto;
    long min_plot_size;
    long max_plot_size;
    long pipe_size;
    double rates2;
    long id1;
    BigDecimal id2;
    MessageDigest algorithm = null;
    String encyptpass = "";
    java.util.Date date = new java.util.Date();
    long createDate;
    long lastLoginDate;
    BigDecimal id;
    List<Rates> ratesList = new ArrayList<Rates>();
    LoginTab loginTab1 = new LoginTab();
    DiscountRate discountRate;
    HousingRate housingRate;
    String password;
    int flag = 0;
    List<LoginTab> loginTabList = new ArrayList<LoginTab>();

    public List<Rates> setRates(String connectionType, String connectionCategory, String flatType, String sector, String dateFrom, String minPlotSize, String maxPlotSize, String pipeSize, String rate, String connectionType_1, String connectionCategory_1, String dateFrom_1, String plotSize_1, String pipeSize_1) {
        try {

            Query maxId = em.createNamedQuery("Rates.findByMaxId");
            id = (BigDecimal) maxId.getResultList().get(0);
            rates = new Rates();
            if (id != null) {
                rates.setId(BigDecimal.valueOf(id.doubleValue() + 1));
            } else {
                rates.setId(BigDecimal.valueOf(1));
            }


            rates.setConnType(connectionType);
            rates.setConnCategory(connectionCategory);
            rates.setFlatType(flatType);
            rates.setSector(sector);
            formatter = new SimpleDateFormat("dd/MM/yy");
            date_from = (Date) formatter.parse(dateFrom);
            rates.setDateFrom(date_from);

            if ((minPlotSize == null) || (minPlotSize.equals(""))) {
                minPlotSize = "0";
            }
            min_plot_size = Long.parseLong(minPlotSize);
            rates.setMinPlotSize(BigInteger.valueOf(min_plot_size));
            if ((maxPlotSize == null) || (maxPlotSize.equals(""))) {
                maxPlotSize = "0";
            }
            max_plot_size = Long.parseLong(maxPlotSize);
            rates.setMaxPlotSize(BigInteger.valueOf(max_plot_size));
            if ((pipeSize == null) || (pipeSize.equals(""))) {
                pipeSize = "0";
            }
            pipe_size = Long.parseLong(pipeSize);
            rates.setPipeSize(BigInteger.valueOf(pipe_size));
            rates2 = Double.parseDouble(rate);
            rates.setRate(rates2);
            ratesFacade.create(rates);
            ratesList = new ArrayList<Rates>();
            ratesList = searchByConnType(connectionType_1, connectionCategory_1, flatType, sector, dateFrom_1, plotSize_1, pipeSize_1);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ratesList;

    }

    public List<Rates> editRates(String id, String connectionType, String connectionCategory, String flatType, String sector, String dateFrom, String minPlotSize, String maxPlotSize, String pipeSize, String rate, String connectionType_1, String connectionCategory_1, String dateFrom_1, String plotSize_1, String pipeSize_1) {
        try {
            rates = new Rates();
            id1 = Long.parseLong(id);
            id2 = BigDecimal.valueOf(id1);
            rates = ratesFacade.find(id2);
            rates.setConnType(connectionType);
            rates.setConnCategory(connectionCategory);
            rates.setFlatType(flatType);
            rates.setSector(sector);
            formatter = new SimpleDateFormat("dd/MM/yy");
            date_from = (Date) formatter.parse(dateFrom);
            rates.setDateFrom(date_from);
            min_plot_size = Long.parseLong(minPlotSize);
            rates.setMinPlotSize(BigInteger.valueOf(min_plot_size));
            max_plot_size = Long.parseLong(maxPlotSize);
            rates.setMaxPlotSize(BigInteger.valueOf(max_plot_size));
            pipe_size = Long.parseLong(pipeSize);
            rates.setPipeSize(BigInteger.valueOf(pipe_size));
            rates2 = Double.parseDouble(rate);
            rates.setRate(rates2);
            ratesFacade.edit(rates);
            ratesList = new ArrayList<Rates>();
            ratesList = searchByConnType(connectionType_1, connectionCategory_1, flatType, sector, dateFrom_1, plotSize_1, pipeSize_1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ratesList;

    }

    public List<Rates> deleteRates(String id, String connectionType_1, String connectionCategory_1, String flatType_1, String sector_1, String dateFrom_1, String plotSize_1, String pipeSize_1) {
        try {
            rates = new Rates();
            id1 = Long.parseLong(id);
            id2 = BigDecimal.valueOf(id1);
            System.out.println("id inside delete method==== " + id2);
            rates = ratesFacade.find(id2);
            ratesFacade.remove(rates);
            ratesList = new ArrayList<Rates>();
            ratesList = searchByConnType(connectionType_1, connectionCategory_1, flatType_1, sector_1, dateFrom_1, plotSize_1, pipeSize_1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ratesList;
    }

    public List<Rates> searchByConnType(String connectionType, String connectionCategory, String flatType, String sector, String dateFrom, String plotSize, String pipeSize) {
        try {
            ratesList = new ArrayList<Rates>();
            ratesList.clear();
            if (connectionType.equals("") || (connectionType == null)) {
                connectionType = null;
            }
            if (connectionCategory.equals("") || (connectionCategory == null)) {
                connectionCategory = null;
            }
            if (flatType.equals("") || (flatType == null)) {
                flatType = null;
            }
            if (sector.equals("") || (sector == null)) {
                sector = null;
            }
            if ((dateFrom == null) || dateFrom.equals("") || dateFrom.equals("__/__/__")) {
                date_from = null;
            } else {
                formatter = new SimpleDateFormat("dd/MM/yy");
                date_from = (Date) formatter.parse(dateFrom);
            }
            if ((plotSize == null) || plotSize.equals("")) {
                plotSize = null;
            }
            if (pipeSize.equals("") || (pipeSize == null)) {
                pipeSize = null;
            }
            Query query = em.createNamedQuery("Rates.findBySelectedValues");
            query.setParameter("connType", connectionType);
            query.setParameter("connCategory", connectionCategory);
            query.setParameter("flatType", flatType);
            query.setParameter("sector", sector);
            query.setParameter("dateFrom", date_from);

            query.setParameter("maxPlotSize", plotSize);
            query.setParameter("pipeSize", pipeSize);
            ratesList = query.getResultList();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ratesList;

    }

    public void createUser(String userid, String password, String firstname, String lastname, String userrole, String createdby, String division) {
        try {
            createDate = date.getTime();
            lastLoginDate = date.getTime();

            try {
                algorithm = MessageDigest.getInstance("SHA-256");
            } catch (NoSuchAlgorithmException nsae) {
                System.out.println("Cannot find digest algorithm" + nsae);
                System.exit(1);
            }

            byte[] defaultBytes = password.getBytes();
            algorithm.reset();
            algorithm.update(defaultBytes);
            byte messageDigest[] = algorithm.digest();
            StringBuffer hexString = new StringBuffer();

            for (int j = 0; j < messageDigest.length; j++) {
                String hex = Integer.toHexString(0xFF & messageDigest[j]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            encyptpass = hexString.toString();

            loginTab = new LoginTab();
            loginTab.setUserid(userid);
            loginTab.setPassword(encyptpass);
            loginTab.setUserrole(userrole);
            loginTab.setCrdate(new java.sql.Date(createDate));
            loginTab.setFirstName(firstname);
            loginTab.setLastName(lastname);
            loginTab.setCreatedBy(createdby);
            loginTab.setDivision(division);
            loginTabFacade.create(loginTab);
        } catch (Exception e) {
            System.out.println(e);
        }


    }

    public int checkUser(String userid) {
        LoginTab loginTab = new LoginTab();
        loginTab = loginTabFacade.find(userid);
        if (loginTab != null) {
            return 1;
        } else {
            return 0;
        }

    }

    public LoginTab getUserDetail(String userid) {
        loginTab = new LoginTab();
        loginTab = loginTabFacade.find(userid);
        return loginTab;
    }

    public void editUser(String userid, String userPassword, String firstname, String lastname, String userrole, String division) {
        try {

            loginTab = new LoginTab();
            loginTab1 = loginTabFacade.find(userid);
            if (userPassword.equals("password")) {
                password = loginTab1.getPassword();
            } else {

                password = userPassword;
                algorithm = MessageDigest.getInstance("SHA-256");

                loginTabList = loginTabFacade.findAll();
                byte[] defaultBytes = password.getBytes();
                algorithm.reset();
                algorithm.update(defaultBytes);
                byte[] messageDigest = algorithm.digest();
                StringBuffer hexString = new StringBuffer();
                for (int i = 0; i < messageDigest.length; i++) {
                    String hex = Integer.toHexString(0xFF & messageDigest[i]);
                    if (hex.length() == 1) {
                        hexString.append('0');
                    }
                    hexString.append(hex);
                }
                password = hexString.toString();
            }
            Date crdate = loginTab1.getCrdate();
            String createdBy = loginTab1.getCreatedBy();
            Date lastLodinDt = loginTab1.getLastloginDt();
            loginTab.setUserid(userid);
            loginTab.setPassword(password);
            loginTab.setUserrole(userrole);
            loginTab.setCrdate(crdate);
            loginTab.setLastloginDt(lastLodinDt);
            loginTab.setFirstName(firstname);
            loginTab.setLastName(lastname);
            loginTab.setCreatedBy(createdBy);
            loginTab.setDivision(division);
            loginTabFacade.edit(loginTab);
        } catch (Exception e) {
            System.out.println(e);
        }


    }

    public void deleteUser(String userid) {
        loginTab = loginTabFacade.find(userid);
        loginTabFacade.remove(loginTab);
    }

    public void setDiscountRate(String dateFrom, String dateTo, String rate) {
        try {
            discountRate = new DiscountRate();

            Query maxId = em.createNamedQuery("DiscountRate.findByMaxId");
            id = (BigDecimal) maxId.getResultList().get(0);

            if (id != null) {
                discountRate.setId(BigDecimal.valueOf(id.doubleValue() + 1));
            } else {
                discountRate.setId(BigDecimal.valueOf(1));
            }
            formatter = new SimpleDateFormat("dd/MM/yy");
            datefrom = (Date) formatter.parse(dateFrom);
            discountRate.setDateFrom(datefrom);
            formatter = new SimpleDateFormat("dd/MM/yy");
            dateto = formatter.parse(dateTo);
            discountRate.setDateTo(dateto);
            Double setRate = Double.parseDouble(rate);
            discountRate.setRate(setRate);
            discountRateFacade.create(discountRate);
        } catch (Exception ex) {
            ex.printStackTrace();
        }


    }

    public void editDiscountRate(String id, String dateFrom, String dateTo, String rate) {
        try {
            System.out.println("inside edit discount rates method");
            discountRate = new DiscountRate();
            System.out.println("id--------- " + id);
            id1 = Long.parseLong(id);
            discountRate = (DiscountRate) em.createNamedQuery("DiscountRate.findById").setParameter("id", BigDecimal.valueOf(id1)).getResultList().get(0);
            System.out.println("discountRate===" + discountRate);
            formatter = new SimpleDateFormat("dd/MM/yy");
            datefrom = (Date) formatter.parse(dateFrom);
            discountRate.setDateFrom(datefrom);
            formatter = new SimpleDateFormat("dd/MM/yy");
            dateto = formatter.parse(dateTo);
            discountRate.setDateTo(dateto);
            Double setRate = Double.parseDouble(rate);
            discountRate.setRate(setRate);
            discountRateFacade.edit(discountRate);

        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    public void deleteDiscountRate(String id) {
        id1 = Long.parseLong(id);
        discountRate = new DiscountRate();
        discountRate = (DiscountRate) em.createNamedQuery("DiscountRate.findById").setParameter("id", BigDecimal.valueOf(id1)).getResultList().get(0);
        discountRateFacade.remove(discountRate);
    }

    public List sectorList(String xmlPath) {



        ArrayList<String> sectorList = new ArrayList<String>();
        ArrayList<Integer> sectorListnum = new ArrayList<Integer>();
        ArrayList<String> sectorListChar = new ArrayList<String>();
        List list = new ArrayList();


        try {

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();

            Document doc = db.parse(xmlPath);

            NodeList nl1 = doc.getElementsByTagName("sector");
            int len = nl1.getLength();
            sectorList.clear();
            sectorListnum.clear();
            sectorListChar.clear();
            String sectorNO;
            for (int i = 0; i < len; i++) {
                sectorNO = nl1.item(i).getFirstChild().getNodeValue();
                if ((sectorNO.charAt(0) >= 'A' && sectorNO.charAt(0) <= 'Z') || (sectorNO.charAt(0) >= 'a' && sectorNO.charAt(0) <= 'z')) {
                    sectorListChar.add(sectorNO);
                } else {

                    if (sectorNO.length() > 2) {
                        char[] chrArray = sectorNO.toCharArray();
                        boolean flag = false;

                        for (int j = 0; j < chrArray.length; j++) {
                            if ((chrArray[j] >= 'A' && chrArray[j] <= 'Z') || (chrArray[j] >= 'a' && chrArray[j] <= 'z')) {
                                flag = true;
                                break;
                            }
                        }
                        if (flag == true) {
                            sectorList.add(sectorNO);

                        } else {
                            sectorListnum.add(Integer.parseInt(sectorNO));

                        }
                    } else {
                        sectorList.add(sectorNO);
                    }
                }

            }
            Collections.sort(sectorList);
            Collections.sort(sectorListnum);
            Collections.sort(sectorListChar);

            list.addAll(sectorList);
            list.addAll(sectorListnum);
            list.addAll(sectorListChar);

        } catch (Exception ex) {
            System.out.println(ex);
        }
        return list;
    }

    public List<HousingRate> housingRateList(String consumerNo) {
        List<HousingRate> housingRateList = new ArrayList<HousingRate>();
        housingRateList.clear();
        housingRateList = em.createNamedQuery("HousingRate.findByConsNo").setParameter("consNo", consumerNo).getResultList();
        return housingRateList;
    }

    public void insertHousingBill(String consumerNo, String dateFrom, String dateTo, String rate) {
        try {
            housingRate = new HousingRate();
            Query maxId = em.createNamedQuery("HousingRate.findByMaxId");
            id = (BigDecimal) maxId.getResultList().get(0);


            if (id != null) {
                housingRate.setId(BigDecimal.valueOf(id.doubleValue() + 1));
            } else {
                housingRate.setId(BigDecimal.valueOf(1));
            }

            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yy");
            date_from = (Date) dateFormat.parse(dateFrom);

            housingRate.setDateFrom(date_from);
            date_to = (Date) dateFormat.parse(dateTo);

            housingRate.setDateTo(date_to);
            Double rate1 = Double.valueOf(rate);
            housingRate.setRate(rate1);

            housingRate.setConsNo(consumerNo.trim());
            housingRateFacade.create(housingRate);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editHousingRate(String id, String dateFrom, String dateTo, String rate) {
        try {
            id1 = Long.parseLong(id);
            id2 = BigDecimal.valueOf(id1);
            HousingRate findRate = housingRateFacade.find(id2);
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yy");
            date_from = (Date) dateFormat.parse(dateFrom);
            findRate.setDateFrom(date_from);
            date_to = (Date) dateFormat.parse(dateTo);
            findRate.setDateTo(date_to);
            Double rate1 = Double.valueOf(rate);
            findRate.setRate(rate1);
            housingRateFacade.edit(findRate);


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteHousingRate(String id) {
        id1 = Long.parseLong(id);
        id2 = BigDecimal.valueOf(id1);
        HousingRate findRate1 = housingRateFacade.find(id2);
        housingRateFacade.remove(findRate1);
    }

    public int checkHousingRates(String cons_no, Calendar findcalDate, String billTo) {
        try {
            List<HousingRate> housingRates = new ArrayList<HousingRate>();
            DateFormat formater = new SimpleDateFormat("dd/MM/yy");
            Date bill_To = (Date) formater.parse(billTo);
            Calendar cal = Calendar.getInstance();
            cal.setTime(bill_To);


            while (findcalDate.before(cal)) {
                housingRates = em.createNamedQuery("HousingRate.findByCriteria").setParameter("consNo", cons_no).setParameter("dateFrom", findcalDate.getTime()).setParameter("dateTo", findcalDate.getTime()).getResultList();

                if (housingRates.isEmpty()) {
                    flag = 1;
                    break;
                } else {
                    flag = 0;
                }
                findcalDate.set(findcalDate.get(Calendar.YEAR) + 1, findcalDate.get(Calendar.MONTH), findcalDate.get(Calendar.DATE));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }
}
