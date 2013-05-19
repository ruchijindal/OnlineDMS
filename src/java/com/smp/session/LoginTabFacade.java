/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.smp.session;

import com.smp.entity.LoginTab;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author smp-06
 */
@Stateless
public class LoginTabFacade extends AbstractFacade<LoginTab> {
    @PersistenceContext(unitName = "NEWDMSPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public LoginTabFacade() {
        super(LoginTab.class);
    }

}
