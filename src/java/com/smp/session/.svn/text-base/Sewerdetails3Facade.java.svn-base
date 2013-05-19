/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.session;

import com.smp.entity.Sewerdetails3;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author smp-06
 */
@Stateless
public class Sewerdetails3Facade extends AbstractFacade<Sewerdetails3> {
    @PersistenceContext(unitName = "NEWDMSPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public Sewerdetails3Facade() {
        super(Sewerdetails3.class);
    }

}
