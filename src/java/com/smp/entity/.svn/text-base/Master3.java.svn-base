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
@Table(name = "MASTER3")
@NamedQueries({
    @NamedQuery(name = "Master3.findByConsNoWithConditions", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.consNo) = :consNo and m.consNm1 is not null and m.conTp is not null and m.consCtg is not null and m.pipeSize is not null and (m.calDate is not null or m.nodueDt is not null) and (m.status is null or m.status = 'A') ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findBySector&Block&connType", query = "SELECT m FROM Master3 m WHERE  TRIM(from m.sector) = :sector and (:blkNo is null or TRIM(FROM m.blkNo) = :blkNo) and (:conTp is null or m.conTp = :conTp) and m.consNm1 is not null and m.conTp is not null and m.consCtg is not null and m.pipeSize is not null and (m.calDate is not null or m.nodueDt is not null) and (m.status is null or m.status = 'A') ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findBetweenConsNo", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.consNo) >= :minConsNo and TRIM(FROM m.consNo) <= :maxConsNo and (m.status is null or m.status = 'A') ORDER BY m.consNo "),
    @NamedQuery(name = "Master3.findBySectorDistinct", query = "SELECT DISTINCT(m.blkNo) FROM Master3 m WHERE TRIM(FROM m.sector) = :sector ORDER BY m.blkNo "),
    @NamedQuery(name = "Master3.findBySectorAndBlkNo", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.sector) = :sector AND TRIM(FROM m.blkNo)= :blkNo ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findBySectorAndBlkNoAndFlatNo", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.sector) = :sector AND TRIM(FROM m.blkNo)= :blkNo AND TRIM(FROM m.flatNo)= :flatNo ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findAll", query = "SELECT m FROM Master3 m"),
    @NamedQuery(name = "Master3.findByMaxId", query = "SELECT MAX(m.id) FROM Master3 m "),
    @NamedQuery(name = "Master3.findByConsNo", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.consNo) = :consNo"),
    @NamedQuery(name = "Master3.findByConsNm1", query = "SELECT m FROM Master3 m WHERE m.consNm1 = :consNm1"),
    @NamedQuery(name = "Master3.findByConsNm2", query = "SELECT m FROM Master3 m WHERE m.consNm2 = :consNm2"),
    @NamedQuery(name = "Master3.findByConTp", query = "SELECT m FROM Master3 m WHERE m.conTp = :conTp"),
    @NamedQuery(name = "Master3.findByConsCtg", query = "SELECT m FROM Master3 m WHERE m.consCtg = :consCtg"),
    @NamedQuery(name = "Master3.findByFlatType", query = "SELECT m FROM Master3 m WHERE m.flatType = :flatType"),
    @NamedQuery(name = "Master3.findByFlatNo", query = "SELECT m FROM Master3 m WHERE m.flatNo = :flatNo"),
    @NamedQuery(name = "Master3.findByBlkNo", query = "SELECT m FROM Master3 m WHERE m.blkNo = :blkNo"),
    @NamedQuery(name = "Master3.findBySector", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.sector) = :sector and (m.conTp is not null) and (m.consCtg is not null) and (m.pipeSize is not null) and (m.calDate is not null or m.nodueDt is not null) ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findError", query = "SELECT m FROM Master3 m WHERE TRIM(FROM m.sector) = :sector ORDER BY m.consNo"),
    @NamedQuery(name = "Master3.findByPlotSize", query = "SELECT m FROM Master3 m WHERE m.plotSize = :plotSize"),
    @NamedQuery(name = "Master3.findByPipeSize", query = "SELECT m FROM Master3 m WHERE m.pipeSize = :pipeSize"),
    @NamedQuery(name = "Master3.findByRegNo", query = "SELECT m FROM Master3 m WHERE m.regNo = :regNo"),
    @NamedQuery(name = "Master3.findByConnDt", query = "SELECT m FROM Master3 m WHERE m.connDt = :connDt"),
    @NamedQuery(name = "Master3.findByEstiNo", query = "SELECT m FROM Master3 m WHERE m.estiNo = :estiNo"),
    @NamedQuery(name = "Master3.findByEstiAmt", query = "SELECT m FROM Master3 m WHERE m.estiAmt = :estiAmt"),
    @NamedQuery(name = "Master3.findBySecu", query = "SELECT m FROM Master3 m WHERE m.secu = :secu"),
    @NamedQuery(name = "Master3.findByEstiDt", query = "SELECT m FROM Master3 m WHERE m.estiDt = :estiDt"),
    @NamedQuery(name = "Master3.findByEsti1Amt", query = "SELECT m FROM Master3 m WHERE m.esti1Amt = :esti1Amt"),
    @NamedQuery(name = "Master3.findByNodueAmt", query = "SELECT m FROM Master3 m WHERE m.nodueAmt = :nodueAmt"),
    @NamedQuery(name = "Master3.findByNodueDt", query = "SELECT m FROM Master3 m WHERE m.nodueDt = :nodueDt"),
    @NamedQuery(name = "Master3.findByTransNm", query = "SELECT m FROM Master3 m WHERE m.transNm = :transNm"),
    @NamedQuery(name = "Master3.findByTrf", query = "SELECT m FROM Master3 m WHERE m.trf = :trf"),
    @NamedQuery(name = "Master3.findByCalDate", query = "SELECT m FROM Master3 m WHERE m.calDate = :calDate"),
    @NamedQuery(name = "Master3.findByPosDate", query = "SELECT m FROM Master3 m WHERE m.posDate = :posDate"),
    @NamedQuery(name = "Master3.findByCompDate", query = "SELECT m FROM Master3 m WHERE m.compDate = :compDate"),
    @NamedQuery(name = "Master3.findById", query = "SELECT m FROM Master3 m WHERE m.id = :id"),
    @NamedQuery(name = "Master3.findByCreatedBy", query = "SELECT m FROM Master3 m WHERE m.createdBy = :createdBy"),
    @NamedQuery(name = "Master3.findByCreatedDate", query = "SELECT m FROM Master3 m WHERE m.createdDate = :createdDate"),
    @NamedQuery(name = "Master3.findByEditedBy", query = "SELECT m FROM Master3 m WHERE m.editedBy = :editedBy"),
    @NamedQuery(name = "Master3.findByEditedDate", query = "SELECT m FROM Master3 m WHERE m.editedDate = :editedDate"),
    @NamedQuery(name = "Master3.findByAuthoriseBy", query = "SELECT m FROM Master3 m WHERE m.authoriseBy = :authoriseBy"),
    @NamedQuery(name = "Master3.findByAuthorisedDate", query = "SELECT m FROM Master3 m WHERE m.authorizedDate = :authorizedDate"),
    @NamedQuery(name = "Master3.findBySelectedValues", query = "SELECT m FROM Master3 m WHERE (:sector is null or  TRIM(from m.sector) = :sector)  and m.status = :status"),
    @NamedQuery(name = "Master3.findByStatus", query = "SELECT m FROM Master3 m WHERE m.status = :status")})
