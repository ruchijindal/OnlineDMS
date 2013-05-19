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
@Table(name = "Billrepository2")
@NamedQueries({
    @NamedQuery(name = "Billrepository2.findBySelectedValue", query = "SELECT b FROM Billrepository2 b WHERE (:id = 0 or b.id = :id ) and (:consNo is null or TRIM(FROM b.consNo) = :consNo) and (:billFrom is null or b.billFrom >= :billFrom) and (:billTo is null or b.billTo <= :billTo)"),
    @NamedQuery(name = "Billrepository2.findDuplicate", query = "SELECT b FROM Billrepository2 b WHERE (TRIM(FROM b.consNo) = :consNo) and (b.billFrom = :billFrom) and (b.billTo = :billTo) and b.rebate= :rebate and b.cessAmount = :cessAmount and b.principal = :principal and b.interest = :interest and b.surcharge = :surcharge and b.security = :security and b.nocFee = :nocFee and b.tFee = :tFee and b.regularFee = :regularFee and b.discount = :discount"),
    @NamedQuery(name = "Billrepository2.findByMaxId", query = "SELECT MAX(b.id) FROM Billrepository2 b"),
    @NamedQuery(name = "Billrepository2.findAll", query = "SELECT b FROM Billrepository2 b"),
    @NamedQuery(name = "Billrepository2.findById", query = "SELECT b FROM Billrepository2 b WHERE b.id = :id "),
    @NamedQuery(name = "Billrepository2.findByConsNo", query = "SELECT b FROM Billrepository2 b WHERE TRIM(FROM b.consNo) = :consNo ORDER BY b.id desc"),
    @NamedQuery(name = "Billrepository2.findByBillFrom", query = "SELECT b FROM Billrepository2 b WHERE b.billFrom = :billFrom"),
    @NamedQuery(name = "Billrepository2.findByBillTo", query = "SELECT b FROM Billrepository2 b WHERE b.billTo = :billTo"),
    @NamedQuery(name = "Billrepository2.findByRate", query = "SELECT b FROM Billrepository2 b WHERE b.rate = :rate"),
    @NamedQuery(name = "Billrepository2.findByRebate", query = "SELECT b FROM Billrepository2 b WHERE b.rebate = :rebate"),
    @NamedQuery(name = "Billrepository2.findByCessAmount", query = "SELECT b FROM Billrepository2 b WHERE b.cessAmount = :cessAmount"),
    @NamedQuery(name = "Billrepository2.findByPrincipal", query = "SELECT b FROM Billrepository2 b WHERE b.principal = :principal"),
    @NamedQuery(name = "Billrepository2.findByInterest", query = "SELECT b FROM Billrepository2 b WHERE b.interest = :interest"),
    @NamedQuery(name = "Billrepository2.findBySurcharge", query = "SELECT b FROM Billrepository2 b WHERE b.surcharge = :surcharge"),
    @NamedQuery(name = "Billrepository2.findBySecurity", query = "SELECT b FROM Billrepository2 b WHERE b.security = :security"),
    @NamedQuery(name = "Billrepository2.findByNocFee", query = "SELECT b FROM Billrepository2 b WHERE b.nocFee = :nocFee"),
    @NamedQuery(name = "Billrepository2.findByTFee", query = "SELECT b FROM Billrepository2 b WHERE b.tFee = :tFee"),
    @NamedQuery(name = "Billrepository2.findByRegularFee", query = "SELECT b FROM Billrepository2 b WHERE b.regularFee = :regularFee"),
    @NamedQuery(name = "Billrepository2.findByCreateBy", query = "SELECT b FROM Billrepository2 b WHERE b.createBy = :createBy"),
    @NamedQuery(name = "Billrepository2.findByCreatedDate", query = "SELECT b FROM Billrepository2 b WHERE b.createdDate = :createdDate"),
    @NamedQuery(name = "Billrepository1.findByDueDate", query = "SELECT b FROM Billrepository1 b WHERE b.dueDate = :dueDate")})
public class Billrepository2 implements Serializable, Billrepository {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private BigDecimal id;
    @Column(name = "CONS_NO")
    private String consNo;
    @Column(name = "BILL_FROM")
    @Temporal(TemporalType.DATE)
    private Date billFrom;
    @Column(name = "BILL_TO")
    @Temporal(TemporalType.DATE)
    private Date billTo;
    @Column(name = "RATE")
    private BigDecimal rate;
    @Column(name = "REBATE")
    private BigDecimal rebate;
    @Column(name = "CESS_AMOUNT")
    private BigDecimal cessAmount;
    @Column(name = "PRINCIPAL")
    private BigDecimal principal;
    @Column(name = "INTEREST")
    private BigDecimal interest;
    @Column(name = "SURCHARGE")
    private Double surcharge;
    @Column(name = "SECURITY")
    private Double security;
    @Column(name = "NOC_FEE")
    private Double nocFee;
    @Column(name = "T_FEE")
    private Double tFee;
    @Column(name = "REGULAR_FEE")
    private Double regularFee;
    @Column(name = "CREATE_BY")
    private String createBy;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.DATE)
    private Date createdDate;
    @Column(name = "DUE_DATE")
    @Temporal(TemporalType.DATE)
    private Date dueDate;
    @Column(name = "DISCOUNT")
    private Double discount;

    public Billrepository2() {
    }

    public Billrepository2(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getConsNo() {
        return consNo;
    }

    public void setConsNo(String consNo) {
        this.consNo = consNo;
    }

    public Date getBillFrom() {
        return billFrom;
    }

    public void setBillFrom(Date billFrom) {
        this.billFrom = billFrom;
    }

    public Date getBillTo() {
        return billTo;
    }

    public void setBillTo(Date billTo) {
        this.billTo = billTo;
    }

    public BigDecimal getRate() {
        return rate;
    }

    public void setRate(BigDecimal rate) {
        this.rate = rate;
    }

    public BigDecimal getRebate() {
        return rebate;
    }

    public void setRebate(BigDecimal rebate) {
        this.rebate = rebate;
    }

    public BigDecimal getCessAmount() {
        return cessAmount;
    }

    public void setCessAmount(BigDecimal cessAmount) {
        this.cessAmount = cessAmount;
    }

    public BigDecimal getPrincipal() {
        return principal;
    }

    public void setPrincipal(BigDecimal principal) {
        this.principal = principal;
    }

    public BigDecimal getInterest() {
        return interest;
    }

    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    public Double getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(Double surcharge) {
        this.surcharge = surcharge;
    }

    public Double getSecurity() {
        return security;
    }

    public void setSecurity(Double security) {
        this.security = security;
    }

    public Double getNocFee() {
        return nocFee;
    }

    public void setNocFee(Double nocFee) {
        this.nocFee = nocFee;
    }

    public Double getTFee() {
        return tFee;
    }

    public void setTFee(Double tFee) {
        this.tFee = tFee;
    }

    public Double getRegularFee() {
        return regularFee;
    }

    public void setRegularFee(Double regularFee) {
        this.regularFee = regularFee;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
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
        if (!(object instanceof Billrepository2)) {
            return false;
        }
        Billrepository2 other = (Billrepository2) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "bill.generator.Billrepository2[id=" + id + "]";
    }
}
