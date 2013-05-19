/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.session;

import com.smp.entity.HousingRate;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author smp-06
 */
@Stateless
public class HousingRateFacade extends AbstractFacade<HousingRate> {
    @PersistenceContext(unitName = "NEWDMSPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public HousingRateFacade() {
        super(HousingRate.class);
    }

}