public class Master3 implements Serializable, Master {

    private static final long serialVersionUID = 1L;
    @Column(name = "CONS_NO")
    private String consNo;
    @Column(name = "CONS_NM1")
    private String consNm1;
    @Column(name = "CONS_NM2")
    private String consNm2;
    @Column(name = "CON_TP")
    private String conTp;
    @Column(name = "CONS_CTG")
    private String consCtg;
    @Column(name = "FLAT_TYPE")
    private String flatType;
    @Column(name = "FLAT_NO")
    private String flatNo;
    @Column(name = "BLK_NO")
    private String blkNo;
    @Column(name = "SECTOR")
    private String sector;
    @Column(name = "PLOT_SIZE")
    private BigDecimal plotSize;
    @Column(name = "PIPE_SIZE")
    private BigDecimal pipeSize;
    @Column(name = "REG_NO")
    private String regNo;
    @Column(name = "CONN_DT")
    @Temporal(TemporalType.DATE)
    private Date connDt;
    @Column(name = "ESTI_NO")
    private String estiNo;
    @Column(name = "ESTI_AMT")
    private BigDecimal estiAmt;
    @Column(name = "SECU")
    private BigDecimal secu;
    @Column(name = "ESTI_DT")
    @Temporal(TemporalType.DATE)
    private Date estiDt;
    @Column(name = "ESTI1_AMT")
    private BigDecimal esti1Amt;
    @Column(name = "NODUE_AMT")
    private BigDecimal nodueAmt;
    @Column(name = "NODUE_DT")
    @Temporal(TemporalType.DATE)
    private Date nodueDt;
    @Column(name = "TRANS_NM")
    private String transNm;
    @Column(name = "TRF")
    private String trf;
    @Column(name = "CAL_DATE")
    @Temporal(TemporalType.DATE)
    private Date calDate;
    @Column(name = "POS_DATE")
    @Temporal(TemporalType.DATE)
    private Date posDate;
    @Column(name = "COMP_DATE")
    @Temporal(TemporalType.DATE)
    private Date compDate;
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
    private BigDecimal id;

