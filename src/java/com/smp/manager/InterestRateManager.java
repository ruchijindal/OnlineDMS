/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.entity.CessRate;
import com.smp.entity.InterestRates;
import com.smp.session.CessRateFacade;
import com.smp.session.InterestRatesFacade;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import java.util.Date;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Admin
 */
@Stateless
public class InterestRateManager {

    @EJB
    InterestRatesFacade interestRatesFacade;
    @EJB
    CessRateFacade cessRateFacade;
    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    InterestRates interestRates = new InterestRates();
    Date dateFrom = null;
    Date dateTo = null;
    Double rate;
    private ArrayList<String> ratelist;
    ArrayList<InterestRates> rateList = new ArrayList<InterestRates>();
    CessRate cessRate = new CessRate();
    Date CdateFrom = null;
    Date CdateTo = null;
    Double Crate;
    private ArrayList<String> cessratelist;
    ArrayList<CessRate> cessrateList = new ArrayList<CessRate>();

    public void createInterestRates(Date dateFrom, Date dateTo, Double rate) {

        interestRates = new InterestRates();
        Query maxId = em.createNamedQuery("Rates.findByMaxId");
        BigDecimal id = (BigDecimal) maxId.getResultList().get(0);
        if (id != null) {
            interestRates.setId(BigDecimal.valueOf(id.doubleValue() + 1));
        } else {
            interestRates.setId(BigDecimal.valueOf(1));
        }
        interestRates.setId(id);
        interestRates.setDateFrom(dateFrom);
        interestRates.setDateTo(dateTo);
        interestRates.setRate(rate);

        interestRatesFacade.create(interestRates);




    }

    public void editInterestRates(String id, Date dateFrom, Date dateTo, Double rate) {
        interestRates = new InterestRates();
        long id1 = Long.parseLong(id);
        BigDecimal id2 = BigDecimal.valueOf(id1);
        interestRates = interestRatesFacade.find(id2);
        interestRates.setDateFrom(dateFrom);
        interestRates.setDateTo(dateTo);
        interestRates.setRate(rate);
        interestRatesFacade.edit(interestRates);




    }

    public void deleteInterestRates(String id) {
        interestRates = new InterestRates();
        long id1 = Long.parseLong(id);
        BigDecimal id2 = BigDecimal.valueOf(id1);
        interestRates = interestRatesFacade.find(id2);

        interestRatesFacade.remove(interestRates);

    }

    public List<InterestRates> findRateList() {
        InterestRates interestRates = new InterestRates();

        List<InterestRates> list = interestRatesFacade.findAll();

        return list;

    }

    public void createCessRate(String conType, Date dateFrom, Date dateTo, String pipeSize, Double rate) {
        cessRate = new CessRate();
        Query maxId = em.createNamedQuery("CessRate.findByMaxId");
        BigDecimal id = (BigDecimal) maxId.getResultList().get(0);
        if (id != null) {
            cessRate.setId(BigDecimal.valueOf(id.doubleValue() + 1));
        } else {
            cessRate.setId(BigDecimal.valueOf(1));
        }
        cessRate.setConType(conType);
        cessRate.setDateFrom(dateFrom);
        cessRate.setDateTo(dateTo);
        cessRate.setRate(rate);
        cessRate.setPipeSize(BigInteger.valueOf(Long.parseLong(pipeSize)));
        cessRateFacade.create(cessRate);




    }

    public void editCessRate(String id, String conType, Date dateFrom, Date dateTo, String pipeSize, Double rate) {
        cessRate = new CessRate();
        long id1 = Long.parseLong(id);
        BigDecimal id2 = BigDecimal.valueOf(id1);
        cessRate = cessRateFacade.find(id2);
        cessRate.setConType(conType);
        cessRate.setDateFrom(dateFrom);
        cessRate.setDateTo(dateTo);
        cessRate.setRate(rate);
        cessRate.setPipeSize(BigInteger.valueOf(Long.parseLong(pipeSize)));
        cessRateFacade.edit(cessRate);




    }

    public void deleteCessRate(String id) {
        cessRate = new CessRate();
        long id1 = Long.parseLong(id);
        BigDecimal id2 = BigDecimal.valueOf(id1);
        cessRate = cessRateFacade.find(id2);

        cessRateFacade.remove(cessRate);

    }

    public List<CessRate> findCessRateList() {
        CessRate cessRate = new CessRate();

        List<CessRate> list = cessRateFacade.findAll();

        return list;

    }
}
