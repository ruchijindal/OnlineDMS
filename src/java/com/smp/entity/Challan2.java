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
 * @author smp-06
 */
@Entity
@Table(name = "CHALLAN2")
@NamedQueries({
    @NamedQuery(name = "Challan2.findByConsNo&Financialyear", query = "SELECT c FROM Challan2 c WHERE TRIM(FROM c.consNo) = :consNo and ( (c.blPerFr = :blPerFr and c.payDate < c.blPerFr) or (c.blPerTo = :blPerTo and (c.payDate is null or c.payDate > :blPerTo ))) and c.blPerFr is not null and c.blPerTo is not null  ORDER BY c.blPerFr"),
    @NamedQuery(name = "Challan2.findByConsNoAndPayDate", query = "SELECT c FROM Challan2 c WHERE TRIM(FROM c.consNo) = :consNo and c.payDate = :payDate"),
    @NamedQuery(name = "Challan2.findByConsNo&BlPerFr&BlPerTo", query = "SELECT c FROM Challan2 c WHERE TRIM(FROM c.consNo) = :consNo and c.payDate >= :blPerFr and c.payDate <= :blPerTo and c.payDate >= c.blPerFr and c.payDate <= c.blPerTo and c.blPerFr is not null and c.blPerTo is not null and c.payDate is not null ORDER BY c.blPerFr"),
    @NamedQuery(name = "Challan2.findBymaxid", query = "SELECT MAX(c.id) FROM Challan1 c"),
    @NamedQuery(name = "Challan2.findAll", query = "SELECT c FROM Challan2 c"),
    @NamedQuery(name = "Challan2.findByConsNo", query = "SELECT c FROM Challan2 c WHERE TRIM(FROM c.consNo) = :consNo ORDER BY c.blPerFr desc"),
    @NamedQuery(name = "Challan2.findByFlatNo", query = "SELECT c FROM Challan2 c WHERE c.flatNo = :flatNo"),
    @NamedQuery(name = "Challan2.findByBlk", query = "SELECT c FROM Challan2 c WHERE c.blk = :blk"),
    @NamedQuery(name = "Challan2.findBySec", query = "SELECT c FROM Challan2 c WHERE c.sec = :sec"),
    @NamedQuery(name = "Challan2.findByBlPerFr", query = "SELECT c FROM Challan2 c WHERE c.blPerFr = :blPerFr"),
    @NamedQuery(name = "Challan2.findByBlPerTo", query = "SELECT c FROM Challan2 c WHERE c.blPerTo = :blPerTo"),
    @NamedQuery(name = "Challan2.findByDueDt", query = "SELECT c FROM Challan2 c WHERE c.dueDt = :dueDt"),
    @NamedQuery(name = "Challan2.findByBillAmt", query = "SELECT c FROM Challan2 c WHERE c.billAmt = :billAmt"),
    @NamedQuery(name = "Challan2.findBySurcharge", query = "SELECT c FROM Challan2 c WHERE c.surcharge = :surcharge"),
    @NamedQuery(name = "Challan2.findByPaidAmt", query = "SELECT c FROM Challan2 c WHERE c.paidAmt = :paidAmt"),
    @NamedQuery(name = "Challan2.findByPayDate", query = "SELECT c FROM Challan2 c WHERE c.payDate = :payDate"),
    @NamedQuery(name = "Challan2.findByArrear", query = "SELECT c FROM Challan2 c WHERE c.arrear = :arrear"),
    @NamedQuery(name = "Challan2.findByCredit", query = "SELECT c FROM Challan2 c WHERE c.credit = :credit"),
    @NamedQuery(name = "Challan2.findByRecpNo", query = "SELECT c FROM Challan2 c WHERE c.recpNo = :recpNo"),
    @NamedQuery(name = "Challan2.findByDisCd", query = "SELECT c FROM Challan2 c WHERE c.disCd = :disCd"),
    @NamedQuery(name = "Challan2.findByNoc", query = "SELECT c FROM Challan2 c WHERE c.noc = :noc"),
    @NamedQuery(name = "Challan2.findByRmc", query = "SELECT c FROM Challan2 c WHERE c.rmc = :rmc"),
    @NamedQuery(name = "Challan2.findBySecu", query = "SELECT c FROM Challan2 c WHERE c.secu = :secu"),
    @NamedQuery(name = "Challan2.findByTFee", query = "SELECT c FROM Challan2 c WHERE c.tFee = :tFee"),
    @NamedQuery(name = "Challan2.findByCss", query = "SELECT c FROM Challan2 c WHERE c.css = :css"),
    @NamedQuery(name = "Challan2.findByBnkCd", query = "SELECT c FROM Challan2 c WHERE c.bnkCd = :bnkCd"),
    @NamedQuery(name = "Challan2.findByBrNm", query = "SELECT c FROM Challan2 c WHERE c.brNm = :brNm"),
    @NamedQuery(name = "Challan2.findByReb", query = "SELECT c FROM Challan2 c WHERE c.reb = :reb"),
    @NamedQuery(name = "Challan2.findById", query = "SELECT c FROM Challan2 c WHERE c.id = :id"),
    @NamedQuery(name = "Challan2.findByCreatedBy", query = "SELECT c FROM Challan2 c WHERE c.createdBy = :createdBy"),
    @NamedQuery(name = "Challan2.findByCreatedDate", query = "SELECT c FROM Challan2 c WHERE c.createdDate = :createdDate"),
    @NamedQuery(name = "Challan2.findByEditedBy", query = "SELECT c FROM Challan2 c WHERE c.editedBy = :editedBy"),
    @NamedQuery(name = "Challan2.findByEditedDate", query = "SELECT c FROM Challan2 c WHERE c.editedDate = :editedDate"),
    @NamedQuery(name = "Challan2.findByAuthoriseBy", query = "SELECT c FROM Challan2 c WHERE c.authoriseBy = :authoriseBy"),
    @NamedQuery(name = "Challan2.findByAuthorisedDate", query = "SELECT c FROM Challan2 c WHERE c.authorizedDate = :authorizedDate"),
    @NamedQuery(name = "Challan2.findBySelectedValues", query = "SELECT c FROM Challan2 c WHERE (:sec is null or  TRIM(from c.sec) = :sec)  and c.status = :status"),
    @NamedQuery(name = "Challan2.findByStatus", query = "SELECT c FROM Challan2 c WHERE c.status = :status")})
