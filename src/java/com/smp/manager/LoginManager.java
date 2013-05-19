/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.manager;

import com.smp.entity.LoginTab;
import com.smp.session.LoginTabFacade;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author smp-06
 */
@Stateless
public class LoginManager {

    @PersistenceContext(unitName = "NEWDMSPU")
    EntityManager em;
    @EJB
    LoginTabFacade loginTabFacade;
    LoginTab loginTab = new LoginTab();
    List<LoginTab> loginTabList = new ArrayList<LoginTab>();
    MessageDigest algorithm = null;

    public int validateUser(String userName, String password) {
        int flag = 0;
        try {
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
            for (int i = 0; i < loginTabList.size(); i++) {
                if (loginTabList.get(i).getUserid().equals(userName) && loginTabList.get(i).getPassword().equals(password)) {
                    flag = 1;
                    break;
                } else {
                    flag = 0;
                }
            }

        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return flag;
    }

    public List<LoginTab> find(String userName, String password) {
        try {
            algorithm = MessageDigest.getInstance("SHA-256");

            // loginTabList = loginTabFacade.findAll();
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
             System.out.println("username"+userName);
            System.out.println("password"+password);
            loginTabList.clear();
            loginTabList = em.createNamedQuery("LoginTab.findByUseridAndPassword").setParameter("userid", userName).setParameter("password", password).getResultList();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return loginTabList;
    }

    public int changePassword(String userId, String oldPassword, String newPassword, String confirmPassword) throws NoSuchAlgorithmException {
        algorithm = MessageDigest.getInstance("SHA-256");
        loginTab = loginTabFacade.find(userId);
        byte[] defaultBytes = oldPassword.getBytes();
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
        oldPassword = hexString.toString();
        if (!oldPassword.equals(loginTab.getPassword())) {
            return 0;
        } else if (!newPassword.equals(confirmPassword)) {
            return 1;
        } else {
            algorithm = MessageDigest.getInstance("SHA-256");
            byte[] defaultBytes1 = newPassword.getBytes();
            algorithm.reset();
            algorithm.update(defaultBytes1);
            byte[] messageDigest1 = algorithm.digest();
            StringBuffer hexString1 = new StringBuffer();
            for (int i = 0; i < messageDigest1.length; i++) {
                String hex1 = Integer.toHexString(0xFF & messageDigest1[i]);
                if (hex1.length() == 1) {
                    hexString1.append('0');
                }
                hexString1.append(hex1);
            }
            newPassword = hexString1.toString();
            loginTab.setPassword(newPassword);
            loginTabFacade.edit(loginTab);
         
            return 2;

        }


    }
}
