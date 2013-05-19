/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.session;

import com.smp.entity.Challan2;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author smp-06
 */
@Stateless
public class Challan2Facade extends AbstractFacade<Challan2> {
    @PersistenceContext(unitName = "NEWDMSPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public Challan2Facade() {
        super(Challan2.class);
    }

}
