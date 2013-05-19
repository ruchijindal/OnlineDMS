/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.smp.entity;

import java.io.Serializable;
import java.math.BigDecimal;
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
 * @author smp-06
 */
@Entity
@Table(name = "SEWERDETAILS1")
@NamedQueries({
    @NamedQuery(name = "Sewerdetails1.findByMaxId", query = "SELECT MAX(s.id) FROM Sewerdetails1 s"),
    @NamedQuery(name = "Sewerdetails1.findAll", query = "SELECT s FROM Sewerdetails1 s"),
    @NamedQuery(name = "Sewerdetails1.findByConsNo", query = "SELECT s FROM Sewerdetails1 s WHERE TRIM(FROM s.consNo) = :consNo"),
    @NamedQuery(name = "Sewerdetails1.findBySRegNo", query = "SELECT s FROM Sewerdetails1 s WHERE s.sRegNo = :sRegNo"),
    @NamedQuery(name = "Sewerdetails1.findBySConDt", query = "SELECT s FROM Sewerdetails1 s WHERE s.sConDt = :sConDt"),
    @NamedQuery(name = "Sewerdetails1.findBySEstNo", query = "SELECT s FROM Sewerdetails1 s WHERE s.sEstNo = :sEstNo"),
    @NamedQuery(name = "Sewerdetails1.findBySEstAmt", query = "SELECT s FROM Sewerdetails1 s WHERE s.sEstAmt = :sEstAmt"),
    @NamedQuery(name = "Sewerdetails1.findBySSecu", query = "SELECT s FROM Sewerdetails1 s WHERE s.sSecu = :sSecu"),
    @NamedQuery(name = "Sewerdetails1.findBySEstPamt", query = "SELECT s FROM Sewerdetails1 s WHERE s.sEstPamt = :sEstPamt"),
    @NamedQuery(name = "Sewerdetails1.findBySEstPdate", query = "SELECT s FROM Sewerdetails1 s WHERE s.sEstPdate = :sEstPdate"),
    @NamedQuery(name = "Sewerdetails1.findBySNodueDt", query = "SELECT s FROM Sewerdetails1 s WHERE s.sNodueDt = :sNodueDt"),
    @NamedQuery(name = "Sewerdetails1.findBySNodueAmt", query = "SELECT s FROM Sewerdetails1 s WHERE s.sNodueAmt = :sNodueAmt"),
    @NamedQuery(name = "Sewerdetails1.findById", query = "SELECT s FROM Sewerdetails1 s WHERE s.id = :id"),
    @NamedQuery(name = "Sewerdetails1.findByCreatedBy", query = "SELECT s FROM Sewerdetails1 s WHERE s.createdBy = :createdBy"),
    @NamedQuery(name = "Sewerdetails1.findByCreatedDate", query = "SELECT s FROM Sewerdetails1 s WHERE s.createdDate = :createdDate"),
    @NamedQuery(name = "Sewerdetails1.findByEditedBy", query = "SELECT s FROM Sewerdetails1 s WHERE s.editedBy = :editedBy"),
    @NamedQuery(name = "Sewerdetails1.findByEditedDate", query = "SELECT s FROM Sewerdetails1 s WHERE s.editedDate = :editedDate")
})
public class Sewerdetails1 implements Serializable, Sewerdetails {

    private static final long serialVersionUID = 1L;
    @Column(name = "CONS_NO")
    private String consNo;
    @Column(name = "S_REG_NO")
    private String sRegNo;
    @Column(name = "S_CON_DT")
    @Temporal(TemporalType.DATE)
    private Date sConDt;
    @Column(name = "S_EST_NO")
    private String sEstNo;
    @Column(name = "S_EST_AMT")
    private Integer sEstAmt;
    @Column(name = "S_SECU")
    private Integer sSecu;
    @Column(name = "S_EST_PAMT")
    private Integer sEstPamt;
    @Column(name = "S_EST_PDATE")
    @Temporal(TemporalType.DATE)
    private Date sEstPdate;
    @Column(name = "S_NODUE_DT")
    @Temporal(TemporalType.DATE)
    private Date sNodueDt;
    @Column(name = "S_NODUE_AMT")
    private Integer sNodueAmt;
    @Column(name = "CREATED_BY")
    private String createdBy;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.DATE)
    private Date createdDate;
    @Column(name = "EDITED_BY")
    private String editedBy;
    @Column(name = "EDITED_DATE")
    @Temporal(TemporalType.DATE)
    private Date editedDate;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private Double id;

    public Sewerdetails1() {
    }

    public Sewerdetails1(Double id) {
        this.id = id;
    }

    public String getConsNo() {
        return consNo;
    }

    public void setConsNo(String consNo) {
        this.consNo = consNo;
    }

    public String getSRegNo() {
        return sRegNo;
    }

    public void setSRegNo(String sRegNo) {
        this.sRegNo = sRegNo;
    }

    public Date getSConDt() {
        return sConDt;
    }

    public void setSConDt(Date sConDt) {
        this.sConDt = sConDt;
    }

    public String getSEstNo() {
        return sEstNo;
    }

    public void setSEstNo(String sEstNo) {
        this.sEstNo = sEstNo;
    }

    public Integer getSEstAmt() {
        return sEstAmt;
    }

    public void setSEstAmt(Integer sEstAmt) {
        this.sEstAmt = sEstAmt;
    }

    public Integer getSSecu() {
        return sSecu;
    }

    public void setSSecu(Integer sSecu) {
        this.sSecu = sSecu;
    }

    public Integer getSEstPamt() {
        return sEstPamt;
    }

    public void setSEstPamt(Integer sEstPamt) {
        this.sEstPamt = sEstPamt;
    }

    public Date getSEstPdate() {
        return sEstPdate;
    }

    public void setSEstPdate(Date sEstPdate) {
        this.sEstPdate = sEstPdate;
    }

    public Date getSNodueDt() {
        return sNodueDt;
    }

    public void setSNodueDt(Date sNodueDt) {
        this.sNodueDt = sNodueDt;
    }

    public Integer getSNodueAmt() {
        return sNodueAmt;
    }

    public void setSNodueAmt(Integer sNodueAmt) {
        this.sNodueAmt = sNodueAmt;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getEditedBy() {
        return editedBy;
    }

    public void setEditedBy(String editedBy) {
        this.editedBy = editedBy;
    }

    public Date getEditedDate() {
        return editedDate;
    }

    public void setEditedDate(Date editedDate) {
        this.editedDate = editedDate;
    }

    public Double getId() {
        return id;
    }

    public void setId(Double id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Sewerdetails1)) {
            return false;
        }
        Sewerdetails1 other = (Sewerdetails1) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.Sewerdetails1[id=" + id + "]";
    }
}