    public Master3() {
    }

    public Master3(BigDecimal id) {
        this.id = id;
    }

    public String getConsNo() {
        return consNo;
    }

    public void setConsNo(String consNo) {
        this.consNo = consNo;
    }

    public String getConsNm1() {
        return consNm1;
    }

    public void setConsNm1(String consNm1) {
        this.consNm1 = consNm1;
    }

    public String getConsNm2() {
        return consNm2;
    }

    public void setConsNm2(String consNm2) {
        this.consNm2 = consNm2;
    }

    public String getConTp() {
        return conTp;
    }

    public void setConTp(String conTp) {
        this.conTp = conTp;
    }

    public String getConsCtg() {
        return consCtg;
    }

    public void setConsCtg(String consCtg) {
        this.consCtg = consCtg;
    }

    public String getFlatType() {
        return flatType;
    }

    public void setFlatType(String flatType) {
        this.flatType = flatType;
    }

    public String getFlatNo() {
        return flatNo;
    }

    public void setFlatNo(String flatNo) {
        this.flatNo = flatNo;
    }

    public String getBlkNo() {
        return blkNo;
    }

    public void setBlkNo(String blkNo) {
        this.blkNo = blkNo;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public BigDecimal getPlotSize() {
        return plotSize;
    }

    public void setPlotSize(BigDecimal plotSize) {
        this.plotSize = plotSize;
    }

    public BigDecimal getPipeSize() {
        return pipeSize;
    }

    public void setPipeSize(BigDecimal pipeSize) {
        this.pipeSize = pipeSize;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public Date getConnDt() {
        return connDt;
    }

    public void setConnDt(Date connDt) {
        this.connDt = connDt;
    }

    public String getEstiNo() {
        return estiNo;
    }

    public void setEstiNo(String estiNo) {
        this.estiNo = estiNo;
    }

    public BigDecimal getEstiAmt() {
        return estiAmt;
    }

    public void setEstiAmt(BigDecimal estiAmt) {
        this.estiAmt = estiAmt;
    }

    public BigDecimal getSecu() {
        return secu;
    }

    public void setSecu(BigDecimal secu) {
        this.secu = secu;
    }

    public Date getEstiDt() {
        return estiDt;
    }

    public void setEstiDt(Date estiDt) {
        this.estiDt = estiDt;
    }

    public BigDecimal getEsti1Amt() {
        return esti1Amt;
    }

    public void setEsti1Amt(BigDecimal esti1Amt) {
        this.esti1Amt = esti1Amt;
    }

    public BigDecimal getNodueAmt() {
        return nodueAmt;
    }

    public void setNodueAmt(BigDecimal nodueAmt) {
        this.nodueAmt = nodueAmt;
    }

    public Date getNodueDt() {
        return nodueDt;
    }

    public void setNodueDt(Date nodueDt) {
        this.nodueDt = nodueDt;
    }

    public String getTransNm() {
        return transNm;
    }

    public void setTransNm(String transNm) {
        this.transNm = transNm;
    }

    public String getTrf() {
        return trf;
    }

    public void setTrf(String trf) {
        this.trf = trf;
    }

    public Date getCalDate() {
        return calDate;
    }

    public void setCalDate(Date calDate) {
        this.calDate = calDate;
    }

    public Date getPosDate() {
        return posDate;
    }

    public void setPosDate(Date posDate) {
        this.posDate = posDate;
    }

    public Date getCompDate() {
        return compDate;
    }

    public void setCompDate(Date compDate) {
        this.compDate = compDate;
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

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
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
        if (!(object instanceof Master3)) {
            return false;
        }
        Master3 other = (Master3) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.smp.entity.Master3[id=" + id + "]";
    }
}
