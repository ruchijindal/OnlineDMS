/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Admin
 */
@Entity
@Table(name = "LOGIN_TAB")
@NamedQueries({
    @NamedQuery(name = "LoginTab.findAll", query = "SELECT l FROM LoginTab l"),
    @NamedQuery(name = "LoginTab.findByUserid", query = "SELECT l FROM LoginTab l WHERE l.userid = :userid"),
    @NamedQuery(name = "LoginTab.findByUseridAndPassword", query = "SELECT l FROM LoginTab l WHERE l.userid = :userid And l.password=:password"),
    @NamedQuery(name = "LoginTab.findByPassword", query = "SELECT l FROM LoginTab l WHERE l.password = :password"),
    @NamedQuery(name = "LoginTab.findByUserrole", query = "SELECT l FROM LoginTab l WHERE l.userrole = :userrole"),
    @NamedQuery(name = "LoginTab.findByCrdate", query = "SELECT l FROM LoginTab l WHERE l.crdate = :crdate"),
    @NamedQuery(name = "LoginTab.findByLastloginDt", query = "SELECT l FROM LoginTab l WHERE l.lastloginDt = :lastloginDt"),
    @NamedQuery(name = "LoginTab.findByFirstName", query = "SELECT l FROM LoginTab l WHERE l.firstName = :firstName"),
    @NamedQuery(name = "LoginTab.findByLastName", query = "SELECT l FROM LoginTab l WHERE l.lastName = :lastName"),
    @NamedQuery(name = "LoginTab.findByCreatedBy", query = "SELECT l FROM LoginTab l WHERE l.createdBy = :createdBy"),
    @NamedQuery(name = "LoginTab.findByDivision", query = "SELECT l FROM LoginTab l WHERE l.division = :division")})
public class LoginTab implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "USERID")
    private String userid;
    @Column(name = "PASSWORD")
    private String password;
    @Column(name = "USERROLE")
    private String userrole;
    @Column(name = "CRDATE")
    @Temporal(TemporalType.DATE)
    private Date crdate;
    @Column(name = "LASTLOGIN_DT")
    @Temporal(TemporalType.DATE)
    private Date lastloginDt;
    @Column(name = "FIRST_NAME")
    private String firstName;
    @Column(name = "LAST_NAME")
    private String lastName;
    @Column(name = "CREATED_BY")
    private String createdBy;
    @Column(name = "DIVISION")
    private String division;

    public LoginTab() {
    }

    public LoginTab(String userid) {
        this.userid = userid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserrole() {
        return userrole;
    }

    public void setUserrole(String userrole) {
        this.userrole = userrole;
    }

    public Date getCrdate() {
        return crdate;
    }

    public void setCrdate(Date crdate) {
        this.crdate = crdate;
    }

    public Date getLastloginDt() {
        return lastloginDt;
    }

    public void setLastloginDt(Date lastloginDt) {
        this.lastloginDt = lastloginDt;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (userid != null ? userid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LoginTab)) {
            return false;
        }
        LoginTab other = (LoginTab) object;
        if ((this.userid == null && other.userid != null) || (this.userid != null && !this.userid.equals(other.userid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.LoginTab[userid=" + userid + "]";
    }
}