public class Challan2 implements Serializable, Challan {

    private static final long serialVersionUID = 1L;
    @Column(name = "CONS_NO")
    private String consNo;
    @Column(name = "FLAT_NO")
    private String flatNo;
    @Column(name = "BLK")
    private String blk;
    @Column(name = "SEC")
    private String sec;
    @Column(name = "BL_PER_FR")
    @Temporal(TemporalType.DATE)
    private Date blPerFr;
    @Column(name = "BL_PER_TO")
    @Temporal(TemporalType.DATE)
    private Date blPerTo;
    @Column(name = "DUE_DT")
    @Temporal(TemporalType.DATE)
    private Date dueDt;
    @Column(name = "BILL_AMT")
    private Double billAmt;
    @Column(name = "SURCHARGE")
    private Double surcharge;
    @Column(name = "PAID_AMT")
    private Double paidAmt;
    @Column(name = "PAY_DATE")
    @Temporal(TemporalType.DATE)
    private Date payDate;
    @Column(name = "ARREAR")
    private Double arrear;
    @Column(name = "CREDIT")
    private Double credit;
    @Column(name = "RECP_NO")
    private String recpNo;
    @Column(name = "DIS_CD")
    private String disCd;
    @Column(name = "NOC")
    private Double noc;
    @Column(name = "RMC")
    private Double rmc;
    @Column(name = "SECU")
    private Double secu;
    @Column(name = "T_FEE")
    private Double tFee;
    @Column(name = "CSS")
    private Double css;
    @Column(name = "BNK_CD")
    private String bnkCd;
    @Column(name = "BR_NM")
    private String brNm;
    @Column(name = "REB")
    private Double reb;
    @Column(name = "DISCOUNT")
    private Double discount;
    @Column(name = "CREATED_BY")
    private String createdBy;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.DATE)
    private Date createdDate;
    @Column(name = "EDITED_BY")
    private String editedBy;
    @Column(name = "AUTHORISE_BY")
    private String authoriseBy;
    @Column(name = "AUTHORISED_DATE")
    @Temporal(TemporalType.DATE)
    private Date authorizedDate;
    @Column(name = "STATUS")
    private String status;
    @Column(name = "EDITED_DATE")
    @Temporal(TemporalType.DATE)
    private Date editedDate;
    @Id
    @Basic(optional = false)
    @Column(name = "ID")
    private Double id;

    public Challan2() {
    }

    public Challan2(Double id) {
        this.id = id;
    }

    public String getConsNo() {
        return consNo;
    }

    public void setConsNo(String consNo) {
        this.consNo = consNo;
    }

    public String getFlatNo() {
        return flatNo;
    }

    public void setFlatNo(String flatNo) {
        this.flatNo = flatNo;
    }

    public String getBlk() {
        return blk;
    }

    public void setBlk(String blk) {
        this.blk = blk;
    }

    public String getSec() {
        return sec;
    }

    public void setSec(String sec) {
        this.sec = sec;
    }

    public Date getBlPerFr() {
        return blPerFr;
    }

    public void setBlPerFr(Date blPerFr) {
        this.blPerFr = blPerFr;
    }

    public Date getBlPerTo() {
        return blPerTo;
    }

    public void setBlPerTo(Date blPerTo) {
        this.blPerTo = blPerTo;
    }

    public Date getDueDt() {
        return dueDt;
    }

    public void setDueDt(Date dueDt) {
        this.dueDt = dueDt;
    }

    public Double getBillAmt() {
        return billAmt;
    }

    public void setBillAmt(Double billAmt) {
        this.billAmt = billAmt;
    }

    public Double getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(Double surcharge) {
        this.surcharge = surcharge;
    }

    public Double getPaidAmt() {
        return paidAmt;
    }

    public void setPaidAmt(Double paidAmt) {
        this.paidAmt = paidAmt;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Double getArrear() {
        return arrear;
    }

    public void setArrear(Double arrear) {
        this.arrear = arrear;
    }

    public Double getCredit() {
        return credit;
    }

    public void setCredit(Double credit) {
        this.credit = credit;
    }

    public String getRecpNo() {
        return recpNo;
    }

    public void setRecpNo(String recpNo) {
        this.recpNo = recpNo;
    }

    public String getDisCd() {
        return disCd;
    }

    public void setDisCd(String disCd) {
        this.disCd = disCd;
    }

    public Double getNoc() {
        return noc;
    }

    public void setNoc(Double noc) {
        this.noc = noc;
    }

    public Double getRmc() {
        return rmc;
    }

    public void setRmc(Double rmc) {
        this.rmc = rmc;
    }

    public Double getSecu() {
        return secu;
    }

    public void setSecu(Double secu) {
        this.secu = secu;
    }

    public Double getTFee() {
        return tFee;
    }

    public void setTFee(Double tFee) {
        this.tFee = tFee;
    }

    public Double getCss() {
        return css;
    }

    public void setCss(Double css) {
        this.css = css;
    }

    public String getBnkCd() {
        return bnkCd;
    }

    public void setBnkCd(String bnkCd) {
        this.bnkCd = bnkCd;
    }

    public String getBrNm() {
        return brNm;
    }

    public void setBrNm(String brNm) {
        this.brNm = brNm;
    }

    public Double getReb() {
        return reb;
    }

    public void setReb(Double reb) {
        this.reb = reb;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
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

    public String getAuthoriseBy() {
        return authoriseBy;
    }

    public void setAuthoriseBy(String authoriseBy) {
        this.authoriseBy = authoriseBy;
    }

    public Date getAuthorizedDate() {
        return authorizedDate;
    }

    public void setAuthorizedDate(Date authorizedDate) {
        this.authorizedDate = authorizedDate;
    }

    public String getEditedBy() {
        return editedBy;
    }

    public void setEditedBy(String editedBy) {
        this.editedBy = editedBy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        if (!(object instanceof Challan2)) {
            return false;
        }
        Challan2 other = (Challan2) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.Challan2[id=" + id + "]";
    }
}
